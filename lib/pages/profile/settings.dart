import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class _Link {
  final String name;
  final String route;
  final String image;

  const _Link({required this.route, required this.name, required this.image});
}

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late List<_Link> links;

  @override
  void initState() {
    super.initState();

    links = const [
      _Link(
        name: "View profile",
        route: Pages.profile,
        image: "assets/images/Danger.svg",
      ),
      _Link(
        name: "Wallet",
        route: Pages.wallet,
        image: "assets/images/Settings.svg",
      ),
      _Link(
        name: "Settings",
        route: Pages.profileSettings,
        image: "assets/images/Settings.svg",
      ),
      _Link(
        name: "About",
        route: Pages.about,
        image: "assets/images/Danger.svg",
      ),
      _Link(
        name: "Help & Support",
        route: Pages.help,
        image: "assets/images/Danger.svg",
      ),
      _Link(
        name: "Privacy Policy",
        route: Pages.privacyPolicy,
        image: "assets/images/Danger.svg",
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
                      SizedBox(height: 25.h),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/Logout Profile.svg",
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
                        "Lorem ipsum",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack50,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 42.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appBlue,
                            ),
                            child: Text(
                              "Cancel",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.router.goNamed(Pages.splash);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appBlue,
                            ),
                            child: Text(
                              "Yes, logout",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.h),
                      const Copyright(),
                      SizedBox(height: 14.h)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Student student = ref.watch(studentProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Profile",
                    style: context.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                CircleAvatar(
                  backgroundColor: appBlue,
                  radius: 45.r,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(student.image),
                    radius: 42.r,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "${student.firstName} ${student.lastName}",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
                Text(
                  "Active Now",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 45.h),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        if (index != links.length - 1) {
                          context.router.pushNamed(links[index].route);
                        } else {
                          logout();
                        }
                      },
                      child: Card(
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
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                    itemCount: links.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

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
                "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet.",
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
                          ? Pages.editProfile
                          : (index == 1)
                              ? Pages.changePassword
                              : Pages.notificationSettings,
                    ),
                    child: Card(
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
                                    "assets/images/Profile ${index == 0 ? "Profile" : (index == 1) ? "Password" : "Notification"}.svg",

                                    color: weirdBlack75,
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    index == 0
                                        ? "Profile"
                                        : (index == 1
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
                  itemCount: 3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
