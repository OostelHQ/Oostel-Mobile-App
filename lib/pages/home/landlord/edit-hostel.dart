import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/api/hostel_service.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

import 'create-hostel.dart';

void saveAndExit(
    {required HostelInfoData info,
    required BuildContext context,
    GlobalKey<FormState>? formKey}) {
  if (formKey != null && !validateForm(formKey)) return;

  updateHostel(info).then((resp) {
    if (!resp.success) {
      showError(resp.message);
      Navigator.of(context).pop();
      return;
    }
    context.router.pop();
  });

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: loader,
    ),
  );
}

class EditStepOne extends ConsumerStatefulWidget {
  final HostelInfoData info;

  const EditStepOne({
    super.key,
    required this.info,
  });

  @override
  ConsumerState<EditStepOne> createState() => _EditStepOneState();
}

class _EditStepOneState extends ConsumerState<EditStepOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Column(
          children: [
            SizedBox(height: 25.h),
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 1 / totalPages,
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
                      saveAndExit(info: widget.info, context: context)),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "STEP 1",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: appBlue,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Hostel Category",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Categorize your hostel listing to help potential tenants find the perfect accommodation "
                  "that fits their needs and preferences.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 44.h),
                GestureDetector(
                  onTap: () => setState(() => widget.info.category = 1),
                  child: Container(
                    width: 390.w,
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: Image.asset(
                              "assets/images/Self Con.png",
                              width: 114.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 220.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Self Contained",
                                      style:
                                          context.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: weirdBlack,
                                      ),
                                    ),
                                    Radio(
                                      value: widget.info.category,
                                      groupValue: 1,
                                      onChanged: (value) => setState(
                                          () => widget.info.category = 1),
                                    )
                                  ],
                                ),
                                Text(
                                  "Hostel where each room has its own private amenities, such as a toilet, bathroom and kitchen.",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () => setState(() => widget.info.category = 2),
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: Image.asset(
                              "assets/images/One Room.png",
                              width: 114.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 220.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "One-Room",
                                      style:
                                          context.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: weirdBlack,
                                      ),
                                    ),
                                    Radio(
                                      value: widget.info.category,
                                      groupValue: 2,
                                      onChanged: (value) => setState(
                                          () => widget.info.category = 2),
                                    )
                                  ],
                                ),
                                Text(
                                  "Hostel that share common facilities like bathroom, toilet & kitchen with other residents.",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () => setState(() => widget.info.category = 3),
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: Image.asset(
                              "assets/images/Face2Face.png",
                              width: 114.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 220.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Face-to-Face",
                                      style:
                                          context.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: weirdBlack,
                                      ),
                                    ),
                                    Radio(
                                      value: widget.info.category,
                                      groupValue: 3,
                                      onChanged: (value) => setState(
                                          () => widget.info.category = 3),
                                    )
                                  ],
                                ),
                                Text(
                                  "Hostel is a form of dormitory rooms with multiple beds and residents share a common space and facilities.",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () => setState(() => widget.info.category = 4),
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: Image.asset(
                              "assets/images/Flat.png",
                              width: 114.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 220.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Flat",
                                      style:
                                          context.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: weirdBlack,
                                      ),
                                    ),
                                    Radio(
                                      value: widget.info.category,
                                      groupValue: 4,
                                      onChanged: (value) => setState(
                                          () => widget.info.category = 4),
                                    )
                                  ],
                                ),
                                Text(
                                  "Hostel is a form of dormitory rooms with multiple beds and residents share a common space and facilities.",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
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
        child: Center(
          child: GestureDetector(
            onTap: () {
              if (widget.info.category == 0) return;
              context.router.pushNamed(Pages.editStepTwo, extra: widget.info);
            },
            child: Container(
              width: 414.w,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: widget.info.category == 0
                    ? appBlue.withOpacity(0.4)
                    : appBlue,
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
        ),
      ),
    );
  }
}

class EditStepTwo extends StatefulWidget {
  final HostelInfoData info;

  const EditStepTwo({
    super.key,
    required this.info,
  });

  @override
  State<EditStepTwo> createState() => _EditStepTwoState();
}

class _EditStepTwoState extends State<EditStepTwo> {
  late TextEditingController name;
  late TextEditingController description;
  late TextEditingController rooms;
  late TextEditingController area;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.info.name);
    description = TextEditingController(text: widget.info.description);
    rooms = TextEditingController(
        text: "${widget.info.totalRooms == 0 ? "" : widget.info.totalRooms}");
    area = TextEditingController(
        text:
            widget.info.area == 0.0 ? "" : widget.info.area.toStringAsFixed(2));
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    rooms.dispose();
    area.dispose();
    super.dispose();
  }

  bool get isFilled {
    if (name.text.trim().isEmpty) return false;
    if (description.text.trim().isEmpty) return false;
    if (rooms.text.trim().isEmpty) return false;
    if (area.text.trim().isEmpty) return false;
    return true;
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
                value: 2 / totalPages,
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
                      "STEP 2",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      "Hostel Details",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      "Describe your hostel to provide tenants with a clear and enticing "
                      "overview of your property's features and amenities.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack75,
                      ),
                    ),
                  ),
                  SizedBox(height: 44.h),
                  Text(
                    "Hostel Name",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: name,
                    width: 414.w,
                    height: 50.h,
                    hint: "Name of your hostel",
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the name of your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info.name = val!,
                    onChange: (val) => textChecker(
                      text: val,
                      onAction: () => setState(() {}),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Hostel Description",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: description,
                    width: 414.w,
                    height: 100.h,
                    maxLines: 5,
                    hint: "Describe your hostel...",
                    //padding: const EdgeInsets.fromLTRB(10, 25.0, 0, 0),
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please give a description for your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info.description = val!,
                    onChange: (val) => textChecker(
                      text: val,
                      onAction: () => setState(() {}),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Total Rooms",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: rooms,
                    width: 414.w,
                    height: 50.h,
                    type: TextInputType.number,
                    hint: "i.e 20",
                    onValidate: (val) {
                      if (val == null ||
                          val!.trim().isEmpty ||
                          int.tryParse(val!) == null) {
                        showError(
                            "Please enter a valid total number of rooms for your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info.totalRooms = int.parse(val!),
                    onChange: (val) => textChecker(
                      text: val,
                      onAction: () => setState(() {}),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Room Size",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: area,
                    width: 414.w,
                    height: 50.h,
                    type: TextInputType.number,
                    hint: "i.e 2500 sqft",
                    onValidate: (val) {
                      if (val == null ||
                          val!.trim().isEmpty ||
                          double.tryParse(val!) == null) {
                        showError(
                            "Please enter a valid room size for your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info.area = double.parse(val!),
                    onChange: (val) => textChecker(
                      text: val,
                      onAction: () => setState(() {}),
                    ),
                  ),
                  SizedBox(height: 100.h),
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
                if (!validateForm(formKey)) return;
                context.router
                    .pushNamed(Pages.editStepThree, extra: widget.info);
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

class EditStepFive extends StatefulWidget {
  final HostelInfoData info;

  const EditStepFive({
    super.key,
    required this.info,
  });

  @override
  State<EditStepFive> createState() => _EditStepFiveState();
}

class _EditStepFiveState extends State<EditStepFive> {
  final List<String> images = [
    "assets/images/Light-Off.svg",
    "assets/images/Tap.svg",
    "assets/images/Well.svg",
    "assets/images/Pool.svg",
    "assets/images/Security.svg",
    "assets/images/Light-On.svg",
    "assets/images/Tap-On.svg",
    "assets/images/Well-On.svg",
    "assets/images/Pool-On.svg",
    "assets/images/Security-On.svg",
  ];

  final List<String> names = ["Light", "Tap", "Well", "Pool", "Security"];

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
                value: 5 / totalPages,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "STEP 5",
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: appBlue,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Hostel Facilities",
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: weirdBlack,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Select your hostel's facilities to make your property more appealing to potential tenants.",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack75,
                ),
              ),
              SizedBox(height: 44.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.w,
                    mainAxisExtent: 90.h,
                  ),
                  itemBuilder: (_, index) {
                    bool present =
                        widget.info.hostelFacilities.contains(names[index]);
                    return GestureDetector(
                      onTap: () => setState(() {
                        if (present) {
                          widget.info.hostelFacilities.remove(names[index]);
                        } else {
                          widget.info.hostelFacilities.add(names[index]);
                        }
                      }),
                      child: Container(
                        width: 170.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                            color: present ? appBlue : fadedBorder,
                          ),
                          color: widget.info.hostelFacilities
                                  .contains(names[index])
                              ? paleBlue
                              : null,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 90.h,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                        images[present ? index + 5 : index]),
                                    Text(
                                      names[index],
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: present ? appBlue : weirdBlack50,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              AnimatedSwitcherTranslation.right(
                                duration: const Duration(milliseconds: 250),
                                child: Container(
                                  height: 15.r,
                                  width: 15.r,
                                  alignment: Alignment.center,
                                  key: ValueKey<bool>(present),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: fadedBorder),
                                    borderRadius: BorderRadius.circular(3.r),
                                    color: present ? appBlue : null,
                                  ),
                                  child: present
                                      ? const Icon(
                                          Icons.done_rounded,
                                          color: Colors.white,
                                          size: 10,
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: names.length,
                ),
              ),
            ],
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
                if (widget.info.hostelFacilities.isEmpty) {
                  widget.info.hostelFacilities.add("None");
                }

                context.router.pushNamed(Pages.editStepSix, extra: widget.info);
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

class EditStepSix extends StatefulWidget {
  final HostelInfoData info;

  const EditStepSix({
    super.key,
    required this.info,
  });

  @override
  State<EditStepSix> createState() => _EditStepSixState();
}

class _EditStepSixState extends State<EditStepSix> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              pinned: true,
              title: Column(
                children: [
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: 414.w,
                    child: LinearProgressIndicator(
                      value: 6 / totalPages,
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
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "STEP 6",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appBlue,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Hostel Picture",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Upload a clear front view image of your hostel building "
                      "to attract tenants with a welcoming facade",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack75,
                      ),
                    ),
                    SizedBox(height: 44.h),
                    GestureDetector(
                      onTap: () {
                        FileManager.single(type: FileType.image)
                            .then((response) async {
                          if (response == null) return;
                          setState(() => widget.info.media.add(response));
                        });
                      },
                      child: widget.info.isLocal(0)
                          ? CachedNetworkImage(
                              imageUrl: widget.info.media.first,
                              errorWidget: (context, url, error) => Container(
                                width: 350.w,
                                height: 270.h,
                                color: weirdBlack50,
                              ),
                              progressIndicatorBuilder:
                                  (context, url, download) => Container(
                                width: 350.w,
                                height: 270.h,
                                color: weirdBlack50,
                                alignment: Alignment.center,
                                child: loader,
                              ),
                              imageBuilder: (context, provider) => Container(
                                width: 350.w,
                                height: 270.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: provider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 350.w,
                              height: 270.h,
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: FileImage(
                                    File(widget.info.media.first.path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
              onTap: () => context.router
                  .pushNamed(Pages.editStepSixHalf, extra: widget.info),
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

class EditStepSixHalf extends StatefulWidget {
  final HostelInfoData info;

  const EditStepSixHalf({
    super.key,
    required this.info,
  });

  @override
  State<EditStepSixHalf> createState() => _EditStepSixHalfState();
}

class _EditStepSixHalfState extends State<EditStepSixHalf> {
  late Uint8List? videoData;
  late int? videoDataIndex;

  void selectMedia() {
    if (widget.info.media.length == 5) {
      showError("You cannot select more than 4 media");
      return;
    }

    FileManager.multiple(
        type: FileType.custom, extensions: ["mp4", "jpg", "png", "jpeg"]).then(
      (response) async {
        String videoPath = "";
        for (int i = 0; i < response.length; ++i) {
          if (response[i].extension == "mp4") {
            videoPath = response[i].path;
          }

          if (widget.info.media.length < 5) {
            widget.info.media.add(response[i]);
          }
        }

        if (videoPath.isNotEmpty) {
          videoData = await VideoThumbnail.thumbnailData(
            video: videoPath,
            imageFormat: ImageFormat.JPEG,
            maxWidth: 350,
            maxHeight: 270,
            quality: 75,
          );

          for (int i = 0; i < widget.info.media.length; ++i) {
            if (isLocal(i) && widget.info.media[i].path == videoPath) {
              videoDataIndex = i;
            }
          }
        }

        setState(() {});
      },
    );
  }

  bool isLocal(int index) => widget.info.media[index] !is String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              pinned: true,
              title: Column(
                children: [
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: 414.w,
                    child: LinearProgressIndicator(
                      value: 7 / totalPages,
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
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "STEP 7",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appBlue,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Environment Picture",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Capture the essence of your hostel environment in pictures. "
                      "Showcase the surroundings to attract potential tenants.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack75,
                      ),
                    ),
                    SizedBox(height: 44.h),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList.separated(
                itemBuilder: (_, index) {
                  if (index == widget.info.media.length - 1) {
                    return Column(
                      children: [
                        if (widget.info.media.length == 1)
                          GestureDetector(
                            onTap: selectMedia,
                            child: isLocal(index + 1)
                                ? CachedNetworkImage(
                                    imageUrl: widget.info.media.first,
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 350.w,
                                      height: 270.h,
                                      color: weirdBlack50,
                                      alignment: Alignment.center,
                                      child: loader,
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, download) => Container(
                                      width: 350.w,
                                      height: 270.h,
                                      color: weirdBlack50,
                                    ),
                                    imageBuilder: (context, provider) =>
                                        Container(
                                      width: 350.w,
                                      height: 270.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: provider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 350.w,
                                    height: 270.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: widget.info.media.length == 1
                                          ? paleBlue
                                          : null,
                                      image: widget.info.media.length == 1
                                          ? null
                                          : DecorationImage(
                                              image: FileImage(File(widget
                                                  .info.media.first.path)),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    child: widget.info.media.length == 1
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/Hostel Image.svg",
                                                width: 40.r,
                                                height: 40.r,
                                              ),
                                              SizedBox(height: 16.h),
                                              Text(
                                                "Upload a video (optional) or images of your hostel",
                                                textAlign: TextAlign.center,
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                  color: weirdBlack,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 8.h),
                                              Text(
                                                "Maximum size allowed is 2MB for images and 50MB for video",
                                                textAlign: TextAlign.center,
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                  color: weirdBlack75,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          )
                                        : null,
                                  ),
                          ),
                        SizedBox(
                            height:
                                widget.info.media.length == 1 ? 32.h : 20.h),
                        if (widget.info.media.length > 1)
                          GestureDetector(
                            onTap: selectMedia,
                            child: Container(
                              width: 160.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: paleBlue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add_circle_outline,
                                      color: appBlue, size: 16),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Add media",
                                    textAlign: TextAlign.center,
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: appBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        SizedBox(height: 32.h),
                      ],
                    );
                  }

                  return _SpecialContainer(
                    onDelete: () => setState(() {
                      widget.info.media.removeAt(index + 1);
                      if (videoDataIndex != null && index == videoDataIndex) {
                        videoDataIndex = null;
                        videoData = null;
                      }
                    }),
                    file: widget.info.media[index],
                  );
                },
                itemCount: widget.info.media.length,
                separatorBuilder: (_, __) => SizedBox(height: 20.h),
              ),
            ),
          ],
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
                int total = widget.info.media.length;
                int videos = 0;
                for (int i = 0; i < total; ++i) {
                  if (!isLocal(i) && widget.info.media[i].extension == "mp4") {
                    ++videos;
                  } else if (isLocal(i) &&
                      widget.info.media[i].endsWith("mp4")) {
                    ++videos;
                  }
                }

                if (total > 5) {
                  showError("You need can only upload a maximum of 4 media");
                  return;
                }

                if (videos > 1) {
                  showError("You can only select 1 video");
                  return;
                }

                context.router
                    .pushNamed(Pages.editStepSeven, extra: widget.info);
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

class _SpecialContainer extends StatelessWidget {
  final dynamic file;
  final Uint8List? data;
  final VoidCallback onDelete;

  const _SpecialContainer({
    this.data,
    required this.file,
    required this.onDelete,
  });

  ImageProvider<Object> get provider {
    if (data != null) {
      return MemoryImage(data!);
    }

    return FileImage(File(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return file is SingleFileResponse ?  Container(
      width: 390.w,
      height: 270.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: provider,
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 390.w,
            height: 270.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.black45,
            ),
            child: data != null
                ? Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 48.r,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          Positioned(
            top: 5.h,
            right: 0,
            child: IconButton(
              icon: const Icon(Boxicons.bx_x, color: Colors.white),
              iconSize: 28.r,
              onPressed: onDelete,
            ),
          )
        ],
      ),
    ) : CachedNetworkImage(
      imageUrl: file,
      errorWidget: (context, url, error) => Container(
        width: 390.w,
        height: 270.h,
        color: weirdBlack50,
        alignment: Alignment.center,
        child: loader,
      ),
      progressIndicatorBuilder: (context, url, download) =>
          Container(
            width: 390.w,
            height: 270.h,
            color: weirdBlack50,
          ),
      imageBuilder: (context, provider) => Container(
        width: 390.w,
        height: 270.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: provider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class EditStepSeven extends StatefulWidget {
  final HostelInfoData info;

  const EditStepSeven({
    super.key,
    required this.info,
  });

  @override
  State<EditStepSeven> createState() => _EditStepSevenState();
}

class _EditStepSevenState extends State<EditStepSeven> {
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
                value: 8 / totalPages,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "STEP 8",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: appBlue,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Room Vacancy",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Do you have any vacant room(s) in your hostel?",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 44.h),
                SvgPicture.asset(
                  "assets/images/Room Vacancy.svg",
                  width: 200.r,
                  height: 200.r,
                ),
                SizedBox(height: 40.h),
                Container(
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
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.info.isLocal(0)
                            ? CachedNetworkImage(
                                imageUrl: widget.info.media.first,
                                errorWidget: (context, url, error) => Container(
                                  width: 114.w,
                                  height: 100.h,
                                  color: weirdBlack50,
                                ),
                                progressIndicatorBuilder:
                                    (context, url, download) => Container(
                                  width: 114.w,
                                  height: 100.h,
                                  color: weirdBlack50,
                                  alignment: Alignment.center,
                                  child: loader,
                                ),
                                imageBuilder: (context, provider) => Container(
                                  width: 114.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    image: DecorationImage(
                                      image: provider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.file(
                                  File(widget.info.media.first.path),
                                  width: 114.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        SizedBox(
                          width: 220.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Yes",
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: weirdBlack,
                                    ),
                                  ),
                                  Radio(
                                    value: widget.info.vacantRooms,
                                    groupValue: true,
                                    onChanged: (value) => setState(
                                        () => widget.info.vacantRooms = true),
                                  )
                                ],
                              ),
                              Text(
                                "There are rooms available for rent in my hostel.",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
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
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.info.isLocal(0)
                            ? CachedNetworkImage(
                                imageUrl: widget.info.media.first,
                                errorWidget: (context, url, error) => Container(
                                  width: 114.w,
                                  height: 100.h,
                                  color: weirdBlack50,
                                ),
                                progressIndicatorBuilder:
                                    (context, url, download) => Container(
                                  width: 114.w,
                                  height: 100.h,
                                  color: weirdBlack50,
                                  alignment: Alignment.center,
                                  child: loader,
                                ),
                                imageBuilder: (context, provider) => Container(
                                  width: 114.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    image: DecorationImage(
                                      image: provider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: Image.file(
                                  File(widget.info.media.first.path),
                                  width: 114.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        SizedBox(
                          width: 220.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "No",
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: weirdBlack,
                                    ),
                                  ),
                                  Radio(
                                    value: widget.info.vacantRooms,
                                    groupValue: false,
                                    onChanged: (value) => setState(
                                        () => widget.info.vacantRooms = false),
                                  )
                                ],
                              ),
                              Text(
                                "There are no rooms available for rent in my hostel.",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
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
              onTap: () => context.router.pushNamed(
                !widget.info.vacantRooms
                    ? Pages.editStepTen
                    : Pages.editStepEight,
                extra: widget.info,
              ),
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

class EditStepEight extends StatefulWidget {
  final HostelInfoData info;

  const EditStepEight({
    super.key,
    required this.info,
  });

  @override
  State<EditStepEight> createState() => _EditStepEightState();
}

class _EditStepEightState extends State<EditStepEight> {
  bool exists(int index) => index < widget.info.rooms.length;
  int totalCards = 2;

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
                value: 9 / totalPages,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "STEP 9",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: appBlue,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Room Vacancy",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weirdBlack,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Showcase your available hostel rooms with an attractive vacancy presentation. "
                  "Make your listing stand out to potential tenants.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 44.h),
                Column(
                  children: List.generate(
                    totalCards + 1,
                    (index) {
                      if (index == totalCards) {
                        return Column(
                          children: [
                            SizedBox(height: 12.h),
                            GestureDetector(
                              onTap: () {
                                if (exists(totalCards - 1)) {
                                  setState(() => ++totalCards);
                                } else {
                                  showError(
                                      "Please create a room with the card(s) above");
                                }
                              },
                              child: Container(
                                width: 160.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: paleBlue,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_circle_outline,
                                        color: appBlue, size: 16),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Add room",
                                      textAlign: TextAlign.center,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        color: appBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 32.h),
                          ],
                        );
                      }

                      return !exists(index)
                          ? GestureDetector(
                              onTap: () {
                                widget.info.roomEditIndex = null;
                                context.router
                                    .pushNamed(Pages.stepNine,
                                        extra: widget.info)
                                    .then(
                                      (value) => setState(
                                        () {
                                          if (value == null) return;
                                          widget.info.rooms
                                              .add(value as RoomInfoData);
                                        },
                                      ),
                                    );
                              },
                              child: const _NoRoom(),
                            )
                          : GestureDetector(
                              onTap: () {
                                widget.info.roomEditIndex = index;
                                context.router
                                    .pushNamed(Pages.stepNine,
                                        extra: widget.info)
                                    .then((value) => setState(() {}));
                              },
                              child: _CreateRoomCard(
                                  info: widget.info.rooms[index]),
                            );
                    },
                  ),
                )
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
                if (widget.info.rooms.isEmpty) {
                  showError("Please create at least one room");
                  return;
                }
                saveAndExit(info: widget.info, context: context);
              },
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: widget.info.rooms.isEmpty
                      ? appBlue.withOpacity(0.4)
                      : appBlue,
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

class _NoRoom extends StatelessWidget {
  const _NoRoom();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: Center(
        child: Container(
          width: 350.w,
          height: 200.h,
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: paleBlue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/Create Room.svg",
                width: 40.r,
                height: 40.r,
              ),
              SizedBox(height: 8.h),
              Text(
                "Create room",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: weirdBlack75,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateRoomCard extends StatelessWidget {
  final RoomInfoData info;

  const _CreateRoomCard({
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FBFF),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFE0E5EC),
                blurRadius: 6.0,
                spreadRadius: 1.0,
              )
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  info.isLocal(0)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            File(info.media.first.path),
                            width: 414.w,
                            height: 156.h,
                            fit: BoxFit.cover,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: info.media.first,
                          errorWidget: (context, url, error) => Container(
                            width: 414.w,
                            height: 156.h,
                            color: weirdBlack50,
                          ),
                          progressIndicatorBuilder: (context, url, download) =>
                              Container(
                            width: 414.w,
                            height: 156.h,
                            color: weirdBlack50,
                            alignment: Alignment.center,
                            child: loader,
                          ),
                          imageBuilder: (context, provider) => Container(
                            width: 414.w,
                            height: 156.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                image: provider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  Positioned(
                    top: 15.h,
                    left: 15.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: infoRoomsLeftBackground,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        "Available",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: infoRoomsLeft,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                info.name,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: weirdBlack,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "This room will be made available for the students to rent and partner with their friends if requested.",
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack,
                ),
              ),
              SizedBox(height: 6.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${currency()} ${formatAmountInDouble(info.price)}",
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: appBlue,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: "/year",
                      style: context.textTheme.bodySmall!.copyWith(
                        color: appBlue,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class EditStepNine extends StatefulWidget {
  final HostelInfoData info;

  const EditStepNine({
    super.key,
    required this.info,
  });

  @override
  State<EditStepNine> createState() => _EditStepNineState();
}

class _EditStepNineState extends State<EditStepNine> {
  late TextEditingController name;
  late TextEditingController price;

  String? duration;

  final List<String> images = [
    "assets/images/Light-Off.svg",
    "assets/images/Tap.svg",
    "assets/images/Bathtub Pro.svg",
    "assets/images/Toilet Pro.svg",
    "assets/images/Kitchen Pro.svg",
    "assets/images/Ceiling Fan.svg",
    "assets/images/Wardrobe.svg",
    "assets/images/Hanger.svg",
  ];

  final List<String> names = [
    "Light",
    "Tap Water",
    "Bathroom",
    "Toilet",
    "Kitchen",
    "Ceiling Fan",
    "Wardrobe",
    "Hanger",
  ];

  late List<String> facilities;
  late List<dynamic> media;

  final GlobalKey<FormState> formKey = GlobalKey();

  late RoomInfoData? room;
  late String id;

  @override
  void initState() {
    super.initState();

    int? roomIndex = widget.info.roomEditIndex;
    if (roomIndex != null) {
      room = widget.info.rooms[roomIndex];
      duration = room?.duration;
      facilities = room?.facilities ?? [];
      media = room?.media ?? [];
      id = room?.id ?? "";
    } else {
      facilities = [];
      media = [];
      id = "";
    }

    name = TextEditingController(text: room?.name ?? "");
    price = TextEditingController(
        text: room?.price == null ? "" : room?.price.toStringAsFixed(0));
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    super.dispose();
  }

  bool isLocal(int index) => media[index]! is String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Column(
          children: [
            SizedBox(height: 25.h),
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 10 / totalPages,
                color: appBlue,
                minHeight: 1.5.h,
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
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "STEP 10",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: appBlue,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Center(
                        child: Text(
                          "Available Room",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Center(
                        child: Text(
                          "Share information about the vacant room to help potential tenants make informed decisions.",
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: weirdBlack75,
                          ),
                        ),
                      ),
                      SizedBox(height: 44.h),
                      Text(
                        "Room Number",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack,
                        ),
                      ),
                      SpecialForm(
                        controller: name,
                        width: 414.w,
                        height: 50.h,
                        hint: "i.e Block A5",
                        onValidate: (val) {
                          if (val == null || val!.trim().isEmpty) {
                            showError("Please enter the name of this room.");
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Price",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack,
                        ),
                      ),
                      SpecialForm(
                        controller: price,
                        width: 414.w,
                        height: 50.h,
                        hint: "00.00",
                        type: TextInputType.number,
                        onValidate: (val) {
                          if (val == null ||
                              val!.trim().isEmpty ||
                              double.tryParse(val!) == null) {
                            showError(
                                "Please enter a valid price for this room.");
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Duration",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack,
                        ),
                      ),
                      ComboBox(
                        hint: "Select",
                        value: duration,
                        dropdownItems: const ["Daily", "Monthly", "Yearly"],
                        onChanged: (val) => setState(() => duration = val),
                        icon: const Icon(Boxicons.bxs_down_arrow),
                        buttonWidth: 414.w,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Room Facilities",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack,
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.w,
                    mainAxisExtent: 90.h,
                  ),
                  itemBuilder: (_, index) {
                    bool present = facilities.contains(names[index]);
                    return GestureDetector(
                      onTap: () => setState(() {
                        if (present) {
                          facilities.remove(names[index]);
                        } else {
                          facilities.add(names[index]);
                        }
                      }),
                      child: Container(
                        width: 170.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                            color: present ? appBlue : fadedBorder,
                          ),
                          color: facilities.contains(names[index])
                              ? paleBlue
                              : null,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 90.h,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(images[index],
                                        color: present ? appBlue : null),
                                    Text(
                                      names[index],
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: present ? appBlue : weirdBlack50,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              AnimatedSwitcherTranslation.right(
                                duration: const Duration(milliseconds: 250),
                                child: Container(
                                  height: 15.r,
                                  width: 15.r,
                                  alignment: Alignment.center,
                                  key: ValueKey<bool>(present),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: fadedBorder),
                                    borderRadius: BorderRadius.circular(3.r),
                                    color: present ? appBlue : null,
                                  ),
                                  child: present
                                      ? const Icon(
                                          Icons.done_rounded,
                                          color: Colors.white,
                                          size: 10,
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: names.length,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Text(
                        "Room Pictures",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack,
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: media.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: Container(
                            width: 414.w,
                            height: 270.h,
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: paleBlue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Hostel Image.svg",
                                  width: 40.r,
                                  height: 40.r,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  "Upload your room images",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "Maximum size allowed is 2MB of png and jpg format",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.r,
                          mainAxisSpacing: 10.r,
                          mainAxisExtent: 110.r,
                        ),
                        itemCount: media.length,
                        itemBuilder: (_, index) => Stack(
                          children: [
                            isLocal(index)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: Image.file(
                                      File(media[index].path),
                                      width: 110.r,
                                      height: 110.r,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: media[index],
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 110.r,
                                      height: 110.r,
                                      color: weirdBlack50,
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, download) => Container(
                                      width: 110.r,
                                      height: 110.r,
                                      color: weirdBlack50,
                                      alignment: Alignment.center,
                                      child: loader,
                                    ),
                                    imageBuilder: (context, provider) =>
                                        Container(
                                      width: 110.r,
                                      height: 110.r,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        image: DecorationImage(
                                          image: provider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                            Positioned(
                              right: 10.r,
                              top: 5.r,
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => media.removeAt(index)),
                                child: Icon(Boxicons.bx_x,
                                    color: Colors.white, size: 26.r),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    if (media.length < 8)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Text(
                              "*Note that you must to upload minimum of 8 and above images before you can proceed.",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodySmall!.copyWith(
                                color: weirdBlack50,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),
                          GestureDetector(
                            onTap: () =>
                                FileManager.multiple(type: FileType.image)
                                    .then((response) async {
                              media.addAll(response);
                              setState(() {});
                            }),
                            child: Container(
                              width: 160.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: paleBlue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add_circle_outline,
                                      color: appBlue, size: 16),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Add images",
                                    textAlign: TextAlign.center,
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: appBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 50.h),
                  ],
                ),
              )
            ],
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
                if (!validateForm(formKey)) return;

                if (duration == null) {
                  showError("Please choose a duration");
                  return;
                }

                if (room == null) {
                  RoomInfoData data = RoomInfoData(
                    id: id,
                    duration: duration!,
                    name: name.text.trim(),
                    price: double.parse(price.text.trim()),
                    facilities: facilities,
                    media: media,
                  );
                  context.router.pop(data);
                } else {
                  context.router.pop();
                }
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

class EditStepTen extends StatefulWidget {
  final HostelInfoData info;

  const EditStepTen({
    super.key,
    required this.info,
  });

  @override
  State<EditStepTen> createState() => _EditStepTenState();
}

class _EditStepTenState extends State<EditStepTen> {
  late List<int> totalProps;
  late List<dynamic> media;
  late List<String> facilities, rules;
  late List<RoomInfoData> rooms;
  late int availableRooms, totalRooms;
  late bool vacantRooms;

  String minBudget = '0.0', maxBudget = "0.0", address = "";

  @override
  void initState() {
    super.initState();
    rooms = widget.info.rooms;
    totalProps = calculate(rooms);

    media = widget.info.media;
    facilities = widget.info.hostelFacilities;
    rules = widget.info.rules;

    availableRooms = rooms.length;
    totalRooms = widget.info.totalRooms;
    vacantRooms = widget.info.vacantRooms;

    List<String> parts = widget.info.address.split("#");
    address = "${parts[0]}, ${parts[1]}, ${parts[2]}, ${parts[3]}";
  }

  List<int> calculate(List<RoomInfoData> rooms) {
    int baths = 0, kitchens = 0, toilets = 0;

    double minPrice = 0.0, maxPrice = 0.0;

    for (RoomInfoData info in rooms) {
      List<String> facilities = info.facilities;
      if (facilities.contains("Toilet")) {
        ++toilets;
      }
      if (facilities.contains("Kitchen")) {
        ++kitchens;
      }
      if (facilities.contains("Bathroom")) {
        ++baths;
      }

      if (info.price <= minPrice) {
        minPrice = info.price;
      }

      if (info.price >= maxPrice) {
        maxPrice = info.price;
      }
    }

    maxBudget = maxPrice.toStringAsFixed(0);
    minBudget = minPrice.toStringAsFixed(0);

    return [
      baths,
      toilets,
      kitchens,
    ];
  }

  bool isLocal(int index) => media[index]! is String;

  void navigate() => showModalBottomSheet(
        context: context,
        builder: (context) => CreateHostelModal(vacancy: vacantRooms),
        isDismissible: false,
      ).then(
        (resp) {
          context.router.goNamed(Pages.ownerDashboard);
        },
      );

  void create() {
    context.router
        .pushNamed(Pages.uploadHostel, extra: widget.info)
        .then((resp) {
      bool? status = resp as bool?;
      if (status == null || !status) return;
      navigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: Column(
                children: [
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: 414.w,
                    child: LinearProgressIndicator(
                      value: (vacantRooms ? 9 : 11) / totalPages,
                      color: appBlue,
                      minHeight: 1.5.h,
                    ),
                  ),
                  SizedBox(height: 18.h),
                ],
              ),
              automaticallyImplyLeading: false,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "STEP ${!vacantRooms ? "9" : "11"}",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appBlue,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Preview",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Before going live, get a preview of your hostel details and ensure your "
                      "listing is (are) ready to impress potential tenants.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: weirdBlack75,
                      ),
                    ),
                    SizedBox(height: 44.h),
                  ],
                ),
              ),
            ),
          ],
          body: Container(
            width: 300.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FBFF),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFE0E5EC),
                  blurRadius: 6.0,
                  spreadRadius: 1.0,
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            File(media.first.path),
                            width: 414.w,
                            height: 156.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250.w,
                              child: Text(
                                widget.info.name,
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: weirdBlack,
                                ),
                              ),
                            ),
                            Container(
                              width: 90.w,
                              height: 25.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: infoRoomsLeftBackground,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                "$availableRooms/$totalRooms rooms left",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: infoRoomsLeft,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          address,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Hostel Info Bed.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "$availableRooms",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Hostel Info Bath.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${totalProps[0]}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Toilet.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${totalProps[1]}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Kitchen.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${totalProps[2]}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Hostel Info Area.svg",
                                  width: 15.r,
                                  height: 15.r,
                                  color: weirdBlack50,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "${(widget.info.area).toStringAsFixed(0)} sqft",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        if (minBudget.isNotEmpty && maxBudget.isNotEmpty)
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${currency()}${minBudget}k - ${currency()}${maxBudget}k",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "/year",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        SizedBox(height: 16.h),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 414.w,
                            minHeight: 1.h,
                            maxWidth: 414.w,
                            maxHeight: 1.h,
                          ),
                          child: const ColoredBox(color: Colors.black12),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Description",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          widget.info.description,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Rules & Regulations",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            rules.length,
                            (index) => Text(
                              "${index + 1}. ${rules[index]}",
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Hostel Facilities",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5.r,
                        mainAxisSpacing: 5.r,
                        mainAxisExtent: 105.r),
                    itemCount: facilities.length,
                    itemBuilder: (_, index) => FacilityContainer(
                      text: facilities[index],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        if (rooms.isNotEmpty)
                          Text(
                            "Available Rooms",
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: weirdBlack,
                            ),
                          ),
                        if (rooms.isNotEmpty) SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                if (rooms.isNotEmpty)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.r,
                        mainAxisSpacing: 15.r,
                        mainAxisExtent: 205.h,
                      ),
                      itemCount: rooms.length,
                      itemBuilder: (_, index) => AvailableRoomCard(
                        infoData: rooms[index],
                        onTap: () {},
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (rooms.isNotEmpty) SizedBox(height: 16.h),
                        Text(
                          "Gallery",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: weirdBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.r,
                      mainAxisSpacing: 10.r,
                      mainAxisExtent: 110.r,
                    ),
                    itemCount: media.length,
                    itemBuilder: (_, index) => isLocal(index)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: Image.file(
                              File(media[index].path),
                              width: 110.r,
                              height: 110.r,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: media[index],
                            errorWidget: (context, url, error) => Container(
                              width: 110.r,
                              height: 110.r,
                              color: weirdBlack50,
                            ),
                            progressIndicatorBuilder:
                                (context, url, download) => Container(
                              width: 110.r,
                              height: 110.r,
                              color: weirdBlack50,
                              alignment: Alignment.center,
                              child: loader,
                            ),
                            imageBuilder: (context, provider) => Container(
                              width: 110.r,
                              height: 110.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                image: DecorationImage(
                                  image: provider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ),
                )
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
              onTap: create,
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: appBlue,
                ),
                child: Text(
                  !vacantRooms ? "Create" : "Launch",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
