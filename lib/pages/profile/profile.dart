import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';

class _Link {
  final String name;
  final String route;
  final String image;

  const _Link({required this.route, required this.name, required this.image});
}

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late List<_Link> links;

  @override
  void initState() {
    super.initState();

    links = const [
      _Link(name: "View profile", route: "", image: "assets/images/Danger.svg"),
      _Link(name: "Wallet", route: "", image: "assets/images/Settings.svg"),
      _Link(name: "Settings", route: "", image: "assets/images/Settings.svg"),
      _Link(name: "About", route: "", image: "assets/images/Danger.svg"),
      _Link(name: "Help & Support", route: "", image: "assets/images/Danger.svg"),
      _Link(name: "Privacy Policy", route: "", image: "assets/images/Danger.svg"),
      _Link(name: "Logout", route: "", image: "assets/images/Logout.svg"),
    ];
  }

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
                  radius: 60.r,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(student.image),
                    radius: 56.r,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "${student.firstName} ${student.lastName}",
                  style: context.textTheme.headlineMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text("Active Now", style: context.textTheme.bodyLarge),
                SizedBox(height: 45.h),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        context.router.pushNamed(links[index].route);
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
                                    SvgPicture.asset(links[index].image, color: Colors.black54),
                                    SizedBox(width: 16.w),
                                    Text(links[index].name,
                                      style: context.textTheme.bodyLarge!.copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.chevron_right_rounded, color: Colors.black54, size: 26.r),
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
