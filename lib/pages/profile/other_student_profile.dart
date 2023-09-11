import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/roommate_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';

class OtherStudentProfilePage extends StatefulWidget {
  final RoommateInfo info;

  const OtherStudentProfilePage({
    super.key,
    required this.info,
  });

  @override
  State<OtherStudentProfilePage> createState() =>
      _OtherStudentProfilePageState();
}

class _OtherStudentProfilePageState extends State<OtherStudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text("Roommate",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 22.sp)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Icon(Icons.favorite_rounded, color: Colors.red, size: 26.r),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: appBlue,
                        radius: 72.r,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(widget.info.student.image),
                          radius: 68.r,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      widget.info.student.mergedNames,
                      style: context.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 22.sp),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/Roomate Info Location.svg",
                          width: 15.r,
                          height: 15.r,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          widget.info.location,
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: weirdBlack),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: currency(),
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: formatAmountInDouble(widget.info.amount),
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "/year",
                            style: context.textTheme.bodySmall!.copyWith(
                              color: appBlue,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Container(
                      width: 414.w,
                      color: Colors.black12,
                      height: 2.h,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Personal Details",
                          style: context.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Public to fellow students",
                            style: context.textTheme.bodyMedium!
                                .copyWith(color: weirdBlack),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Card(
                      elevation: 1.0,
                      child: SizedBox(
                        height: 70.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Container(
                              width: 50.r,
                              height: 50.r,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: paleBlue,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/Profile Level.svg"),
                            ),
                            SizedBox(width: 15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.info.level}",
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "School level",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: weirdBlack),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Card(
                      elevation: 1.0,
                      child: SizedBox(
                        height: 70.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Container(
                              width: 50.r,
                              height: 50.r,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: paleBlue,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/Profile Gender.svg"),
                            ),
                            SizedBox(width: 15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.info.student.gender,
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Gender",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: weirdBlack),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Card(
                      elevation: 1.0,
                      child: SizedBox(
                        height: 70.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Container(
                              width: 50.r,
                              height: 50.r,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: paleBlue,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/Profile Religion.svg"),
                            ),
                            SizedBox(width: 15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.info.religion}",
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Religion",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: weirdBlack),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Card(
                      elevation: 1.0,
                      child: SizedBox(
                        height: 70.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Container(
                              width: 50.r,
                              height: 50.r,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: paleBlue,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/Profile Church.svg"),
                            ),
                            SizedBox(width: 15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.info.denomination}",
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Denomination",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: weirdBlack),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Card(
                      elevation: 1.0,
                      child: SizedBox(
                        height: 70.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Container(
                              width: 50.r,
                              height: 50.r,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: paleBlue,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/Profile Age.svg"),),
                            SizedBox(width: 15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.info.ageRange,
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Age",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: weirdBlack),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Card(
                      elevation: 1.0,
                      child: SizedBox(
                        height: 70.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Container(
                              width: 50.r,
                              height: 50.r,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: paleBlue,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/Profile Origin.svg"),),
                            SizedBox(width: 15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.info.origin,
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "State of origin",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: weirdBlack),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Card(
                      elevation: 1.0,
                      child: SizedBox(
                        height: 70.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            Container(
                              width: 50.r,
                              height: 50.r,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: paleBlue,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/Profile Hobby.svg"),),
                            SizedBox(width: 15.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.info.hobby,
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Hobbies",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: weirdBlack),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),

              Container(
                width: 414.w,
                height: 90.h,
                color: paleBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 180.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: appBlue, width: 1.5),
                        ),
                        child: Text(
                          "Start a chat",
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500, color: appBlue),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 180.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appBlue,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          "Collaborate",
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
