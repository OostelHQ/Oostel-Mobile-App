import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/api/hostel_service.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';


class StepTen extends StatefulWidget {
  final Map<String, dynamic> info;

  const StepTen({
    super.key,
    required this.info,
  });

  @override
  State<StepTen> createState() => _StepTenState();
}

class _StepTenState extends State<StepTen> {
  late List<int> totalProps;
  late List<SingleFileResponse> media;
  late List<String> facilities, rules;
  late List<Map<String, dynamic>> rooms;
  late int availableRooms, totalRooms;
  late bool vacantRooms;

  late String minBudget, maxBudget;

  @override
  void initState() {
    super.initState();
    rooms = toRoomList(widget.info["rooms"]);
    totalProps = calculate(rooms);

    media = toDataList(widget.info["medias"]);
    facilities = toStringList(widget.info["FacilityName"]);
    rules = toStringList(widget.info["RuleAndRegulation"]);

    availableRooms = rooms.length;
    totalRooms = widget.info["totalRoom"];
    vacantRooms = widget.info["isAnyRoomVacant"];

    minBudget = "";
    maxBudget = "";
  }

  List<int> calculate(List<Map<String, dynamic>> rooms) {
    int baths = 0, kitchens = 0, toilets = 0;

    for (Map<String, dynamic> info in rooms) {
      List<String> facilities = info["facilities"];
      if (facilities.contains("Toilet")) {
        ++toilets;
      }
      if (facilities.contains("Kitchen")) {
        ++kitchens;
      }
      if (facilities.contains("Bathroom")) {
        ++baths;
      }
    }

    return [
      baths,
      toilets,
      kitchens,
    ];
  }

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
                                widget.info["hostelName"],
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
                                  fontSize: 10.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "${widget.info["street"].trim()}, ${widget.info["junction"].trim()}, ${widget.info["state"].trim()}, ${widget.info["country"]}",
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
                                  "${(widget.info["homeSize"]).toStringAsFixed(0)} sqft",
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
                          widget.info["hostelDescription"],
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
                        infoMap: rooms[index],
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
                    itemBuilder: (_, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.file(
                        File(media[index].path),
                        width: 110.r,
                        height: 110.r,
                        fit: BoxFit.cover,
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

class CreateHostelModal extends StatelessWidget {
  final bool vacancy;

  const CreateHostelModal({super.key, required this.vacancy});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      width: 414.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  SvgPicture.asset("assets/images/Modal Line.svg"),
                  SizedBox(height: 55.h),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r),
                      ),
                      child: Image.asset(
                        "assets/images/Hostel ${vacancy ? "Launch" : "Created"}.png",
                        width: 135.r,
                        height: 135.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Hostel ${vacancy ? "Launched" : "Created"} Successfully",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    vacancy
                        ? "Congratulations! Your hostel listing is now live and ready "
                        "for tenant inquiries. Welcome guests to your property."
                        : "Great news! Your hostel is successfully created. Start attracting tenants by "
                        "listing the vacancy rooms and managing your property effortlessly.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 42.h),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.router.pop(),
                      child: Container(
                        width: 414.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appBlue,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          "Ok, thanks",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadHostelPage extends StatefulWidget {
  final Map<String, dynamic> info;

  const UploadHostelPage({super.key, required this.info});

  @override
  State<UploadHostelPage> createState() => _UploadHostelPageState();
}

class _UploadHostelPageState extends State<UploadHostelPage> {
  bool hasError = false, createdHostel = false;
  int progress = 0, total = 0;
  String message = "", hostelId = "";

  late List<dynamic> rooms;

  @override
  void initState() {
    super.initState();
    bool vacantRooms = widget.info["isAnyRoomVacant"];
    rooms = widget.info["rooms"];
    message = "Creating your hostel";
    if (!vacantRooms) {
      total = 1;
    } else {
      total = rooms.length + 1;
    }

    upload();
  }

  void upload() async {
    createHostel(widget.info).then((resp) {
      if (!mounted) return;
      if (!resp.success) {
        showError(resp.message);
        setState(
                () => message = "An error occurred while creating your hostel");
        Navigator.of(context).pop();
      } else {
        setState(() {
          createdHostel = true;
          hostelId = resp.payload!;
          progress = 1;
        });

        if (progress == total) {
          exit();
          return;
        } else {
          uploadRooms();
        }
      }
    });
  }

  void exit() => context.router.pop(true);

  void uploadRooms() async {
    for (int i = progress - 1; i < rooms.length; ++i) {
      setState(() => message = "Uploading ${rooms[i]["name"]}");

      FyndaResponse response = await createRoomForHostel(
        userID: widget.info["landlordId"],
        hostelID: hostelId,
        map: rooms[i],
      );

      setState(() {
        if (!mounted) return;
        hasError = !response.success;
        if (hasError) {
          setState(() => message =
          "An error occurred while uploading ${rooms[i]["name"]}");
          return;
        } else {
          progress++;
        }
      });

      if (progress == total) {
        exit();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${((progress / total) * 100).toStringAsFixed(1)}%",
                style: context.textTheme.bodyMedium!.copyWith(
                  color: appBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h),
              if (!hasError)
                SizedBox(
                  width: 250.w,
                  child: LinearProgressIndicator(
                    value: (progress / total).roundToDouble(),
                    color: appBlue,
                    backgroundColor: paleBlue,
                    minHeight: 10.h,
                    borderRadius: BorderRadius.circular(5.h),
                  ),
                ),
              if (hasError)
                Center(child: SvgPicture.asset("assets/images/Error.svg")),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!hasError)
                    SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: const CircularProgressIndicator(
                          color: appBlue, strokeWidth: 3),
                    ),
                  if (!hasError) SizedBox(width: 10.w),
                  Text(
                    message,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: hasError ? weirdBlack : appBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: hasError
          ? Container(
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
              onTap: () {
                if (!createdHostel) {
                  setState(() => message = "Creating your hostel");
                  upload();
                } else {
                  uploadRooms();
                }
              },
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: appBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Retry",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(Boxicons.bx_redo,
                        color: Colors.white, size: 26.r),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
          : null,
    );
  }
}



//class StepTen extends StatelessWidget {
//   final Map<String, dynamic> info;
//
//   const StepTen({
//     super.key,
//     required this.info,
//   });
//
//   List<int> calculate(List<RoomInfo> rooms) {
//     int baths = 0, kitchens = 0, toilets = 0;
//
//     for (RoomInfo info in rooms) {
//       List<String> facilities = info.facilities;
//       if (facilities.contains("Toilet")) {
//         ++toilets;
//       }
//       if (facilities.contains("Kitchen")) {
//         ++kitchens;
//       }
//       if (facilities.contains("Bathroom")) {
//         ++baths;
//       }
//     }
//
//     return [
//       baths,
//       toilets,
//       kitchens,
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> media = toStringList(info["media"]);
//     List<String> facilities = toStringList(info["hostelFacilities"]);
//     List<String> rules = toStringList(info["rules"]);
//     List<RoomInfo> rooms = toRoomList(info["roomsLeft"]);
//     int availableRooms = rooms.length;
//     int totalRooms = info["totalRooms"];
//
//     List<int> totalProps = calculate(rooms);
//
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         title: Column(
//           children: [
//             SizedBox(height: 25.h),
//             SizedBox(
//               width: 414.w,
//               child: LinearProgressIndicator(
//                 value: 1.0,
//                 color: appBlue,
//                 minHeight: 1.5.h,
//               ),
//             ),
//             SizedBox(height: 18.h),
//           ],
//         ),
//         automaticallyImplyLeading: false,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     "STEP 10",
//                     style: context.textTheme.bodyMedium!.copyWith(
//                       fontWeight: FontWeight.w500,
//                       color: appBlue,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 12.h),
//                 Center(
//                   child: Text(
//                     "Preview",
//                     style: context.textTheme.bodyLarge!.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: weirdBlack,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 12.h),
//                 Center(
//                   child: Text(
//                     "Before going live, get a preview of your hostel details and ensure your "
//                     "listing is (are) ready to impress potential tenants.",
//                     textAlign: TextAlign.center,
//                     style: context.textTheme.bodyMedium!.copyWith(
//                       fontWeight: FontWeight.w500,
//                       color: weirdBlack75,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 44.h),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF8FBFF),
//                     borderRadius: BorderRadius.circular(10.r),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color(0xFFE0E5EC),
//                         blurRadius: 6.0,
//                         spreadRadius: 1.0,
//                       )
//                     ],
//                   ),
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8.r),
//                         child: Image.memory(
//                           info["image"],
//                           width: 414.w,
//                           height: 156.h,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       SizedBox(height: 12.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             width: 250.w,
//                             child: Text(
//                               info["name"],
//                               style: context.textTheme.bodyLarge!.copyWith(
//                                 fontWeight: FontWeight.w600,
//                                 color: weirdBlack,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 90.w,
//                             height: 25.h,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: infoRoomsLeftBackground,
//                               borderRadius: BorderRadius.circular(5.r),
//                             ),
//                             child: Text(
//                               "$availableRooms/$totalRooms rooms left",
//                               style: context.textTheme.bodyMedium!.copyWith(
//                                 color: infoRoomsLeft,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 13.sp,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         joinToAddress(info["address"]),
//                         overflow: TextOverflow.ellipsis,
//                         style: context.textTheme.bodyMedium!.copyWith(
//                             color: weirdBlack75, fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(height: 8.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/images/Hostel Info Bed.svg",
//                                 width: 15.r,
//                                 height: 15.r,
//                                 color: weirdBlack50,
//                               ),
//                               SizedBox(width: 5.w),
//                               Text(
//                                 "$availableRooms",
//                                 style: context.textTheme.bodySmall!.copyWith(
//                                     color: weirdBlack50,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/images/Hostel Info Bath.svg",
//                                 width: 15.r,
//                                 height: 15.r,
//                                 color: weirdBlack50,
//                               ),
//                               SizedBox(width: 5.w),
//                               Text(
//                                 "${totalProps[0]}",
//                                 style: context.textTheme.bodySmall!.copyWith(
//                                     color: weirdBlack50,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/images/Toilet.svg",
//                                 width: 15.r,
//                                 height: 15.r,
//                                 color: weirdBlack50,
//                               ),
//                               SizedBox(width: 5.w),
//                               Text(
//                                 "${totalProps[1]}",
//                                 style: context.textTheme.bodySmall!.copyWith(
//                                     color: weirdBlack50,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/images/Kitchen.svg",
//                                 width: 15.r,
//                                 height: 15.r,
//                                 color: weirdBlack50,
//                               ),
//                               SizedBox(width: 5.w),
//                               Text(
//                                 "${totalProps[2]}",
//                                 style: context.textTheme.bodySmall!.copyWith(
//                                     color: weirdBlack50,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/images/Hostel Info Area.svg",
//                                 width: 15.r,
//                                 height: 15.r,
//                                 color: weirdBlack50,
//                               ),
//                               SizedBox(width: 5.w),
//                               Text(
//                                 "${(info["area"]).toStringAsFixed(0)} sqft",
//                                 style: context.textTheme.bodySmall!.copyWith(
//                                     color: weirdBlack50,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8.h),
//                       RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text:
//                                   "${currency()} ${formatAmountInDouble(info["price"])}",
//                               style: context.textTheme.bodyLarge!.copyWith(
//                                 color: appBlue,
//                                 fontFamily: "Inter",
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             TextSpan(
//                               text: "/year",
//                               style: context.textTheme.bodyMedium!.copyWith(
//                                 color: appBlue,
//                                 fontFamily: "Inter",
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                       ConstrainedBox(
//                         constraints: BoxConstraints(
//                           minWidth: 414.w,
//                           minHeight: 1.h,
//                           maxWidth: 414.w,
//                           maxHeight: 1.h,
//                         ),
//                         child: const ColoredBox(color: Colors.black12),
//                       ),
//                       SizedBox(height: 12.h),
//                       Text(
//                         "Description",
//                         style: context.textTheme.bodyLarge!.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: weirdBlack,
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         info["description"],
//                         style: context.textTheme.bodyMedium!.copyWith(
//                           color: weirdBlack75,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         "Rules & Regulations",
//                         style: context.textTheme.bodyLarge!.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: weirdBlack,
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: List.generate(
//                           rules.length,
//                           (index) => Text(
//                             "${index + 1}. ${rules[index]}",
//                             style: context.textTheme.bodyMedium!.copyWith(
//                               color: weirdBlack75,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         "Hostel Facilities",
//                         style: context.textTheme.bodyLarge!.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: weirdBlack,
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       SizedBox(
//                         height: (facilities.length ~/ 4 +
//                                 (facilities.length % 4 == 0 ? 0 : 1)) *
//                             110.r,
//                         child: GridView.builder(
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 4,
//                                   crossAxisSpacing: 5.r,
//                                   mainAxisSpacing: 5.r,
//                                   mainAxisExtent: 105.r),
//                           itemCount: facilities.length,
//                           itemBuilder: (_, index) => FacilityContainer(
//                             text: facilities[index],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         "Available Rooms",
//                         style: context.textTheme.bodyLarge!.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: weirdBlack,
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       SizedBox(
//                         height: (rooms.length ~/ 2 +
//                                 (rooms.length % 2 == 0 ? 0 : 1)) *
//                             210.h,
//                         child: GridView.builder(
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 15.r,
//                             mainAxisSpacing: 15.r,
//                             mainAxisExtent: 205.h,
//                           ),
//                           itemCount: rooms.length,
//                           itemBuilder: (_, index) => AvailableRoomCard(
//                             info: rooms[index],
//                             isAsset: false,
//                             onTap: () {},
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         "Gallery",
//                         style: context.textTheme.bodyLarge!.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: weirdBlack,
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       SizedBox(
//                           height: (media.length ~/ 3 +
//                                   (media.length % 3 == 0 ? 0 : 1)) *
//                               110.r,
//                           child: GridView.builder(
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 10.r,
//                               mainAxisSpacing: 10.r,
//                               mainAxisExtent: 110.r,
//                             ),
//                             itemCount: media.length,
//                             itemBuilder: (_, index) => ClipRRect(
//                               borderRadius: BorderRadius.circular(5.r),
//                               child: Image.file(
//                                 File(media[index]),
//                                 width: 110.r,
//                                 height: 110.r,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 80.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         width: 414.w,
//         height: 90.h,
//         color: paleBlue,
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () => context.router.pop(),
//               child: Container(
//                 width: 170.w,
//                 height: 50.h,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4.r),
//                   border: Border.all(color: appBlue),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(Icons.chevron_left_rounded,
//                         color: appBlue, size: 26.r),
//                     SizedBox(width: 5.w),
//                     Text(
//                       "Go back",
//                       style: context.textTheme.bodyMedium!.copyWith(
//                         fontWeight: FontWeight.w600,
//                         color: appBlue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => showModalBottomSheet(
//                 context: context,
//                 builder: (context) => const _CreateHostelModal(),
//                 isDismissible: false,
//               ).then(
//                 (resp) {
//                   if (resp == null || !resp!) return;
//                   context.router.goNamed(Pages.ownerDashboard);
//                 },
//               ),
//               child: Container(
//                 width: 170.w,
//                 height: 50.h,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4.r),
//                   color: rooms.isEmpty ? appBlue.withOpacity(0.4) : appBlue,
//                 ),
//                 child: Text(
//                   "Launch",
//                   style: context.textTheme.bodyMedium!.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
