import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/home/landlord/create_hostel/step_ten.dart' show CreateHostelModal;

class EditStepTen extends StatefulWidget {
  final HostelInfoData info;

  const EditStepTen({
    super.key,
    required this.info,
  });

  @override
  State<EditStepTen> createState() => _EditStepTenState();
}

class _EditStepTenState extends State<EditStepTen> {
  late List<int> totalProps;
  late List<dynamic> media;
  late List<String> facilities, rules;
  late List<RoomInfoData> rooms;
  late int availableRooms, totalRooms;
  late bool vacantRooms;

  String minBudget = '0.0', maxBudget = "0.0", address = "";

  @override
  void initState() {
    super.initState();
    rooms = widget.info.rooms;
    totalProps = calculate(rooms);

    media = widget.info.media;
    facilities = widget.info.hostelFacilities;
    rules = widget.info.rules;

    availableRooms = rooms.length;
    totalRooms = widget.info.totalRooms;
    vacantRooms = widget.info.vacantRooms;

    List<String> parts = widget.info.address.split("#");
    address = "${parts[0]}, ${parts[1]}, ${parts[2]}, ${parts[3]}";
  }

  List<int> calculate(List<RoomInfoData> rooms) {
    int baths = 0, kitchens = 0, toilets = 0;

    double minPrice = 0.0, maxPrice = 0.0;

    for (RoomInfoData info in rooms) {
      List<String> facilities = info.facilities;
      if (facilities.contains("Toilet")) {
        ++toilets;
      }
      if (facilities.contains("Kitchen")) {
        ++kitchens;
      }
      if (facilities.contains("Bathroom")) {
        ++baths;
      }

      if (info.price <= minPrice) {
        minPrice = info.price;
      }

      if (info.price >= maxPrice) {
        maxPrice = info.price;
      }
    }

    maxBudget = maxPrice.toStringAsFixed(0);
    minBudget = minPrice.toStringAsFixed(0);

    return [
      baths,
      toilets,
      kitchens,
    ];
  }

  bool isLocal(int index) => media[index]! is String;

  void navigate() => showModalBottomSheet(
    context: context,
    builder: (context) => CreateHostelModal(vacancy: vacantRooms),
    isDismissible: false,
  ).then(
        (resp) {
      context.router.goNamed(Pages.ownerDashboard);
    },
  );

  void create() {
    context.router
        .pushNamed(Pages.uploadHostel, extra: widget.info)
        .then((resp) {
      bool? status = resp as bool?;
      if (status == null || !status) return;
      navigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: Column(
                children: [
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: 414.w,
                    child: LinearProgressIndicator(
                      value: (vacantRooms ? 9 : 11) / totalPages,
                      color: appBlue,
                      minHeight: 1.5.h,
                    ),
                  ),
                  SizedBox(height: 18.h),
                ],
              ),
              automaticallyImplyLeading: false,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "STEP ${!vacantRooms ? "9" : "11"}",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appBlue,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Preview",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Before going live, get a preview of your hostel details and ensure your "
                          "listing is (are) ready to impress potential tenants.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack75,
                      ),
                    ),
                    SizedBox(height: 44.h),
                  ],
                ),
              ),
            ),
          ],
          body: Container(
            width: 300.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FBFF),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFE0E5EC),
                  blurRadius: 6.0,
                  spreadRadius: 1.0,
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            File(media.first.path),
                            width: 414.w,
                            height: 156.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250.w,
                              child: Text(
                                widget.info.name,
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack,
                                ),
                              ),
                            ),
                            Container(
                              width: 90.w,
                              height: 25.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: infoRoomsLeftBackground,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                "$availableRooms/$totalRooms rooms left",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: infoRoomsLeft,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          address,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Hostel Info Bed.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "$availableRooms",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Hostel Info Bath.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${totalProps[0]}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Toilet.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${totalProps[1]}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Kitchen.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${totalProps[2]}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Hostel Info Area.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${(widget.info.area).toStringAsFixed(0)} sqft",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        if (minBudget.isNotEmpty && maxBudget.isNotEmpty)
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  "${currency()}${minBudget}k - ${currency()}${maxBudget}k",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "/year",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        SizedBox(height: 16.h),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 414.w,
                            minHeight: 1.h,
                            maxWidth: 414.w,
                            maxHeight: 1.h,
                          ),
                          child: const ColoredBox(color: Colors.black12),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Description",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          widget.info.description,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Rules & Regulations",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            rules.length,
                                (index) => Text(
                              "${index + 1}. ${rules[index]}",
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Hostel Facilities",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5.r,
                        mainAxisSpacing: 5.r,
                        mainAxisExtent: 105.r),
                    itemCount: facilities.length,
                    itemBuilder: (_, index) => FacilityContainer(
                      text: facilities[index],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        if (rooms.isNotEmpty)
                          Text(
                            "Available Rooms",
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: weirdBlack,
                            ),
                          ),
                        if (rooms.isNotEmpty) SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                if (rooms.isNotEmpty)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.r,
                        mainAxisSpacing: 15.r,
                        mainAxisExtent: 205.h,
                      ),
                      itemCount: rooms.length,
                      itemBuilder: (_, index) => AvailableRoomCard(
                        infoData: rooms[index],
                        onTap: () {},
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (rooms.isNotEmpty) SizedBox(height: 16.h),
                        Text(
                          "Gallery",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.r,
                      mainAxisSpacing: 10.r,
                      mainAxisExtent: 110.r,
                    ),
                    itemCount: media.length,
                    itemBuilder: (_, index) => isLocal(index)
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.file(
                        File(media[index].path),
                        width: 110.r,
                        height: 110.r,
                        fit: BoxFit.cover,
                      ),
                    )
                        : CachedNetworkImage(
                      imageUrl: media[index],
                      errorWidget: (context, url, error) => Container(
                        width: 110.r,
                        height: 110.r,
                        color: weirdBlack50,
                      ),
                      progressIndicatorBuilder:
                          (context, url, download) => Container(
                        width: 110.r,
                        height: 110.r,
                        color: weirdBlack50,
                        alignment: Alignment.center,
                        child: loader,
                      ),
                      imageBuilder: (context, provider) => Container(
                        width: 110.r,
                        height: 110.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: 414.w,
        height: 90.h,
        color: paleBlue,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => context.router.pop(),
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: appBlue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_left_rounded,
                        color: appBlue, size: 26.r),
                    SizedBox(width: 5.w),
                    Text(
                      "Go back",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: appBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: create,
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: appBlue,
                ),
                child: Text(
                  !vacantRooms ? "Create" : "Launch",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
