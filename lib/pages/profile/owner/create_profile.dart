import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/components/user.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

bool validate(GlobalKey<FormState> formKey) {
  if (formKey.currentState == null) return false;
  if (!formKey.currentState!.validate()) return false;
  formKey.currentState?.save();
  return true;
}

class CreateProfilePageOne extends ConsumerStatefulWidget {
  const CreateProfilePageOne({super.key});

  @override
  ConsumerState<CreateProfilePageOne> createState() =>
      _CreateProfilePageOneState();
}

class _CreateProfilePageOneState extends ConsumerState<CreateProfilePageOne> {
  late Map<String, String> info;

  late TextEditingController firstName, lastName, email;
  final TextEditingController phone = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController region = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController dob = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  String? religion;
  DateTime? pickedDate;

  @override
  void initState() {
    super.initState();
    User user = ref.read(currentUserProvider);
    info = {
      "userId": user.id,
      "state": "",
      "country": "",
      "dateOfBirth": "",
      "religion": "",
      "street": ""
    };

    firstName = TextEditingController(text: user.firstName);
    lastName = TextEditingController(text: user.lastName);
    email = TextEditingController(text: user.email);
  }

  @override
  void dispose() {
    dob.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phone.dispose();
    street.dispose();
    region.dispose();
    country.dispose();
    super.dispose();
  }

  void navigate() {
    //ref.watch(currentUserProvider.notifier).state = user!;
    context.router.pushReplacementNamed(Pages.createStepThree);
  }

  Future<void> create() async {
    // createLandlordProfile(info).then((resp) {
    //   if (!mounted) return;
    //   showError(resp.message);
    //   if (!resp.success) {
    //     Navigator.of(context).pop();
    //   } else {
    //     navigate();
    //   }
    // });
    //
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Dialog(
    //     elevation: 0.0,
    //     backgroundColor: Colors.transparent,
    //     child: loader,
    //   ),
    // );
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            SizedBox(height: 25.h),
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 0.34,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "STEP 1",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      "User Identification",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Verify your identity for a secure and trustworthy listing. "
                    "Complete the identification process to gain tenant confidence.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  ),
                  SizedBox(height: 44.h),
                  Text(
                    "First Name",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: firstName,
                    width: 414.w,
                    height: 50.h,
                    readOnly: true,
                    hint: "Your first name",
                    fillColor: Colors.black12,
                    borderColor: Colors.transparent,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Last Name",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: lastName,
                    width: 414.w,
                    height: 50.h,
                    readOnly: true,
                    hint: "Your last name",
                    fillColor: Colors.black12,
                    borderColor: Colors.transparent,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Email Address",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: email,
                    width: 414.w,
                    height: 50.h,
                    readOnly: true,
                    hint: "Your email Address",
                    fillColor: Colors.black12,
                    borderColor: Colors.transparent,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Phone Number",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: phone,
                    width: 414.w,
                    height: 50.h,
                    type: TextInputType.phone,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        showError("Invalid Phone Number");
                        return '';
                      }
                      return null;
                    },
                    prefix: SizedBox(
                      height: 50.h,
                      width: 30.w,
                      child: Center(
                        child: Text(
                          "+234",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
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
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the street of your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => info["street"] = val,
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
                    controller: region,
                    width: 414.w,
                    height: 50.h,
                    hint: "i.e Ogun State",
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the state of your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => info["state"] = val,
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
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the country of your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => info["country"] = val,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Religion",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  ComboBox(
                    hint: "Choose Religion",
                    value: religion,
                    dropdownItems: const ["Christianity", "Islam", "Other"],
                    onChanged: (val) => setState(() => religion = val),
                    icon: const Icon(Boxicons.bxs_down_arrow),
                    buttonWidth: 414.w,
                    buttonHeight: 50.h,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Date of Birth",
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75, fontWeight: FontWeight.w500),
                  ),
                  SpecialForm(
                    prefix: IconButton(
                      splashRadius: 0.01,
                      iconSize: 26.r,
                      icon: const Icon(
                        Icons.calendar_month_rounded,
                        color: weirdBlack50,
                      ),
                      onPressed: () async {
                        pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          setState(
                            () => dob.text = formatDate(
                                DateFormat("dd/MM/yyyy").format(pickedDate!)),
                          );
                        }
                      },
                    ),
                    onValidate: (val) {
                      if (pickedDate == null) {
                        showError("Please enter your date of birth.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => info["dateOfBirth"] = (pickedDate == null
                        ? ""
                        : pickedDate?.toIso8601String())!,
                    controller: dob,
                    width: 414.w,
                    hint: "Jan 1, 1960",
                    height: 50.h,
                    readOnly: true,
                  ),
                  SizedBox(height: 50.h),
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
        child: Center(
          child: GestureDetector(
            onTap: () {
              if (religion == null) {
                showError("Please choose your religion");
                return;
              }

              if (!validate(formKey)) return;
              info["religion"] = religion!;

              create();
            },
            child: Container(
              width: 414.w,
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
        ),
      ),
    );
  }
}

class CreateProfilePageTwo extends StatefulWidget {
  const CreateProfilePageTwo({super.key});

  @override
  State<CreateProfilePageTwo> createState() => _CreateProfilePageTwoState();
}

class _CreateProfilePageTwoState extends State<CreateProfilePageTwo> {
  late Map<String, dynamic> info;

  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController junction = TextEditingController();
  final TextEditingController region = TextEditingController();
  final TextEditingController country = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    info = {
      "state": "",
      "country": "",
      "dateOfBirth": "",
      "religion": "",
      "street": ""
    };
  }

  @override
  void dispose() {
    area.dispose();
    name.dispose();
    number.dispose();
    junction.dispose();
    region.dispose();
    country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            SizedBox(height: 25.h),
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 0.5,
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
                      "Property Identification",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: weirdBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Secure your property listing, by completing the identification process. "
                    "Build trust with potential tenants through property verification.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
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
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Hostel Identification Number",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: number,
                    width: 414.w,
                    height: 50.h,
                    hint: "i.e Zone B",
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Hostel Area",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: area,
                    width: 414.w,
                    height: 50.h,
                    hint: "i.e Behind Abans Factory",
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Hostel Junction",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack,
                    ),
                  ),
                  SpecialForm(
                    controller: junction,
                    width: 414.w,
                    height: 50.h,
                    hint: "i.e Accord Junction",
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
                    controller: region,
                    width: 414.w,
                    height: 50.h,
                    hint: "i.e Ogun State",
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
                  ),
                  SizedBox(height: 50.h),
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
                if (!validate(formKey)) return;
                context.router.pushNamed(Pages.createStepThree);
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

class CreateProfilePageThree extends ConsumerStatefulWidget {
  const CreateProfilePageThree({super.key});

  @override
  ConsumerState<CreateProfilePageThree> createState() =>
      _CreateProfilePageThreeState();
}

class _CreateProfilePageThreeState
    extends ConsumerState<CreateProfilePageThree> {
  File? image;

  void navigate() {
    context.router.pushReplacementNamed(Pages.createStepFour);
  }

  Future<void> create() async {
    // updateProfilePicture(
    //   id: ref.watch(currentUserProvider).id,
    //   filePath: image!.path,
    // ).then((resp) {
    //   if (!mounted) return;
    //   showError(resp.message);
    //   print(resp.message);
    //   if (!resp.success) {
    //     Navigator.of(context).pop();
    //   } else {
    //     navigate();
    //   }
    // });
    //
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Dialog(
    //     elevation: 0.0,
    //     backgroundColor: Colors.transparent,
    //     child: loader,
    //   ),
    // );
    navigate();
  }

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
                value: 0.67,
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
                    "Upload your Picture",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Upload your picture to build trust and connect with tenants on a more personal level.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 44.h),
                GestureDetector(
                  onTap: () => FileManager.single(type: FileType.image).then(
                    (value) => setState(() {
                      if (value == null) return;
                      image = File(value.path);
                    }),
                  ),
                  child: Center(
                    child: image != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(image!),
                            radius: 100.r,
                          )
                        : Image.asset(
                            "assets/images/Choose Image.png",
                            width: 200.r,
                            height: 200.r,
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
                if (image == null) {
                  showError("Please choose an image");
                  return;
                }

                create();
                //navigate();
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

class CreateProfilePageFour extends ConsumerStatefulWidget {
  const CreateProfilePageFour({super.key});

  @override
  ConsumerState<CreateProfilePageFour> createState() => _CreateProfilePageFourState();
}

class _CreateProfilePageFourState extends ConsumerState<CreateProfilePageFour> {
  late bool agree = false;

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
                value: 1.0,
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
                    "Landlord Agreement",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Upload your picture to build trust and connect with tenants on a more personal level.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 44.h),
                Container(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Introduction",
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: weirdBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "PLEASE READ THE FOLLOWING AGREEMENT CAREFULLY BEFORE ACCEPTING AND MAKING HOUSE PAYMENTS.",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        loremIpsum,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: agree,
                            onChanged: (val) => setState(() => agree = !agree),
                            activeColor: appBlue,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the ",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "Terms & Conditions",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = () => context.router.pushNamed(Pages.help),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
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
                if (!agree) return;
                create();
              },
              child: Container(
                width: 170.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: agree ? appBlue : appBlue.withOpacity(0.4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Finish",
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

  void show() => showModalBottomSheet(
    context: context,
    builder: (_) => const _CreateAccountModal(),
    isDismissible: true,
  );

  void create() {
    // refreshUser(UserType.landlord).then((val) {
    //   if(!mounted) return;
    //
    //   if(!val.success) {
    //     showError(val.message);
    //     Navigator.of(context).pop();
    //     return;
    //   } else {
    //     show();
    //   }
    // });
    //
    //
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Dialog(
    //     elevation: 0.0,
    //     backgroundColor: Colors.transparent,
    //     child: loader,
    //   ),
    // );
    show();
  }
}

class _CreateAccountModal extends StatelessWidget {
  const _CreateAccountModal();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
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
                        "assets/images/Account Created.png",
                        width: 135.r,
                        height: 135.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Account Created Successfully",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Congratulations! You account is created successfully. Start listing your properties and connecting with tenants.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 60.h),
                  GestureDetector(
                    onTap: () => context.router.goNamed(Pages.ownerDashboard),
                    child: Container(
                      width: 414.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appBlue,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        "Go to Home",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
