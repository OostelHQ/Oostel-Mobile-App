import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/other/gallery.dart';

class _Link {
  final String name;
  final String route;
  final String image;

  const _Link({
    required this.route,
    required this.name,
    required this.image,
  });
}

class OwnerSettingsPage extends ConsumerStatefulWidget {
  const OwnerSettingsPage({super.key});

  @override
  ConsumerState<OwnerSettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<OwnerSettingsPage> {
  late List<_Link> links;

  @override
  void initState() {
    super.initState();

    links = const [
      _Link(
        name: "View profile",
        route: Pages.ownerProfile,
        image: "assets/images/View Profile.svg",
      ),
      _Link(
        name: "Co-workers",
        route: Pages.agents,
        image: "assets/images/Agents.svg",
      ),
      _Link(
        name: "Settings",
        route: Pages.ownerProfileSettings,
        image: "assets/images/Settings.svg",
      ),
      _Link(
        name: "Terms of Service",
        route: Pages.about,
        image: "assets/images/Terms.svg",
      ),
      _Link(
        name: "Help & Support",
        route: Pages.help,
        image: "assets/images/Help.svg",
      ),
      _Link(
        name: "Privacy Policy",
        route: Pages.privacyPolicy,
        image: "assets/images/Privacy.svg",
      ),
      _Link(
        name: "Logout",
        route: "",
        image: "assets/images/Logout.svg",
      ),
    ];
  }

  void logout() => showModalBottomSheet(
    context: context,
    builder: (_) => SizedBox(
      height: 450.h,
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
                        "assets/images/Profile Logout.png",
                        width: 135.r,
                        height: 135.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Do you want to logout?",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Fynda wants to ensure that users are logging out intentionally.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 180.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: appBlue),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            "No, cancel",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: appBlue,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          resetProviders(ref);
                          FileManager.saveAuthDetails(null);
                          FileManager.saveBool("registeredFynda", false);
                          FileManager.saveBool("autoLogin", false);
                          context.router.goNamed(Pages.splash);
                        },
                        child: Container(
                          width: 180.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: appBlue,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            "Yes, logout",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(currentUserProvider);
    List<HostelInfo> allHostels = ref.watch(ownerHostelsProvider);
    int totalRooms = 0;
    for (HostelInfo info in allHostels) {
      totalRooms += info.rooms.length;
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
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
                          ],
                        ),
                        alignment: Alignment.center,
                        child: user.image == "" ? CircleAvatar(
                          radius: 47.5.r,
                          backgroundColor: appBlue,
                          child: Center(
                            child: Text(
                              user.firstName.substring(0, 1),
                              style: context.textTheme.displaySmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ) : CachedNetworkImage(imageUrl: user.image,
                          errorWidget: (context, url, error) => CircleAvatar(
                            backgroundColor: weirdBlack20,
                            radius: 47.5.r,
                            child: Center(
                              child: Icon(
                                Icons.person_outline_rounded,
                                color: appBlue,
                                size: 42.r,
                              ),
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, download) {
                            return CircleAvatar(
                              radius: 47.5.r,
                              backgroundColor: weirdBlack50,
                            );
                          },
                          imageBuilder: (context, provider) {
                            return GestureDetector(
                              onTap: () => context.router.pushNamed(
                                Pages.viewMedia,
                                extra: ViewInfo(
                                  current: 0,
                                  type: DisplayType.network,
                                  paths: [user.image],
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: provider,
                                radius: 47.5.r,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        user.mergedNames,
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: weirdBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp,
                        ),
                      ),
                      Text(
                        user.email,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        user.contact,
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
                            "Joined ${formatDateRaw(user.dateJoined)}",
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
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 414.w,
                          minHeight: 1.h,
                          maxWidth: 414.w,
                          maxHeight: 1.h,
                        ),
                        child: const ColoredBox(color: Colors.black12),
                      ),
                      SizedBox(height: 15.h),
                    ]
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (index != links.length - 1) {
                              context.router.pushNamed(links[index].route);
                            } else {
                              logout();
                            }
                          },
                          child: Container(
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
                            child: SizedBox(
                              height: 50.h,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(links[index].image,
                                            color: weirdBlack75),
                                        SizedBox(width: 16.w),
                                        Text(
                                          links[index].name,
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                            color: weirdBlack75,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.chevron_right_rounded,
                                        color: Colors.black54, size: 26.r),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  childCount: links.length,
                ),
              )
            )
          ]
        )
      ),
    );
  }
}

class OwnerProfileSettingsPage extends StatelessWidget {
  const OwnerProfileSettingsPage({super.key});

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
          "Settings",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Text(
                "Explore your settings to customize your preferences and enhance your interaction with our platform.",
                style: context.textTheme.bodyMedium!.copyWith(
                  color: weirdBlack75,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => context.router.pushNamed(
                      index == 0
                          ? Pages.editOwnerProfile
                          : (index == 1)
                              ? Pages.hostelSettings
                              : (index == 2)
                                  ? Pages.changePassword
                                  : Pages.notificationSettings,
                    ),
                    child: Container(
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
                        height: 50.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/Profile ${index == 0 ? "Profile" : (index == 1) ? "Hostel" : (index == 2) ? "Password" : "Notification"}.svg",
                                    color: weirdBlack75,
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    index == 0
                                        ? "Profile"
                                        : (index == 1
                                            ? "Hostel"
                                            : (index == 2)
                                                ? "Password"
                                                : "Notification"),
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: weirdBlack75,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.chevron_right_rounded,
                                  color: Colors.black54, size: 26.r),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemCount: 4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
