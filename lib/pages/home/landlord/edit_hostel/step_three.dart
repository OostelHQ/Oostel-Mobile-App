import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/home/landlord/edit-hostel.dart';


class EditStepThree extends StatefulWidget {
  final HostelInfoData info;

  const EditStepThree({
    super.key,
    required this.info,
  });

  @override
  State<EditStepThree> createState() => _EditStepThreeState();
}

class _EditStepThreeState extends State<EditStepThree>
    with SingleTickerProviderStateMixin {
  bool share = false;

  late AnimationController controller;
  late Animation<double> animation;

  late TextEditingController street;
  late TextEditingController junction;
  late TextEditingController state;
  late TextEditingController country;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    List<String> address = widget.info.address.split("#");
    street = TextEditingController(text: address[0]);
    junction = TextEditingController(text: address[1]);
    state = TextEditingController(text: address[2]);
    country = TextEditingController(text: address[3]);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    controller.reverse();
  }

  @override
  void dispose() {
    street.dispose();
    junction.dispose();
    state.dispose();
    country.dispose();
    controller.dispose();
    super.dispose();
  }

  bool get isFilled =>
      street.text.trim().isNotEmpty &&
          junction.text.trim().isNotEmpty &&
          state.text.trim().isNotEmpty &&
          country.text.trim().isNotEmpty;

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
                value: 3 / totalPages,
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
                onSelected: (result) => saveAndExit(
                    info: widget.info, context: context, formKey: formKey),
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "STEP 3",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      "Hostel Location",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      "Specify your hostel's location and help tenants find your property "
                          "easily and understand its surroundings.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 44.h),
                  Text(
                    "Street",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: street,
                    width: 414.w,
                    height: 50.h,
                    hint: "i.e Behind Abans Factory",
                    onChange: (val) => textChecker(
                      text: val,
                      onAction: () => setState(() {}),
                    ),
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the street of your hostel.");
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Junction",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: junction,
                    width: 414.w,
                    height: 50.h,
                    hint: "i.e Accord",
                    onChange: (val) => textChecker(
                      text: val,
                      onAction: () => setState(() {}),
                    ),
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the junction of your hostel.");
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "State/Region",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: state,
                    width: 414.w,
                    height: 50.h,
                    hint: "i.e Ogun State",
                    onChange: (val) => textChecker(
                      text: val,
                      onAction: () => setState(() {}),
                    ),
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the state of your hostel.");
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Country/Nation",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: country,
                    width: 414.w,
                    height: 50.h,
                    hint: "i.e Nigeria",
                    onChange: (val) => textChecker(
                      text: val,
                      onAction: () => setState(() {}),
                    ),
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the country of your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info.address =
                    "${street.text.trim()}#${junction.text.trim()}#${street.text.trim()}#${country.text.trim()}",
                  ),
                  SizedBox(height: 16.h),
                  // Row(
                  //   children: [
                  //     Switch(
                  //       value: share,
                  //       onChanged: (value) {
                  //         setState(() => share = !share);
                  //         if (share) {
                  //           controller.forward();
                  //         } else {
                  //           controller.reverse();
                  //         }
                  //       },
                  //       activeColor: appBlue,
                  //     ),
                  //     Text(
                  //       "Activate Google Maps to share your location",
                  //       style: context.textTheme.bodySmall!.copyWith(
                  //         fontWeight: FontWeight.w500,
                  //         color: weirdBlack75,
                  //         fontSize: 15.sp,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 20.h),
                  SizeTransition(
                    sizeFactor: animation,
                    child: Container(
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
                        height: 70.h,
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
                              child: SvgPicture.asset(
                                  "assets/images/Profile Blue Location.svg"),
                            ),
                            SizedBox(width: 15.w),
                            SizedBox(
                              width: 280.w,
                              child: Text(
                                "https://meet.google.com/?hs=197&authuser=0",
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 110.h),
                ],
              ),
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
                if (!isFilled) return;
                if (!validateForm(formKey)) return;
                context.router
                    .pushNamed(Pages.editStepFour, extra: widget.info);
              },
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: isFilled ? appBlue : appBlue.withOpacity(0.4),
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