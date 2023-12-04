import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class AgentWalletPage extends ConsumerStatefulWidget {
  const AgentWalletPage({super.key});

  @override
  ConsumerState<AgentWalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<AgentWalletPage> {

  bool showAmount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Text(
          "Wallet",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 22.w),
            child: GestureDetector(
              onTap: () => context.router.pushNamed(Pages.notification),
              child: AnimatedSwitcherTranslation.right(
                duration: const Duration(milliseconds: 500),
                child: SvgPicture.asset(
                  "assets/images/Notification ${ref.watch(newNotificationProvider) ? "Active" : "None"}.svg",
                  height: 25.h,
                  key: ValueKey<bool>(ref.watch(newNotificationProvider)),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Container(
                width: 414.w,
                height: 145.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: appBlue,
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
                          "Manchester",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => showAmount = !showAmount),
                          child: AnimatedSwitcherZoom.zoomIn(
                            duration: const Duration(milliseconds: 500),
                            child: SvgPicture.asset(
                              "assets/images/Eye ${!showAmount ? "Hidden" : "Visible"}.svg",
                              key: ValueKey<bool>(showAmount),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 25.h),
                    AnimatedSwitcherTranslation.top(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        showAmount
                            ? "${currency()}${formatAmount(100000.toStringAsFixed(0))}"
                            : "********",
                        key: ValueKey<bool>(showAmount),
                        style: context.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text("23rd August, 2023 7:23 AM",
                      style: context.textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 34.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: "My Transaction History",
                    child: Text(
                      "Transaction History",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                  ),
                  if (ref.read(ownerTransactionsProvider).length >= 5)
                    GestureDetector(
                      onTap: () =>
                          context.router.pushNamed(Pages.transactionHistory),
                      child: Text(
                        "See All",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: appBlue, fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ref.read(ownerTransactionsProvider).isEmpty
                    ? Center(
                  child: Text(
                    "You have not made any transactions yet!",
                    style: context.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack75,
                    ),
                  ),
                )
                    : ListView.separated(
                  itemBuilder: (_, index) {
                    if (index >= ref.read(ownerTransactionsProvider).length) {
                      return const SizedBox();
                    }

                    return TransactionContainer(
                        transaction:
                        ref.read(ownerTransactionsProvider)[index]);
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemCount: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
