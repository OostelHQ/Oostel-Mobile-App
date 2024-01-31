import 'dart:io';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';

class EditStepNine extends StatefulWidget {
  final HostelInfoData info;

  const EditStepNine({
    super.key,
    required this.info,
  });

  @override
  State<EditStepNine> createState() => _EditStepNineState();
}

class _EditStepNineState extends State<EditStepNine> {
  late TextEditingController name;
  late TextEditingController price;

  String? duration;

  final List<String> images = [
    "assets/images/Light-Off.svg",
    "assets/images/Tap.svg",
    "assets/images/Bathtub Pro.svg",
    "assets/images/Toilet Pro.svg",
    "assets/images/Kitchen Pro.svg",
    "assets/images/Ceiling Fan.svg",
    "assets/images/Wardrobe.svg",
    "assets/images/Hanger.svg",
  ];

  final List<String> names = [
    "Light",
    "Tap Water",
    "Bathroom",
    "Toilet",
    "Kitchen",
    "Ceiling Fan",
    "Wardrobe",
    "Hanger",
  ];

  late List<String> facilities;
  late List<dynamic> media;

  final GlobalKey<FormState> formKey = GlobalKey();

  late RoomInfoData? room;
  late String id;

  @override
  void initState() {
    super.initState();

    int? roomIndex = widget.info.roomEditIndex;
    if (roomIndex != null) {
      room = widget.info.rooms[roomIndex];
      duration = room?.duration;
      facilities = room?.facilities ?? [];
      media = room?.media ?? [];
      id = room?.id ?? "";
    } else {
      facilities = [];
      media = [];
      id = "";
    }

    name = TextEditingController(text: room?.name ?? "");
    price = TextEditingController(
        text: room?.price == null ? "" : room?.price.toStringAsFixed(0));
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    super.dispose();
  }

  bool isLocal(int index) => media[index]! is String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Column(
          children: [
            SizedBox(height: 25.h),
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 10 / totalPages,
                color: appBlue,
                minHeight: 1.5.h,
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "STEP 10",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: appBlue,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Center(
                        child: Text(
                          "Available Room",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Center(
                        child: Text(
                          "Share information about the vacant room to help potential tenants make informed decisions.",
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: weirdBlack75,
                          ),
                        ),
                      ),
                      SizedBox(height: 44.h),
                      Text(
                        "Room Number",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack,
                        ),
                      ),
                      SpecialForm(
                        controller: name,
                        width: 414.w,
                        height: 50.h,
                        hint: "i.e Block A5",
                        onValidate: (val) {
                          if (val == null || val!.trim().isEmpty) {
                            showError("Please enter the name of this room.");
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Price",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack,
                        ),
                      ),
                      SpecialForm(
                        controller: price,
                        width: 414.w,
                        height: 50.h,
                        hint: "00.00",
                        type: TextInputType.number,
                        onValidate: (val) {
                          if (val == null ||
                              val!.trim().isEmpty ||
                              double.tryParse(val!) == null) {
                            showError(
                                "Please enter a valid price for this room.");
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Duration",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack,
                        ),
                      ),
                      ComboBox(
                        hint: "Select",
                        value: duration,
                        dropdownItems: const ["Daily", "Monthly", "Yearly"],
                        onChanged: (val) => setState(() => duration = val),
                        icon: const Icon(Boxicons.bxs_down_arrow),
                        buttonWidth: 414.w,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Room Facilities",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
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
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.w,
                    mainAxisExtent: 90.h,
                  ),
                  itemBuilder: (_, index) {
                    bool present = facilities.contains(names[index]);
                    return GestureDetector(
                      onTap: () => setState(() {
                        if (present) {
                          facilities.remove(names[index]);
                        } else {
                          facilities.add(names[index]);
                        }
                      }),
                      child: Container(
                        width: 170.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                            color: present ? appBlue : fadedBorder,
                          ),
                          color: facilities.contains(names[index])
                              ? paleBlue
                              : null,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 90.h,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(images[index],
                                        color: present ? appBlue : null),
                                    Text(
                                      names[index],
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: present ? appBlue : weirdBlack50,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              AnimatedSwitcherTranslation.right(
                                duration: const Duration(milliseconds: 250),
                                child: Container(
                                  height: 15.r,
                                  width: 15.r,
                                  alignment: Alignment.center,
                                  key: ValueKey<bool>(present),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: fadedBorder),
                                    borderRadius: BorderRadius.circular(3.r),
                                    color: present ? appBlue : null,
                                  ),
                                  child: present
                                      ? const Icon(
                                    Icons.done_rounded,
                                    color: Colors.white,
                                    size: 10,
                                  )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: names.length,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Text(
                        "Room Pictures",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
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
                sliver: media.isEmpty
                    ? SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      width: 414.w,
                      height: 270.h,
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: paleBlue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/Hostel Image.svg",
                            width: 40.r,
                            height: 40.r,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Upload your room images",
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Maximum size allowed is 2MB of png and jpg format",
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                    : SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.r,
                    mainAxisSpacing: 10.r,
                    mainAxisExtent: 110.r,
                  ),
                  itemCount: media.length,
                  itemBuilder: (_, index) => Stack(
                    children: [
                      isLocal(index)
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
                        errorWidget: (context, url, error) =>
                            Container(
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
                        imageBuilder: (context, provider) =>
                            Container(
                              width: 110.r,
                              height: 110.r,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(5.r),
                                image: DecorationImage(
                                  image: provider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      ),
                      Positioned(
                        right: 10.r,
                        top: 5.r,
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => media.removeAt(index)),
                          child: Icon(Boxicons.bx_x,
                              color: Colors.white, size: 26.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    if (media.length < 8)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Text(
                              "*Note that you must to upload minimum of 8 and above images before you can proceed.",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodySmall!.copyWith(
                                color: weirdBlack50,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),
                          GestureDetector(
                            onTap: () =>
                                FileManager.multiple(type: FileType.image)
                                    .then((response) async {
                                  media.addAll(response);
                                  setState(() {});
                                }),
                            child: Container(
                              width: 160.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: paleBlue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add_circle_outline,
                                      color: appBlue, size: 16),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Add images",
                                    textAlign: TextAlign.center,
                                    style:
                                    context.textTheme.bodyMedium!.copyWith(
                                      color: appBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 50.h),
                  ],
                ),
              )
            ],
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
              onTap: () {
                if (!validateForm(formKey)) return;

                if (duration == null) {
                  showError("Please choose a duration");
                  return;
                }

                if (room == null) {
                  RoomInfoData data = RoomInfoData(
                    id: id,
                    duration: duration!,
                    name: name.text.trim(),
                    price: double.parse(price.text.trim()),
                    facilities: facilities,
                    media: media,
                  );
                  context.router.pop(data);
                } else {
                  context.router.pop();
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
                      "Next",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(Icons.chevron_right_rounded,
                        color: Colors.white, size: 26.r)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}