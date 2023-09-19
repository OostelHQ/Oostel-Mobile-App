import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/transaction.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class OwnerWalletPage extends ConsumerStatefulWidget {
  const OwnerWalletPage({super.key});

  @override
  ConsumerState<OwnerWalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<OwnerWalletPage> {
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
          "Wallet",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 24.h),
              const WalletSlider(),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => context.router.pushNamed(Pages.withdraw),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appBlue,
                  minimumSize: Size(414.w, 50.h),
                  maximumSize: Size(414.w, 50.h),
                ),
                child: Hero(
                  tag: "Withdraw",
                  child: Text(
                    "Withdraw",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
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

class WithdrawPage extends ConsumerStatefulWidget {
  const WithdrawPage({super.key});

  @override
  ConsumerState<WithdrawPage> createState() => _WalletTopUpPageState();
}

class _WalletTopUpPageState extends ConsumerState<WithdrawPage> {
  final TextEditingController number = TextEditingController();
  final TextEditingController expiry = TextEditingController();
  final TextEditingController amount = TextEditingController();

  final List<double> amounts = [
    5000,
    10000,
    20000,
    30000,
    50000,
    100000,
    200000,
    300000,
    500000,
    1000000,
  ];

  String? selectedBank;

  int? selected;

  @override
  void dispose() {
    amount.dispose();
    number.dispose();
    expiry.dispose();
    super.dispose();
  }

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
        title: Hero(
          tag: "Withdraw",
          flightShuttleBuilder: flightShuttleBuilder,
          child: Text(
            "Withdraw",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet.",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),


                Text(
                  "Account Number",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                ComboBox(
                  hint: "Choose your bank",
                  value: selectedBank,
                  dropdownItems: ref.watch(banksProvider),
                  onChanged: (val) => setState(() => selectedBank = val),
                  icon: const Icon(Boxicons.bxs_down_arrow),
                  buttonWidth: 414.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  "Account Number",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: number,
                  width: 414.w,
                  height: 50.h,
                  hint: "0123456789",
                  type: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                Text(
                  "Account Name",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: expiry,
                  width: 414.w,
                  height: 50.h,
                  hint: "e.g John Doe",
                ),
                SizedBox(height: 16.h),
                Text(
                  "Select Amount",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.w,
                  children: List.generate(
                    amounts.length,
                    (index) => GestureDetector(
                      onTap: () {
                        unFocus();
                        setState(() => selected = index);
                        amount.text = amounts[index].toStringAsFixed(0);
                      },
                      child: Container(
                        height: 40.h,
                        width: 105.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: selected != null && selected == index
                                  ? appBlue
                                  : fadedBorder,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                            color: selected != null && selected == index
                                ? paleBlue
                                : null),
                        child: Text(
                          "${currency()}${formatAmountInDouble(amounts[index])}",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: selected != null && selected == index
                                  ? appBlue
                                  : weirdBlack50,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SpecialForm(
                  controller: amount,
                  width: 414.w,
                  height: 50.h,
                  hint: "Enter amount",
                  type: TextInputType.number,
                  onChange: (val) {
                    double? value = double.tryParse(val);
                    if(value == null) return;

                    setState(() {
                      if(amounts.contains(value)) {
                        selected = amounts.indexOf(value);
                      } else {
                        selected = null;
                      }
                    });
                  },
                ),
                SizedBox(height: 150.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBlue,
                    minimumSize: Size(414.w, 50.h),
                    maximumSize: Size(414.w, 50.h),
                  ),
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => const _PaymentModal(status: true),
                  ).then((val) {
                    if (val != null) context.router.pop();
                  }),
                  child: Text(
                    "Withdraw",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
                const Center(child: Copyright()),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentModal extends StatelessWidget {
  final bool status;

  const _PaymentModal({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      width: 414.w,
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
                      child: Image.asset(
                        "assets/images/Withdraw.png",
                        width: 135.r,
                        height: 135.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Withdrawal request sent",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    status
                        ? "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet."
                        : "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 42.h),
                  status
                      ? ElevatedButton(
                          onPressed: () => context.router.pop(status),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBlue,
                          ),
                          child: Text(
                            "Alright",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Row(
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appBlue,
                              ),
                              child: Text(
                                "Try again",
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
    );
  }
}
