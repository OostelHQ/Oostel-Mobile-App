import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/api/hostel_service.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/profile/student/settings.dart';
import 'package:my_hostel/pages/chats/chats.dart';
import 'package:my_hostel/pages/home/student/explore.dart';

class StudentDashboardPage extends ConsumerStatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  ConsumerState<StudentDashboardPage> createState() =>
      _StudentDashboardPageState();
}

class _StudentDashboardPageState extends ConsumerState<StudentDashboardPage> {
  late List<Widget> stack;

  @override
  void initState() {
    super.initState();
    stack = const [
      _HomePage(),
      ExplorePage(),
      ChatsPage(),
      StudentSettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    int index = ref.watch(dashboardTabIndexProvider), key = 0;
    bool messages = ref.watch(hasMessagesProvider);

    String messagePath = "assets/images/Message";
    if (messages && index == 2) {
      messagePath = "$messagePath Active Chat.svg";
      key = 1;
    } else if (messages && index != 2) {
      messagePath = "$messagePath Inactive Chat.svg";
      key = 2;
    } else if (!messages && index == 2) {
      messagePath = "$messagePath Active No Chat.svg";
      key = 3;
    } else {
      messagePath = "$messagePath Inactive No Chat.svg";
    }

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: index,
          children: stack,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       AwesomeNotifications().createNotification(
      //         content: NotificationContent(
      //           id: 1,
      //           channelKey: "basic_channel",
      //           title: "Testing",
      //           body: "Local Notifications are working. Yay!",
      //           category: NotificationCategory.Message,
      //           backgroundColor: appBlue,
      //           wakeUpScreen: true,
      //         ),
      //       );
      //     },
      //     child: const Icon(Icons.notification_add_rounded),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) =>
            ref.watch(dashboardTabIndexProvider.notifier).state = newIndex,
        selectedItemColor: appBlue,
        selectedLabelStyle: context.textTheme.bodySmall!
            .copyWith(color: appBlue, fontWeight: FontWeight.w500),
        unselectedLabelStyle: context.textTheme.bodySmall!
            .copyWith(color: weirdBlack50, fontWeight: FontWeight.w500),
        showUnselectedLabels: true,
        unselectedItemColor: weirdBlack50,
        items: [
          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                "assets/images/Home ${index == 0 ? "Active" : "Inactive"}.svg",
                key: ValueKey<bool>(index == 0),
                color: index != 0 ? weirdBlack50 : null,
                height: 25.h,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                "assets/images/Explore ${index == 1 ? "Active" : "Inactive"}.svg",
                key: ValueKey<bool>(index == 1),
                color: index != 1 ? weirdBlack50 : null,
                height: 25.h,
              ),
            ),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                messagePath,
                color: index != 2 ? weirdBlack50 : null,
                key: ValueKey<int>(key),
                height: 25.h,
              ),
            ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                "assets/images/Profile ${index == 3 ? "Active" : "Inactive"}.svg",
                color: index != 3 ? weirdBlack50 : null,
                key: ValueKey<int>(key),
                height: 25.h,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class _HomePage extends ConsumerStatefulWidget {
  const _HomePage();

  @override
  ConsumerState<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<_HomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController controller = ScrollController();
  List<dynamic> acquireList = [];
  bool hostelSelect = true, loading = true;

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    acquireList = ref.read(acquiredHostelsProvider);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    if (ref.read(currentUserProvider).hasCompletedProfile < 100) {
      Future.delayed(
          const Duration(seconds: 3), () => animationController.forward());
    }

    getDetails();
  }

  void getDetails() {
    getStudentLikedHostels(ref.read(currentUserProvider).id).then((resp) {
      if (!resp.success) {
        showError(resp.message);
        setState(() => loading = false);
        return;
      }

      ref.watch(studentLikedHostelsProvider).clear();
      ref.watch(studentLikedHostelsProvider).addAll(resp.payload);
      setState(() => loading = false);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(currentUserProvider);
    bool notifications = ref.watch(newNotificationProvider);

    return Stack(
      children: [
        RefreshIndicator(
            onRefresh: () async {
              setState(() => loading = true);
              getDetails();
            },
            child: loading
                ? const Center(child: blueLoader)
                : CustomScrollView(
                    controller: controller,
                    slivers: [
                      SliverAppBar(
                        systemOverlayStyle: SystemUiOverlayStyle.dark,
                        automaticallyImplyLeading: false,
                        elevation: 0.0,
                        pinned: true,
                        centerTitle: true,
                        title: GestureDetector(
                          onTap: () =>
                              context.router.pushNamed(Pages.studentProfile),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              user.image == ""
                                  ? CircleAvatar(
                                      radius: 15.r,
                                      backgroundColor: appBlue,
                                      child: Text(
                                        user.firstName.substring(0, 1),
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: user.image,
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                        backgroundColor: weirdBlack20,
                                        radius: 15.r,
                                        child: Center(
                                          child: Icon(
                                            Icons.person_outline_rounded,
                                            color: appBlue,
                                            size: 20.r,
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, download) {
                                        return CircleAvatar(
                                          radius: 15.r,
                                          backgroundColor: weirdBlack50,
                                        );
                                      },
                                      imageBuilder: (context, provider) {
                                        return CircleAvatar(
                                          backgroundImage: provider,
                                          radius: 15.r,
                                        );
                                      },
                                    ),
                              SizedBox(width: 10.w),
                              Text(
                                "Hello, ${user.lastName} ",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                user.gender == "Female"
                                    ? "🧑"
                                    : user.gender == "Male"
                                        ? "🧒"
                                        : "",
                                style: context.textTheme.bodyLarge!
                                    .copyWith(fontSize: 22.sp),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(right: 22.w),
                            child: GestureDetector(
                              onTap: () =>
                                  context.router.pushNamed(Pages.notification),
                              child: AnimatedSwitcherTranslation.right(
                                duration: const Duration(milliseconds: 500),
                                child: SvgPicture.asset(
                                  "assets/images/Notification ${notifications ? "Active" : "None"}.svg",
                                  height: 25.h,
                                  key: ValueKey<bool>(notifications),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const WalletSlider(),
                              SizedBox(height: 35.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Hero(
                                    tag: "My Acquires Header",
                                    child: Text(
                                      "My Acquires",
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: weirdBlack),
                                    ),
                                  ),
                                  if (acquireList.length >= 3)
                                    GestureDetector(
                                      onTap: () => context.router.pushNamed(
                                          Pages.viewAcquires,
                                          extra: hostelSelect),
                                      child: Text(
                                        "See All",
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                                color: appBlue,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Hero(
                                tag: "Home Switcher",
                                child: HomeSwitcher(
                                  onHostelDisplayed: () => setState(() {
                                    acquireList =
                                        ref.watch(acquiredHostelsProvider);
                                    hostelSelect = true;
                                  }),
                                  onRoommateDisplayed: () => setState(() {
                                    acquireList =
                                        ref.watch(acquiredRoommatesProvider);
                                    hostelSelect = false;
                                  }),
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        sliver: acquireList.isEmpty
                            ? SliverFillRemaining(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "You have no ${hostelSelect ? "hostel" : "roommate"} acquires yet!",
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: weirdBlack50,
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      GestureDetector(
                                        onTap: () => ref
                                            .watch(dashboardTabIndexProvider
                                                .notifier)
                                            .state = 1,
                                        child: Text(
                                          "Explore ${hostelSelect ? "Hostels" : "Roommates"}",
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: appBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (_, index) {
                                    if (index >= acquireList.length) {
                                      return const SizedBox();
                                    }

                                    dynamic element = acquireList[index];
                                    if (element is HostelInfo) {
                                      return HostelInfoCard(info: element);
                                    } else {
                                      return StudentCard(info: element);
                                    }
                                  },
                                  childCount: 4,
                                ),
                              ),
                      ),
                    ],
                  )),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizeTransition(
            sizeFactor: animation,
            child: ProfileNotification(
                onCancel: () => animationController.reverse()),
          ),
        ),
      ],
    );
  }
}
