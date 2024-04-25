import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/home/landlord/edit-hostel.dart';

class EditStepSeven extends StatefulWidget {
  final HostelInfoData info;

  const EditStepSeven({
    super.key,
    required this.info,
  });

  @override
  State<EditStepSeven> createState() => _EditStepSevenState();
}

class _EditStepSevenState extends State<EditStepSeven> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Column(
          children: [
            SizedBox(height: 25.h),
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 8 / totalPages,
                color: appBlue,
                minHeight: 1.5.h,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: "Reset",
                    child: Text(
                      "Save and Exit",
                      style: context.textTheme.bodyMedium,
                    ),
                  )
                ],
                onSelected: (result) =>
                    saveAndExit(info: widget.info, context: context),
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "STEP 8",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: appBlue,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Room Vacancy",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Do you have any vacant room(s) in your hostel?",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 44.h),
                SvgPicture.asset(
                  "assets/images/Room Vacancy.svg",
                  width: 200.r,
                  height: 200.r,
                ),
                SizedBox(height: 40.h),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FBFF),
                    borderRadius: BorderRadius.circular(4.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFE0E5EC),
                        blurRadius: 6.0,
                        spreadRadius: 1.0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.info.isLocal(0)
                            ? CachedNetworkImage(
                          imageUrl: widget.info.media.first,
                          errorWidget: (context, url, error) => Container(
                            width: 114.w,
                            height: 100.h,
                            color: weirdBlack50,
                          ),
                          progressIndicatorBuilder:
                              (context, url, download) => Container(
                            width: 114.w,
                            height: 100.h,
                            color: weirdBlack50,
                            alignment: Alignment.center,
                            child: loader,
                          ),
                          imageBuilder: (context, provider) => Container(
                            width: 114.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              image: DecorationImage(
                                image: provider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: Image.file(
                            File(widget.info.media.first.path),
                            width: 114.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 220.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Yes",
                                    style:
                                    context.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: weirdBlack,
                                    ),
                                  ),
                                  Radio(
                                    value: widget.info.vacantRooms,
                                    groupValue: true,
                                    onChanged: (value) => setState(
                                            () => widget.info.vacantRooms = true),
                                  )
                                ],
                              ),
                              Text(
                                "There are rooms available for rent in my hostel.",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FBFF),
                    borderRadius: BorderRadius.circular(4.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFE0E5EC),
                        blurRadius: 6.0,
                        spreadRadius: 1.0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.info.isLocal(0)
                            ? CachedNetworkImage(
                          imageUrl: widget.info.media.first,
                          errorWidget: (context, url, error) => Container(
                            width: 114.w,
                            height: 100.h,
                            color: weirdBlack50,
                          ),
                          progressIndicatorBuilder:
                              (context, url, download) => Container(
                            width: 114.w,
                            height: 100.h,
                            color: weirdBlack50,
                            alignment: Alignment.center,
                            child: loader,
                          ),
                          imageBuilder: (context, provider) => Container(
                            width: 114.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              image: DecorationImage(
                                image: provider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: Image.file(
                            File(widget.info.media.first.path),
                            width: 114.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 220.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "No",
                                    style:
                                    context.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: weirdBlack,
                                    ),
                                  ),
                                  Radio(
                                    value: widget.info.vacantRooms,
                                    groupValue: false,
                                    onChanged: (value) => setState(
                                            () => widget.info.vacantRooms = false),
                                  )
                                ],
                              ),
                              Text(
                                "There are no rooms available for rent in my hostel.",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
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
              onTap: () => context.router.pushNamed(
                !widget.info.vacantRooms
                    ? Pages.editStepTen
                    : Pages.editStepEight,
                extra: widget.info,
              ),
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