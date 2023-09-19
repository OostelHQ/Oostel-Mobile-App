import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/transaction.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class TransactionDetailsPage extends ConsumerWidget {
  final Transaction transaction;

  const TransactionDetailsPage({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isStudent = ref.watch(isAStudent);
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
          "Transaction Details",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                isStudent
                    ? StudentTransactionDetailsContainer(transaction: transaction)
                    : OwnerTransactionDetailsContainer(transaction: transaction),
                SizedBox(height: 270.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBlue,
                    minimumSize: Size(414.w, 50.h),
                    maximumSize: Size(414.w, 50.h),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Download Receipt",
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

class TransactionHistoryPage extends ConsumerStatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  ConsumerState<TransactionHistoryPage> createState() =>
      _TransactionHistoryPageState();
}

class _TransactionHistoryPageState
    extends ConsumerState<TransactionHistoryPage> {
  String? filter, sort;

  @override
  Widget build(BuildContext context) {
    bool isStudent = ref.watch(isAStudent);
    List<Transaction> transactions = isStudent
        ? ref.watch(studentTransactionsProvider)
        : ref.watch(ownerTransactionsProvider);

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
          tag: "My Transaction History",
          flightShuttleBuilder: flightShuttleBuilder,
          child: Text(
            "Transaction History",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ComboBox(
                  hint: "Filter: ",
                  value: filter,
                  dropdownItems: const [
                    "Today",
                    "Yesterday",
                    "Last 14 days",
                    "Last 21 days",
                    "Last 30 days",
                    "Last 3 months",
                    "Last 9 months",
                    "Last 1 year",
                    "All"
                  ],
                  onChanged: (val) => setState(() => filter = val),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 30.r,
                  iconEnabledColor: appBlue,
                  iconDisabledColor: weirdBlack50,
                ),
                ComboBox(
                  hint: "Sort: ",
                  value: sort,
                  dropdownItems: const [
                    "All",
                    "Successful",
                    "Pending",
                    "Failed",
                  ],
                  onChanged: (val) => setState(() => sort = val),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 30.r,
                  iconEnabledColor: appBlue,
                  iconDisabledColor: weirdBlack50,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) {
                  if (index == transactions.length) {
                    return Column(
                      children: [
                        SizedBox(height: 48.h),
                        const Center(child: Copyright()),
                        SizedBox(height: 24.h),
                      ],
                    );
                  }

                  return TransactionContainer(transaction: transactions[index]);
                },
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemCount: transactions.length + 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
