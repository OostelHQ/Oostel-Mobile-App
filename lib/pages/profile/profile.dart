import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/roommate_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
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
        title: Text(
          "Roommate",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Icon(Icons.favorite_rounded, color: Colors.red, size: 26.r),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Center(
                  child: CircleAvatar(
                    backgroundColor: appBlue,
                    radius: 72.r,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/watch man.jpg"),
                      radius: 68.r,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "widget.info.student.mergedNames",
                  style: context.textTheme.bodyLarge!.copyWith(
                      color: weirdBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp),
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
                      color: weirdBlack50,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "widget.info.location,",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack50, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 414.w,
                    minHeight: 1.h,
                    maxWidth: 414.w,
                    maxHeight: 1.h,
                  ),
                  child: const ColoredBox(color: Colors.black12),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Personal Details",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Public to fellow students",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack50,
                          fontWeight: FontWeight.w500,
                        ),
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
                              "",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            Text(
                              "School level",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
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
                              "widget.info.student.gender",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            Text(
                              "Gender",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
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
                              "widget.info.religion",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            Text(
                              "Religion",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
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
                              "",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            Text(
                              "Denomination",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
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
                          child:
                              SvgPicture.asset("assets/images/Profile Age.svg"),
                        ),
                        SizedBox(width: 15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            Text(
                              "Age",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
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
                              "assets/images/Profile Origin.svg"),
                        ),
                        SizedBox(width: 15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "widget.info.origin",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            Text(
                              "State of origin",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
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
                              "assets/images/Profile Hobby.svg"),
                        ),
                        SizedBox(width: 15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "widget.info.hobby",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            Text(
                              "Hobbies",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500),
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
        ),
      ),
    );
  }
}
