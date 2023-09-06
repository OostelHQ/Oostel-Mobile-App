import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/roommate_info.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/student.dart';

import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';

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
    ];
  }

  @override
  Widget build(BuildContext context) {
    int index = ref.watch(dashboardTabIndexProvider);

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: index,
          children: stack,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) =>
            ref.watch(dashboardTabIndexProvider.notifier).state = newIndex,
        selectedItemColor: appBlue,
        selectedLabelStyle: context.textTheme.bodySmall!
            .copyWith(color: appBlue, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            context.textTheme.bodySmall!.copyWith(color: weirdBlack),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, color: Colors.grey),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded, color: Colors.grey),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded, color: Colors.grey),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded, color: Colors.grey),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

enum _AcquireType { hostel, roommate }

class _HomePage extends ConsumerStatefulWidget {
  const _HomePage({super.key});

  @override
  ConsumerState<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<_HomePage> {
  final ScrollController controller = ScrollController();
  _AcquireType type = _AcquireType.hostel;

  final List<RoommateInfo> roommates = [];
  final List<HostelInfo> hostels = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget createRoommate(RoommateInfo info) => Card(
        elevation: 1.0,
        child: SizedBox(
          height: 100.h,
          width: 414.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [],
            ),
          ),
        ),
      );

  Widget createHostel(HostelInfo info) => Card(
        elevation: 1.0,
        child: SizedBox(
          height: 100.h,
          width: 414.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                Container(
                  color: appBlue,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    info.image,
                    height: 100.h,
                    width: 125.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(info.name, style: context.textTheme.headlineSmall)
                      ],
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Student student = ref.watch(studentProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 15.r,
                    backgroundImage: const AssetImage("assets/images/watch man.jpg"),
                  ),
                  SizedBox(width: 10.w),
                  Text("Hello, ${student.lastName}"),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.notifications_rounded, size: 26.r),
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
                decoration: BoxDecoration(
                  color: index == 0 ? appBlue : Colors.red,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              separatorBuilder: (_, __) => SizedBox(width: 20.w),
              itemCount: 2,
            ),
          ),
          SizedBox(height: 20.h),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                2,
                (index) => Container(
                  width: 10.r,
                  height: 10.r,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                ),
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
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700, color: weirdBlack),
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
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (type != _AcquireType.hostel) {
                    setState(() => type = _AcquireType.hostel);
                  }
                },
                child: Container(
                  width: 212.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: type == _AcquireType.hostel
                        ? appBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.r),
                        bottomLeft: Radius.circular(5.r)),
                    border: type == _AcquireType.hostel
                        ? null
                        : Border.all(color: appBlue),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (type != _AcquireType.roommate) {
                    setState(() => type = _AcquireType.roommate);
                  }
                },
                child: Container(
                  width: 212.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: type == _AcquireType.roommate
                        ? appBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.r),
                        bottomRight: Radius.circular(5.r)),
                    border: type == _AcquireType.roommate
                        ? null
                        : Border.all(color: appBlue),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) {
                if (type == _AcquireType.hostel) {
                  return createHostel(hostels[index]);
                } else {
                  return createRoommate(roommates[index]);
                }
              },
              separatorBuilder: (_, __) => SizedBox(height: 20.h),
              itemCount: type == _AcquireType.roommate
                  ? roommates.length
                  : hostels.length,
            ),
          )
        ],
      ),
    );
  }
}
