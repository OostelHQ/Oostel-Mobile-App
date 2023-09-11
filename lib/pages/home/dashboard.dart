import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/roommate_info.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/student.dart';

import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

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
      _ExplorePage(),
      _ChatsPage(),
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

enum _AcquireType { hostel, roommate }

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

class _HomePageState extends ConsumerState<_HomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController controller = ScrollController();
  late AnimationController animationController;
  late Animation<double> animation, reverseAnimation;

  _AcquireType type = _AcquireType.hostel;

  late List<RoommateInfo> roommates = [];
  late List<HostelInfo> hostels = [];

  late List<PageContent> contents;

  bool showBalance = true, viewAcquires = false, showExpenses = true;

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
          Color.fromRGBO(91, 38, 207, 1.0),
          Color.fromRGBO(242, 37, 136, 1.0)
        ],
        amount: 65000,
      ),
    ];

    Landowner owner = Landowner(
      id: "123456",
      image: "assets/images/watch man.jpg",
      lastName: "Julius",
      firstName: "Adeyemi",
      verified: false,
      ratings: 5.0,
      dateJoined: DateTime.now(),
    );

    Student student = const Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
    );

    hostels = [
      HostelInfo(
        id: "1",
        name: "Manchester Hostel",
        image: "assets/images/street.jpg",
        bedrooms: 1,
        bathrooms: 1,
        area: 2500,
        price: 100000,
        roomsLeft: 5,
        owner: owner,
        address: "",
      ),
      HostelInfo(
        id: "2",
        name: "Liverpool Hostel",
        image: "assets/images/street.jpg",
        bedrooms: 2,
        bathrooms: 1,
        area: 2500,
        price: 100000,
        roomsLeft: 1,
        owner: owner,
        address: "",
      ),
      HostelInfo(
        id: "3",
        name: "Aubrey Hostel",
        image: "assets/images/street.jpg",
        bedrooms: 1,
        bathrooms: 1,
        area: 2000,
        price: 90000,
        roomsLeft: 15,
        owner: owner,
        address: "",
      ),
      HostelInfo(
        id: "4",
        name: "Test Hostel",
        image: "assets/images/street.jpg",
        bedrooms: 1,
        bathrooms: 1,
        area: 2000,
        price: 120000,
        roomsLeft: 5,
        owner: owner,
        address: "",
      ),
      HostelInfo(
        id: "5",
        name: "Hostel Five",
        image: "assets/images/street.jpg",
        bedrooms: 1,
        bathrooms: 1,
        area: 2500,
        price: 10000,
        roomsLeft: 5,
        owner: owner,
        address: "",
      ),
    ];

    roommates = [
      RoommateInfo(
        student: student,
        level: 100,
        location: "Harmony",
        amount: 50000,
        available: true,
      ),
      // RoommateInfo(
      //   student: student,
      //   level: 300,
      //   location: "Isolu",
      //   amount: 75000,
      //   available: true,
      // ),
      // RoommateInfo(
      //   student: student,
      //   level: 200,
      //   location: "Accord",
      //   amount: 50000,
      //   available: false,
      // ),
      // RoommateInfo(
      //   student: student,
      //   level: 500,
      //   location: "Kofesu",
      //   amount: 40000,
      //   available: false,
      // )
    ];

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );

    reverseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: animationController, curve: Curves.fastEaseInToSlowEaseOut),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  void toggleAcquires() {
    setState(() => viewAcquires = !viewAcquires);
    if (viewAcquires) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Student student = ref.watch(studentProvider);
    bool notifications = ref.watch(hasNotificationProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        children: [
          SizeTransition(
            sizeFactor: animation,
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => context.router.pushNamed(Pages.profile),
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
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(student.gender == "Female" ? "🧑" : "🧒",
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontSize: 24.sp
                              ),
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
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => Container(
                        width: 270.w,
                        height: 145.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          gradient: LinearGradient(
                            colors: contents[index].colors,
                            stops: const [0.4, 1.0],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  contents[index].header,
                                  style: context.textTheme.bodyLarge!.copyWith(
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
                                    duration: const Duration(milliseconds: 500),
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
                                showBalance
                                    ? "${currency()}${formatAmount(contents[index].amount.toStringAsFixed(0))}"
                                    : "********",
                                key: ValueKey<bool>(showBalance),
                                style:
                                    context.textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              contents[index].subtitle,
                              style: context.textTheme.bodySmall!.copyWith(
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
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (index) => Container(
                        width: 10.r,
                        height: 10.r,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: appBlue),
                      ),
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
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      GestureDetector(
                        onTap: toggleAcquires,
                        child: Text(
                          "See All",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (type != _AcquireType.hostel) {
                            setState(() => type = _AcquireType.hostel);
                          }
                        },
                        child: AnimatedSwitcherFlip.flipX(
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            width: 185.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            key: ValueKey<bool>(type == _AcquireType.hostel),
                            decoration: BoxDecoration(
                              color: type == _AcquireType.hostel
                                  ? appBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.r),
                                bottomLeft: Radius.circular(5.r),
                              ),
                              border: type == _AcquireType.hostel
                                  ? null
                                  : Border.all(color: appBlue),
                            ),
                            child: Text(
                              "Hostel",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: type == _AcquireType.hostel
                                      ? Colors.white
                                      : appBlue),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (type != _AcquireType.roommate) {
                            setState(() => type = _AcquireType.roommate);
                          }
                        },
                        child: AnimatedSwitcherFlip.flipX(
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            width: 185.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            key: ValueKey<bool>(type == _AcquireType.roommate),
                            decoration: BoxDecoration(
                              color: type == _AcquireType.roommate
                                  ? appBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.r),
                                bottomRight: Radius.circular(5.r),
                              ),
                              border: type == _AcquireType.roommate
                                  ? null
                                  : Border.all(color: appBlue),
                            ),
                            child: Text(
                              "Roommate",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: type == _AcquireType.roommate
                                      ? Colors.white
                                      : appBlue),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) {
                if (type == _AcquireType.hostel) {
                  return HostelInfoCard(
                      info: hostels[index - (viewAcquires ? 1 : 0)]);
                } else {
                  return RoommateInfoCard(
                      info: roommates[index - (viewAcquires ? 1 : 0)]);
                }
              },
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemCount: type == _AcquireType.roommate
                  ? roommates.length + (viewAcquires ? 1 : 0)
                  : hostels.length + (viewAcquires ? 1 : 0),
            ),
          )
        ],
      ),
    );
  }
}

class _ExplorePage extends StatefulWidget {
  const _ExplorePage({super.key});

  @override
  State<_ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<_ExplorePage> {
  final TextEditingController controller = TextEditingController();

  late List<HostelInfo> hostels;
  late List<RoommateInfo> roommates;

  @override
  void initState() {
    super.initState();

    Landowner owner = Landowner(
      id: "123456",
      image: "assets/images/watch man.jpg",
      lastName: "Julius",
      firstName: "Adeyemi",
      verified: false,
      ratings: 5.0,
      dateJoined: DateTime.now(),
    );

    hostels = [
      // HostelInfo(
      //   id: "1",
      //   name: "Manchester Hostel Askj",
      //   image: "assets/images/street.jpg",
      //   bedrooms: 1,
      //   bathrooms: 1,
      //   area: 2500,
      //   price: 100000,
      //   roomsLeft: 5,
      //   address: "Harmony Estate",
      //   owner: owner,
      // ),
      // HostelInfo(
      //   id: "2",
      //   name: "Liverpool Hostel",
      //   image: "assets/images/street.jpg",
      //   bedrooms: 2,
      //   bathrooms: 1,
      //   area: 2500,
      //   price: 100000,
      //   roomsLeft: 1,
      //   address: "Harmony Estate",
      //   owner: owner,
      // ),
      // HostelInfo(
      //   id: "3",
      //   name: "Aubrey Hostel",
      //   image: "assets/images/street.jpg",
      //   bedrooms: 1,
      //   bathrooms: 1,
      //   area: 2000,
      //   price: 90000,
      //   roomsLeft: 15,
      //   address: "Harmony Estate, Federal University of Agriculture",
      //   owner: owner,
      // ),
      // HostelInfo(
      //   id: "4",
      //   name: "Test Hostel",
      //   image: "assets/images/street.jpg",
      //   bedrooms: 1,
      //   bathrooms: 1,
      //   area: 2000,
      //   price: 120000,
      //   roomsLeft: 5,
      //   address: "Harmony Estate",
      //   owner: owner,
      // ),
      // HostelInfo(
      //   id: "5",
      //   name: "Hostel Five",
      //   image: "assets/images/street.jpg",
      //   bedrooms: 1,
      //   bathrooms: 1,
      //   area: 2500,
      //   price: 10000,
      //   roomsLeft: 5,
      //   address: "Harmony Estate",
      //   owner: owner,
      // ),
    ];

    Student student = const Student(
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      image: "assets/images/watch man.jpg",
    );

    roommates = [
      RoommateInfo(
        student: student,
        level: 100,
        location: "Harmony",
        amount: 50000,
        available: true,
      ),
      RoommateInfo(
        student: student,
        level: 300,
        location: "Isolu",
        amount: 75000,
        available: true,
      ),
      RoommateInfo(
        student: student,
        level: 200,
        location: "Accord",
        amount: 50000,
        available: false,
      ),
      RoommateInfo(
        student: student,
        level: 500,
        location: "Kofesu",
        amount: 40000,
        available: false,
      )
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            Text("Explore",
                style: context.textTheme.headlineSmall!
                    .copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            Text("Find the best and your desired hostel",
                style:
                    context.textTheme.bodyMedium!.copyWith(color: weirdBlack)),
            SizedBox(height: 12.h),
            SpecialForm(
              controller: controller,
              width: 414.w,
              height: 40.h,
              fillColor: Colors.white,
              hint: "Search here...",
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories",
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See All",
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: appBlue, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 110.r,
              width: 414.w,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 110.r,
                    width: 110.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: paleBlue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 55.r,
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        Text(
                          "Self Contained",
                          style: context.textTheme.bodySmall!.copyWith(
                              color: weirdBlack, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (_, __) => SizedBox(width: 20.w),
                itemCount: 3,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Hostels",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See All",
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: appBlue, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 260.h,
              width: 414.w,
              // child: ListView.separated(
              //   scrollDirection: Axis.horizontal,
              //   itemBuilder: (_, index) => GestureDetector(
              //     onTap: () {},
              //     child: HostelExploreCard(
              //       info: hostels[index],
              //     ),
              //   ),
              //   separatorBuilder: (_, __) => SizedBox(width: 20.w),
              //   itemCount: 3,
              // ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Roommates",
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See All",
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: appBlue, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 500.h,
              child: ListView.separated(
                itemBuilder: (_, index) {
                  if (index == roommates.length) {
                    return SizedBox(height: 30.h);
                  }

                  return RoommateInfoCard(info: roommates[index]);
                },
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemCount: roommates.length + 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ChatsPage extends StatefulWidget {
  const _ChatsPage({super.key});

  @override
  State<_ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<_ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}