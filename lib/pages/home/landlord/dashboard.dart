import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/landlord_widgets.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/profile/owner/settings.dart';
import 'package:my_hostel/pages/profile/owner/wallet.dart';

import '../chats.dart';
import '../student/explore.dart';

class LandownerDashboardPage extends ConsumerStatefulWidget {
  const LandownerDashboardPage({super.key});

  @override
  ConsumerState<LandownerDashboardPage> createState() => _LandownerDashboardPageState();
}

class _LandownerDashboardPageState extends ConsumerState<LandownerDashboardPage> {
  late List<Widget> stack;

  @override
  void initState() {
    super.initState();
    stack = const [
      _HomePage(),
      ChatsPage(),
      SizedBox(),
      OwnerWalletPage(),
      OwnerSettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    int index = ref.watch(dashboardTabIndexProvider), key = 0;
    bool messages = ref.watch(hasMessagesProvider);

    String messagePath = "assets/images/Message";
    if (messages && index == 1) {
      messagePath = "$messagePath Active Chat.svg";
      key = 1;
    } else if (messages && index != 1) {
      messagePath = "$messagePath Inactive Chat.svg";
      key = 2;
    } else if (!messages && index == 1) {
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
        onTap: (newIndex) => ref.watch(dashboardTabIndexProvider.notifier).state = newIndex,
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
                messagePath,
                color: index != 1 ? weirdBlack50 : null,
                key: ValueKey<int>(key),
                height: 25.h,
              ),
            ),
            label: "Chats",
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/Create Hostel.svg",
              color: weirdBlack50,
              height: 25.h,
            ),
            label: "Create",
          ),

          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                "assets/images/Wallet ${index == 3 ? "Active" : "Inactive"}.svg",
                key: ValueKey<bool>(index == 3),
                color: index != 3 ? weirdBlack50 : null,
                height: 25.h,
              ),
            ),
            label: "Wallet",
          ),

          BottomNavigationBarItem(
            icon: AnimatedSwitcherZoom.zoomIn(
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                "assets/images/Profile ${index == 4 ? "Active" : "Inactive"}.svg",
                color: index != 4 ? weirdBlack50 : null,
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
  const _HomePage({super.key});

  @override
  ConsumerState<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<_HomePage> {
  final ScrollController controller = ScrollController();

  List<HostelInfo> hostels = [];

  bool hostelSelect = true;

  @override
  void initState() {
    super.initState();
    hostels = ref.read(acquiredHostelsProvider);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Landowner owner = ref.watch(ownerProvider);
    bool notifications = ref.watch(hasNotificationProvider);

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          pinned: true,
          centerTitle: true,
          title: GestureDetector(
            onTap: () => context.router.pushNamed(Pages.ownerProfile),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 15.r,
                  backgroundImage: AssetImage(owner.image),
                ),
                SizedBox(width: 10.w),
                Text(
                  "Hello, ${owner.lastName} ",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  owner.gender == "Female" ? "🧑" : "🧒",
                  style: context.textTheme.bodyLarge!.copyWith(fontSize: 22.sp),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 22.w),
              child: GestureDetector(
                onTap: () => context.router.pushNamed(Pages.notification),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "My Hostels Header",
                      child: Text(
                        "My Hostels",
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                    ),
                    if (hostels.length > 3)
                      GestureDetector(
                        onTap: () => context.router.pushNamed(Pages.viewHostels),
                        child: Text(
                          "See All",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue, fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          sliver: hostels.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(
                      "You have no hostels yet! Advertise your hostel without stress!",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack50,
                      ),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      if (index >= hostels.length) {
                        return const SizedBox();
                      }

                      return LandlordHostelCard(info: hostels[index]);
                    },
                    childCount: 3,
                  ),
                ),
        ),
      ],
    );
  }
}
