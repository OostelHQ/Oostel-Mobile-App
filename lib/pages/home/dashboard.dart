import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/roommate_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

import 'chats.dart';
import 'explore.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  late List<Widget> stack;

  @override
  void initState() {
    super.initState();
    stack = const [
      _HomePage(),
      ExplorePage(),
      ChatsPage(),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) {
          if (newIndex != 3) {
            ref.watch(dashboardTabIndexProvider.notifier).state = newIndex;
          } else {
            context.router.pushNamed(Pages.profile);
          }
        },
        selectedItemColor: appBlue,
        selectedLabelStyle: context.textTheme.bodySmall!
            .copyWith(color: appBlue, fontWeight: FontWeight.w500),
        unselectedLabelStyle: context.textTheme.bodySmall!
            .copyWith(color: weirdBlack, fontWeight: FontWeight.w500),
        showUnselectedLabels: true,
        unselectedItemColor: weirdBlack,
        items: [
          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                "assets/images/Home ${index == 0 ? "Active" : "Inactive"}.svg",
                key: ValueKey<bool>(index == 0),
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
                key: ValueKey<int>(key),
                height: 25.h,
              ),
            ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/Profile.svg",
              height: 25.h,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class PageContent {
  final String header;
  final String subtitle;
  final List<Color> colors;
  bool visible;
  double amount;

  PageContent({
    required this.header,
    required this.subtitle,
    required this.colors,
    this.visible = true,
    this.amount = 0.0,
  });
}

class _HomePage extends ConsumerStatefulWidget {
  const _HomePage({super.key});

  @override
  ConsumerState<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<_HomePage> {
  final ScrollController controller = ScrollController();
  late List<PageContent> contents;

  bool isCollapsed = false;
  bool showBalance = true, showExpenses = true;

  @override
  void initState() {
    super.initState();
    contents = [
      PageContent(
        header: "Total Balance",
        subtitle: "Available funds in wallet",
        colors: const [
          Color.fromRGBO(27, 52, 145, 1.0),
          Color.fromRGBO(6, 166, 205, 1.0)
        ],
        amount: 65000,
      ),
      PageContent(
        header: "Total Expenses",
        subtitle: "Amount spent on the acquires",
        colors: const [
          Color.fromRGBO(242, 37, 136, 1.0),
          Color.fromRGBO(91, 38, 207, 1.0),
          //Color.fromRGBO(242, 37, 136, 1.0)
        ],
        amount: 65000,
      ),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Student student = ref.watch(studentProvider);
    bool notifications = ref.watch(hasNotificationProvider);
    List<HostelInfo> hostels = ref.watch(hostelsProvider);
    List<RoommateInfo> roommates = ref.watch(roommatesProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        WidgetsBinding.instance.addPostFrameCallback((_) => setState(() =>
            isCollapsed = controller.hasClients && controller.offset > 310.h));
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: controller,
          headerSliverBuilder: (context, isScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 320.h,
              elevation: 0.0,
              pinned: true,
              centerTitle: true,
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isCollapsed ? 1 : 0,
                child: Text(
                  "Home",
                  style: context.textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: SizedBox(
                    height: 320.h,
                    child: Column(
                      children: [
                        SizedBox(height: 25.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  context.router.pushNamed(Pages.profile),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 15.r,
                                    backgroundImage: AssetImage(student.image),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Hello, ${student.lastName} ",
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: weirdBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    student.gender == "Female" ? "🧑" : "🧒",
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(fontSize: 24.sp),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: AnimatedSwitcherTranslation.right(
                                duration: const Duration(milliseconds: 500),
                                child: SvgPicture.asset(
                                  "assets/images/Notification ${notifications ? "Active" : "None"}.svg",
                                  height: 25.h,
                                  key: ValueKey<bool>(notifications),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 22.h),
                        SizedBox(
                          width: 414.w,
                          height: 145.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => Container(
                              width: 270.w,
                              height: 145.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: contents[index].colors[1],
                                // gradient: LinearGradient(
                                //   colors: contents[index].colors,
                                //   stops: const [0.4, 1.0],
                                //   begin: Alignment.centerLeft,
                                //   end: Alignment.centerRight,
                                // ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        contents[index].header,
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          fontSize: 17.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => setState(
                                          () {
                                            if (index == 0) {
                                              showBalance = !showBalance;
                                            } else {
                                              showExpenses = !showExpenses;
                                            }
                                          },
                                        ),
                                        child: AnimatedSwitcherZoom.zoomIn(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          child: SvgPicture.asset(
                                            "assets/images/Eye ${((index == 0) ? showBalance : showExpenses) ? "Hidden" : "Visible"}.svg",
                                            key: ValueKey<bool>(
                                              ((index == 0)
                                                  ? showBalance
                                                  : showExpenses),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 25.h),
                                  AnimatedSwitcherZoom.zoomIn(
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      showExpenses
                                          ? "${currency()}${formatAmount(contents[index].amount.toStringAsFixed(0))}"
                                          : "********",
                                      key: ValueKey<bool>(showExpenses),
                                      style: context.textTheme.headlineMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    contents[index].subtitle,
                                    style:
                                        context.textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            separatorBuilder: (_, __) => SizedBox(width: 20.w),
                            itemCount: contents.length,
                          ),
                        ),
                        SizedBox(height: 35.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "My Acquires",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.animateTo(
                                  320.h,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                );
                              },
                              child: Text(
                                "See All",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: TabHeaderDelegate(
                tabBar: TabBar(
                  indicatorColor: appBlue,
                  labelColor: appBlue,
                  labelStyle: context.textTheme.bodyMedium!
                      .copyWith(color: appBlue, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: context.textTheme.bodyMedium!.copyWith(
                      color: Colors.black45, fontWeight: FontWeight.w500),
                  tabs: const [
                    Tab(text: "Hostel"),
                    Tab(text: "Roommate"),
                  ],
                ),
              ),
              pinned: true,
            ),
          ],
          body: TabBarView(
            children: [
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (_, index) => Column(
                        children: [
                          HostelInfoCard(info: hostels[index]),
                          SizedBox(height: 10.h)
                        ],
                      ),
                      childCount: hostels.length,
                    ),
                  ),
                ]
              ),
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (_, index) => Column(
                        children: [
                          RoommateInfoCard(info: roommates[index]),
                          SizedBox(height: 10.h)
                        ],
                      ),
                      childCount: roommates.length,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
