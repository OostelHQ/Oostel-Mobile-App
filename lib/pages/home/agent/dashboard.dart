import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/landlord_widgets.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/profile/agent/settings.dart';
import 'package:my_hostel/pages/profile/agent/wallet.dart';

import '../../chats/chats.dart';

class AgentDashboardPage extends ConsumerStatefulWidget {
  const AgentDashboardPage({super.key});

  @override
  ConsumerState<AgentDashboardPage> createState() => _AgentDashboardPageState();
}

class _AgentDashboardPageState extends ConsumerState<AgentDashboardPage> {
  late List<Widget> stack;

  @override
  void initState() {
    super.initState();
    stack = const [
      _HomePage(),
      ChatsPage(),
      SizedBox(),
      AgentWalletPage(),
      AgentSettingsPage(),
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
        onTap: (newIndex) {
          if (newIndex == 2) {
            context.router.pushNamed(Pages.stepOne);
          } else {
            ref.watch(dashboardTabIndexProvider.notifier).state = newIndex;
          }
        },
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
  const _HomePage();

  @override
  ConsumerState<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<_HomePage> with SingleTickerProviderStateMixin  {
  final ScrollController controller = ScrollController();

  List<HostelInfo> hostels = [];

  bool hostelSelect = true;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    hostels = ref.read(ownerHostelsProvider);
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
      Future.delayed(const Duration(seconds: 3),
              () => animationController.forward());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(currentUserProvider);
    bool notifications = ref.watch(newNotificationProvider);

    return Stack(
      children: [
        CustomScrollView(
          controller: controller,
          slivers: [
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              pinned: true,
              centerTitle: true,
              title: GestureDetector(
                onTap: () => context.router.pushNamed(Pages.agentProfile),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    user.image == ""
                        ? CircleAvatar(
                      radius: 15.r,
                      backgroundColor: appBlue,
                      child: Text(
                        user.firstName.substring(0, 1),
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )
                        : CachedNetworkImage(
                      imageUrl: user.image,
                      errorWidget: (context, url, error) => CircleAvatar(
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
                      progressIndicatorBuilder: (context, url, download) {
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
                    const _HostelDetailsSlider(),
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
                            onTap: () =>
                                context.router.pushNamed(Pages.viewHostels),
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
                    if (index == 3) {
                      return SizedBox(height: 50.h);
                    }

                    return LandlordHostelCard(info: hostels[index]);
                  },
                  childCount: 4,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizeTransition(
            sizeFactor: animation,
            child: ProfileNotification(onCancel: () => animationController.reverse()),
          ),
        ),
      ]
    );
  }
}

class _HostelDetailsSlider extends ConsumerStatefulWidget {
  const _HostelDetailsSlider();

  @override
  ConsumerState<_HostelDetailsSlider> createState() =>
      _HostelDetailsSliderState();
}

class _HostelDetailsSliderState extends ConsumerState<_HostelDetailsSlider> {
  bool showBalance = true, showExpenses = true;

  double scrollValue = 0.0;

  String amount(int index) {
    double amount =
        (index == 0) ? ref.read(walletProvider) : ref.read(expensesProvider);
    return "${currency()}${formatAmount(amount.toStringAsFixed(0))}";
  }

  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => setState(() => scrollValue = controller.offset / 162.0));
            return true;
          },
          child: SizedBox(
            width: 414.w,
            height: 145.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              controller: controller,
              itemBuilder: (_, index) => Container(
                width: 270.w,
                height: 145.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: index == 0 ? appBlue : const Color(0xFF116BAE),
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
                          index == 0
                              ? "Manchester Hostel"
                              : "Total Available Rooms",
                          style: context.textTheme.bodyLarge!.copyWith(
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
                                ((index == 0) ? showBalance : showExpenses),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 25.h),
                    AnimatedSwitcherTranslation.top(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        (index == 0)
                            ? (showBalance ? amount(index) : "********")
                            : "013",
                        key: ValueKey<bool>(
                            ((index == 0) ? showBalance : showExpenses)),
                        style: context.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      index == 1
                          ? "Rooms left in your hostel"
                          : "23rd August, 2023 7:23 AM",
                      style: context.textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (_, __) => SizedBox(width: 20.w),
              itemCount: 2,
            ),
          ),
        ),
        SizedBox(height: 25.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10.r,
              width: 10.r,
              decoration: BoxDecoration(
                  color:
                      Color.lerp(appBlue, const Color(0xFFD9EAFF), scrollValue),
                  shape: BoxShape.circle),
            ),
            SizedBox(width: 10.w),
            Container(
              height: 10.r,
              width: 10.r,
              decoration: BoxDecoration(
                  color:
                      Color.lerp(const Color(0xFFD9EAFF), appBlue, scrollValue),
                  shape: BoxShape.circle),
            ),
          ],
        ),
      ],
    );
  }
}
