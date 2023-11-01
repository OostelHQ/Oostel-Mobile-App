import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
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

class StudentWalletPage extends ConsumerStatefulWidget {
  const StudentWalletPage({super.key});

  @override
  ConsumerState<StudentWalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<StudentWalletPage> {
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
              GestureDetector(
                onTap: () => context.router.pushNamed(Pages.topUp),
                child: Container(
                  width: 414.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: appBlue,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    "Top-up Wallet",
                    style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white),
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
                  if (ref.read(studentTransactionsProvider).length >= 5)
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
              SizedBox(height: 15.h),
              Expanded(
                child: ref.read(studentTransactionsProvider).isEmpty
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
                          if (index >=
                              ref.read(studentTransactionsProvider).length) {
                            return const SizedBox();
                          }

                          return TransactionContainer(
                              transaction:
                                  ref.read(studentTransactionsProvider)[index]);
                        },
                        separatorBuilder: (_, __) => SizedBox(height: 20.h),
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

class WalletTopUpPage extends StatefulWidget {
  const WalletTopUpPage({super.key});

  @override
  State<WalletTopUpPage> createState() => _WalletTopUpPageState();
}

class _WalletTopUpPageState extends State<WalletTopUpPage> {
  final TextEditingController number = TextEditingController();
  final TextEditingController expiry = TextEditingController();
  final TextEditingController ccv = TextEditingController();
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

  int? selected;

  @override
  void dispose() {
    amount.dispose();
    number.dispose();
    expiry.dispose();
    ccv.dispose();
    super.dispose();
  }

  bool isNotFilled() => (amount.text.isEmpty ||
      number.text.isEmpty ||
      expiry.text.isEmpty ||
      ccv.text.isEmpty);

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
          tag: "My Top-Up Wallet",
          flightShuttleBuilder: flightShuttleBuilder,
          child: Text(
            "Top-Up Wallet",
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
                  "Card Number",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: number,
                  width: 414.w,
                  height: 50.h,
                  hint: "0000 0000 0000 0000",
                  type: TextInputType.number,
                  onChange: (val) => setState(() {}),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Card Expiry",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: expiry,
                  width: 414.w,
                  height: 50.h,
                  hint: "MM/YY",
                  type: TextInputType.number,
                  maxLength: 4,
                  onChange: (val) => setState(() {}),
                ),
                SizedBox(height: 16.h),
                Text(
                  "CVV",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: ccv,
                  width: 414.w,
                  height: 50.h,
                  hint: "123",
                  type: TextInputType.number,
                  maxLength: 3,
                  onChange: (val) => setState(() {}),
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
                    if (value == null) return;

                    setState(() {
                      if (amounts.contains(value)) {
                        selected = amounts.indexOf(value);
                      } else {
                        selected = null;
                      }
                    });
                  },
                ),
                SizedBox(height: 150.h),
                GestureDetector(
                  onTap: () {
                    if (isNotFilled()) return;
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => const _PaymentModal(status: false),
                    ).then((val) {
                      if (val != null) context.router.pop();
                    });
                  },
                  child: Container(
                    width: 414.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isNotFilled() ? appBlue.withOpacity(0.4) : appBlue,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      "Top-Up",
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
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
                  SizedBox(height: 55.h),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r),
                      ),
                      child: Image.asset(
                        "assets/images/Hostel Pay ${status ? "Success" : "Fail"}.png",
                        width: 135.r,
                        height: 135.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Top-Up ${status ? "Successful" : "Failed"}",
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
                  SizedBox(height: 50.h),
                  GestureDetector(
                    onTap: () => context.router.pop(status),
                    child: Container(
                      width: 414.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appBlue,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        status
                            ? "Ok, Thanks" : "Try Again",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
