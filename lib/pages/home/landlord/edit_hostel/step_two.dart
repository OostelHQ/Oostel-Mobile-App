import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/home/landlord/edit-hostel.dart';

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