import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hostel/components/receipt_info.dart';
import 'package:my_hostel/components/transaction.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';

class WalletSlider extends ConsumerStatefulWidget {
  const WalletSlider({super.key});

  @override
  ConsumerState<WalletSlider> createState() => _WalletSliderState();
}

class _WalletSliderState extends ConsumerState<WalletSlider> {
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
                          "Total ${index == 0 ? "Balance" : "Expenses"}",
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
                        ((index == 0) ? showBalance : showExpenses)
                            ? amount(index)
                            : "********",
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
                      index == 0
                          ? "Available funds in wallet"
                          : "Amount spent on acquires",
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

class TransactionContainer extends StatelessWidget {
  final Transaction transaction;

  const TransactionContainer({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.transactionDetails,
        extra: transaction,
      ),
      child: Container(
        width: 414.w,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FBFF),
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE0E5EC),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            )
          ],
        ),
        child: SizedBox(
          height: 80.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              Container(
                width: 50.r,
                height: 50.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: paleBlue,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset("assets/images/Top Up.svg"),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                width: 300.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          transaction.purpose,
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        Text(
                          "${transaction.type == TransactionType.credit ? "+" : "-"}"
                              "${currency()}"
                              "${formatAmountInDouble(transaction.amount)}",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatDateWithTime(transaction.timestamp,
                              shorten: true),
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          fromStatus(transaction.status),
                          style: context.textTheme.bodyMedium!.copyWith(
                            color:
                            transaction.status == TransactionStatus.success
                                ? successColor
                                : (transaction.status ==
                                TransactionStatus.failed
                                ? failColor
                                : pendingColor),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentTransactionDetailsContainer extends StatelessWidget {
  final Transaction transaction;

  const StudentTransactionDetailsContainer({
    super.key,
    required this.transaction,
  });

  Widget rent(BuildContext context) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Recipient",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.receiver,
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: weirdBlack,
            ),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Paid through",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            "Oostel App Wallet",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Payment ID",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.paymentID,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "VAT",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            "${currency()}${formatAmountInDouble(transaction.vat)}",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
    ],
  );

  Widget topUp(BuildContext context) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bank Name",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.bankName!,
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: weirdBlack,
            ),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Account Number",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.accountNumber!,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Account Name",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.receiver,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Received by",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            "Oostel App",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Payment ID",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.paymentID,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "VAT",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            "${currency()}${formatAmountInDouble(transaction.vat)}",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF8FBFF),
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE0E5EC),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              Container(
                width: 50.r,
                height: 50.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: paleBlue,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset("assets/images/Top Up.svg"),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                width: 280.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          transaction.purpose,
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                        Text(
                          "${transaction.type == TransactionType.credit ? "+" : "-"}"
                              "${currency()}"
                              "${formatAmountInDouble(transaction.amount)}",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatDateWithTime(transaction.timestamp,
                              shorten: true),
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          fromStatus(transaction.status),
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: transaction.status ==
                                  TransactionStatus.success
                                  ? successColor
                                  : (transaction.status ==
                                  TransactionStatus.failed
                                  ? failColor
                                  : pendingColor),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 340.w,
              minHeight: 1.h,
              maxWidth: 340.w,
              maxHeight: 1.h,
            ),
            child: const ColoredBox(color: Colors.black12),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: transaction.purpose == "Hostel Payment"
                ? rent(context)
                : (transaction.purpose == "Top-up Wallet")
                ? topUp(context)
                : const SizedBox(),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class OwnerTransactionDetailsContainer extends StatelessWidget {
  final Transaction transaction;

  const OwnerTransactionDetailsContainer({
    super.key,
    required this.transaction,
  });

  Widget rent(BuildContext context) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sender's name",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.receiver,
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: weirdBlack,
            ),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Paid for",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.hostel!,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Paid through",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            "Oostel App",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Payment ID",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.paymentID,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "VAT",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            "${currency()}${formatAmountInDouble(transaction.vat)}",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
    ],
  );

  Widget topUp(BuildContext context) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bank Name",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.bankName!,
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: weirdBlack,
            ),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Account Number",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.accountNumber!,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Account Name",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.receiver,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sent from",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            "Oostel App Wallet",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Payment ID",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            transaction.paymentID,
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "VAT",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
          ),
          Text(
            "${currency()}${formatAmountInDouble(transaction.vat)}",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w500, color: weirdBlack),
          )
        ],
      ),
      SizedBox(height: 20.h),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF8FBFF),
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE0E5EC),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          if (transaction.purpose == "Withdrawal")
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 30.r,
                            minHeight: 30.r,
                            maxWidth: 30.r,
                            maxHeight: 30.r,
                          ),
                          child: ColoredBox(
                            color: successColor,
                            child: Icon(
                              Icons.done_rounded,
                              color: Colors.white,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 80.w,
                          minHeight: 1.5.h,
                          maxWidth: 80.w,
                          maxHeight: 1.5.h,
                        ),
                        child: const ColoredBox(color: successColor),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 30.r,
                            minHeight: 30.r,
                            maxWidth: 30.r,
                            maxHeight: 30.r,
                          ),
                          child: ColoredBox(
                            color: successColor,
                            child: Icon(
                              Icons.done_rounded,
                              color: Colors.white,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 80.w,
                          minHeight: 1.5.h,
                          maxWidth: 80.w,
                          maxHeight: 1.5.h,
                        ),
                        child: const ColoredBox(color: successColor),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 30.r,
                            minHeight: 30.r,
                            maxWidth: 30.r,
                            maxHeight: 30.r,
                          ),
                          child: ColoredBox(
                            color: successColor,
                            child: Icon(
                              Icons.done_rounded,
                              color: Colors.white,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Payment",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                            Text(
                              "Successful",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Processing",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                            Text(
                              "by bank",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Received",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                            Text(
                              "by bank",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 320.w,
                    minHeight: 1.h,
                    maxWidth: 320.w,
                    maxHeight: 1.h,
                  ),
                  child: const ColoredBox(color: Colors.black12),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10.w),
              Container(
                width: 50.r,
                height: 50.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: paleBlue,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset("assets/images/Top Up.svg"),
              ),
              SizedBox(width: 15.w),
              SizedBox(
                width: 280.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            transaction.purpose,
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600, color: weirdBlack),
                          ),
                          Text(
                            "${transaction.type == TransactionType.credit ? "+" : "-"}"
                                "${currency()}"
                                "${formatAmountInDouble(transaction.amount)}",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600, color: weirdBlack),
                          ),
                        ]),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatDateWithTime(transaction.timestamp,
                              shorten: true),
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack50, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          fromStatus(transaction.status),
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: transaction.status ==
                                  TransactionStatus.success
                                  ? successColor
                                  : (transaction.status ==
                                  TransactionStatus.failed
                                  ? failColor
                                  : pendingColor),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 320.w,
              minHeight: 1.h,
              maxWidth: 320.w,
              maxHeight: 1.h,
            ),
            child: const ColoredBox(color: Colors.black12),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: transaction.purpose == "Money Received"
                ? rent(context)
                : (transaction.purpose == "Withdrawal")
                ? topUp(context)
                : const SizedBox(),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class ReceiptContainer extends StatelessWidget {
  final Receipt receipt;

  const ReceiptContainer({
    super.key,
    required this.receipt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: paleBlue,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "House Rent Proof of Payment",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
              SizedBox(height: 14.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "I, ",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: receipt.studentName,
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: ", hereby paid the total sum of ",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: receipt.amountInWords,
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: " for an hostel rent to ",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: receipt.landOwnerName,
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: " as the owner of ",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: receipt.hostel,
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: ".",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "REF: ${receipt.reference}",
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: weirdBlack50),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${formatDateRaw(receipt.timestamp, shorten: true)}.",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500, color: weirdBlack50),
                      ),
                      SizedBox(height: 4.h),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 120.w,
                          minHeight: 1.h,
                          maxWidth: 120.w,
                          maxHeight: 1.h,
                        ),
                        child: const ColoredBox(color: weirdBlack),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Date Issued",
                        style: context.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500, color: weirdBlack50),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Oostel",
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500, color: weirdBlack50),
                      ),
                      SizedBox(height: 4.h),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 120.w,
                          minHeight: 1.h,
                          maxWidth: 120.w,
                          maxHeight: 1.h,
                        ),
                        child: const ColoredBox(color: weirdBlack),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Authorized",
                        style: context.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500, color: weirdBlack50),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
