import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/home/landlord/edit-hostel.dart';


class EditStepFour extends StatefulWidget {
  final HostelInfoData info;

  const EditStepFour({
    super.key,
    required this.info,
  });

  @override
  State<EditStepFour> createState() => _EditStepFourState();
}

class _EditStepFourState extends State<EditStepFour> {
  final TextEditingController rule = TextEditingController();

  @override
  void dispose() {
    rule.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Column(
          children: [
            SizedBox(height: 25.h),
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 4 / totalPages,
                color: appBlue,
                minHeight: 1.5.h,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: "Reset",
                    child: Text(
                      "Save and Exit",
                      style: context.textTheme.bodyMedium,
                    ),
                  )
                ],
                onSelected: (result) =>
                    saveAndExit(info: widget.info, context: context),
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "STEP 4",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: appBlue,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: Text(
                    "Hostel Rules",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: Text(
                    "Define your hostel's rules and regulations to maintain a peaceful and respectful"
                        " living environment for all tenants.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  ),
                ),
                SizedBox(height: 44.h),
                Text(
                  "Hostel Rules & Regulations",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack,
                  ),
                ),
                SpecialForm(
                  controller: rule,
                  width: 414.w,
                  height: 50.h,
                  hint: "i.e The Do's and Don't's of the hostel",
                  suffix: GestureDetector(
                    onTap: () {
                      String text = rule.text.trim();
                      if (text.isNotEmpty) {
                        widget.info.rules.add(text);
                        rule.clear();
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 50.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: fadedBorder,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.r),
                          bottomRight: Radius.circular(5.r),
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.add_circle_outline,
                            color: weirdBlack50, size: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Rules",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.info.rules.length,
                        (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300.w,
                          child: Text(
                            "${index + 1}. ${widget.info.rules[index]}",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: weirdBlack75,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Boxicons.bx_x, color: weirdBlack),
                          iconSize: 20.r,
                          splashRadius: 15.r,
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            widget.info.rules.removeAt(index);
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 300.h),
                Center(
                  child: GestureDetector(
                      onTap: () =>
                          context.router.pushNamed(Pages.tenantAgreement),
                      child: Text(
                        "Tenant Agreement",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: appBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: 414.w,
        height: 90.h,
        color: paleBlue,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => context.router.pop(),
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: appBlue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_left_rounded,
                        color: appBlue, size: 26.r),
                    SizedBox(width: 5.w),
                    Text(
                      "Go back",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: appBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                unFocus();
                if (widget.info.rules.length < 2) {
                  showError("Please add at least two rules for your hostel");
                  return;
                }
                context.router
                    .pushNamed(Pages.editStepFive, extra: widget.info);
              },
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: appBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(Icons.chevron_right_rounded,
                        color: Colors.white, size: 26.r)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}