import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/receipt_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';

class OwnerProfilePage extends ConsumerStatefulWidget {
  const OwnerProfilePage({super.key});

  @override
  ConsumerState<OwnerProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<OwnerProfilePage> {
  @override
  Widget build(BuildContext context) {
    Landowner owner = ref.watch(currentUserProvider) as Landowner;

    List<HostelInfo> allHostels = ref.watch(ownerHostelsProvider);
    int totalRooms = 0;
    for (HostelInfo info in allHostels) {
      totalRooms += info.totalRooms;
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                iconSize: 26.r,
                splashRadius: 0.01,
                icon: const Icon(Icons.chevron_left),
                onPressed: () => context.router.pop(),
              ),
              elevation: 0.0,
              pinned: true,
              centerTitle: true,
              title: Text(
                "Profile",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
            ),
            SliverToBoxAdapter(
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
                          child: Container(
                            width: 100.r,
                            height: 100.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFE0E5EC),
                                    blurRadius: 1.0,
                                    spreadRadius: 2.0,
                                  )
                                ]),
                            alignment: Alignment.center,
                            child: Container(
                              width: 95.r,
                              height: 95.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(owner.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20.w,
                          bottom: 30.r,
                          child: GestureDetector(
                            onTap: () =>
                                context.router.pushNamed(Pages.editProfile),
                            child: Container(
                              width: 40.r,
                              height: 40.r,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                "assets/images/Edit.svg",
                                width: 20.r,
                                height: 20.r,
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
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      owner.mergedNames,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: weirdBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                      ),
                    ),
                    Text(
                      owner.email,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      owner.contact,
                      style: context.textTheme.bodyMedium!.copyWith(
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
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 15.w),
                        SvgPicture.asset(
                          "assets/images/Calender.svg",
                          width: 15.r,
                          height: 15.r,
                          color: weirdBlack50,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Joined ${formatDateRaw(owner.dateJoined)}",
                          style: context.textTheme.bodyMedium!.copyWith(
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
                                text:
                                    "${allHostels.length < 10 ? "0" : ""}${allHostels.length}",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: " Hostels",
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: weirdBlack50,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15.w),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "${totalRooms < 10 ? "0" : ""}$totalRooms",
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: " Rooms",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: weirdBlack50,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16.h),
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
                              "Invite Agent",
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
                              border: Border.all(color: appBlue, width: 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share_rounded,
                                  color: appBlue,
                                  size: 20.r,
                                ),
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
                        Text(
                          "Private to you",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
                    ProfileInfoCard(
                      image: "assets/images/Blue Eye.svg",
                      header: "${owner.profileViews} profile views",
                      text: "Fellow colleagues viewed your profile",
                    ),
                    SizedBox(height: 15.h),
                    ProfileInfoCard(
                      image: "assets/images/Search Appearance.svg",
                      header:
                          "${owner.searchAppearances} hostel search appearances",
                      text: "How often you appear in search results",
                    ),
                    SizedBox(height: 28.h),
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
                          "Personal Info",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        Text(
                          "Private to you",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
                    ProfileInfoCard(
                      image: "assets/images/Profile Blue Location.svg",
                      header: owner.address,
                      text: "Personal Address",
                    ),
                    SizedBox(height: 16.h),
                    ProfileInfoCard(
                      image: "assets/images/Profile Religion.svg",
                      header: owner.religion,
                      text: "Religion",
                    ),
                    if (owner.religion == "Christianity")
                      SizedBox(height: 16.h),
                    if (owner.religion == "Christianity")
                      ProfileInfoCard(
                        image: "assets/images/Profile Church.svg",
                        header: owner.denomination,
                        text: "Denomination",
                      ),
                    SizedBox(height: 16.h),
                    ProfileInfoCard(
                      image: "assets/images/Profile Age.svg",
                      header: formatDateRaw(owner.dob),
                      text: "Date of Birth",
                    ),
                    SizedBox(height: 24.h),
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
                          "Hostel Information",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        Text(
                          "Public to students",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
                    ProfileInfoCard(
                      image: "assets/images/Profile Blue Location.svg",
                      header: owner.address,
                      text: "Hostel name",
                    ),
                    SizedBox(height: 16.h),
                    ProfileInfoCard(
                      image: "assets/images/Profile Blue Location.svg",
                      header: owner.address,
                      text: "Identification number",
                    ),
                    SizedBox(height: 16.h),
                    ProfileInfoCard(
                      image: "assets/images/Profile Blue Location.svg",
                      header: owner.address,
                      text: "Address",
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(height: 24.h),
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
                          "Face Capturing",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        Text(
                          "Private to you",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
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
                          ]
                      ),
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
                                  "assets/images/Profile Face.svg"),
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              owner.verified
                                  ? "Successfully done"
                                  : "Not verified",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            SizedBox(width: !owner.verified ? 100.w : 60.w),
                            if (owner.verified)
                              Container(
                                width: 70.w,
                                height: 25.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: paleBlue,
                                  borderRadius: BorderRadius.circular(12.5.h),
                                ),
                                child: Text(
                                  "Verified",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 48.h),
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
