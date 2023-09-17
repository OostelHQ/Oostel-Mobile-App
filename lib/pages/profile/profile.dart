import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
    Student student = ref.watch(studentProvider);

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
          "Profile",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150.h,
                child: Stack(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 100.h,
                        minWidth: 414.w,
                        maxHeight: 100.h,
                        maxWidth: 414.w,
                      ),
                      child: const ColoredBox(
                        color: paleBlue,
                      ),
                    ),
                    Positioned(
                      left: 20.w,
                      bottom: 10.r,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 48.r,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage(student.image),
                          radius: 45.r,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20.w,
                      bottom: 30.r,
                      child: Container(
                          width: 40.r,
                          height: 40.r,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.edit_rounded, size: 18.r)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.mergedNames,
                      style: context.textTheme.bodyLarge!.copyWith(
                          color: weirdBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp,
                      ),
                    ),
                    Text(
                      student.email,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          "Nigeria",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 15.w),
                        SvgPicture.asset(
                          "assets/images/Roomate Info Location.svg",
                          width: 15.r,
                          height: 15.r,
                          color: weirdBlack50,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Joined ${formatDateRaw(student.joined)}",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${student.rentedHostels}",
                                style: context.textTheme.bodySmall!.copyWith(color: weirdBlack75, fontWeight: FontWeight.w500)
                              ),
                              TextSpan(
                                  text: " Rented Hostels",
                                  style: context.textTheme.bodySmall!.copyWith(color: weirdBlack50, fontWeight: FontWeight.w500)
                              ),
                            ]
                          ),
                        ),
                        SizedBox(width: 15.w),
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "${student.collaboratedRoommates}",
                                    style: context.textTheme.bodySmall!.copyWith(color: weirdBlack75, fontWeight: FontWeight.w500)
                                ),
                                TextSpan(
                                    text: " Collaborate Roommates",
                                    style: context.textTheme.bodySmall!.copyWith(color: weirdBlack50, fontWeight: FontWeight.w500)
                                ),
                              ]
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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
                              "Open to",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
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
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5.r),
                              border:
                              Border.all(color: appBlue, width: 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.share_rounded, color: appBlue, size: 20.r,),
                                SizedBox(width: 10.w),
                                Text(
                                  "Share",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: appBlue),
                                ),
                              ],
                            ),
                          ),
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
                          "Analytics",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Private to you",
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
                              child: SvgPicture.asset(
                                  "assets/images/Profile Age.svg"),
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
            ],
          ),
        ),
      ),
    );
  }
}
