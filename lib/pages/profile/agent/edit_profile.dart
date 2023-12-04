import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/components/agent.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class EditAgentProfilePage extends ConsumerStatefulWidget {
  const EditAgentProfilePage({super.key});

  @override
  ConsumerState<EditAgentProfilePage> createState() =>
      _EditAgentProfilePageState();
}

class _EditAgentProfilePageState extends ConsumerState<EditAgentProfilePage> {
  String? profileImage;
  String? origin;
  String? gender;
  String? level;
  String? religion;
  String? age;
  DateTime? pickedDate;

  late TextEditingController email;
  late TextEditingController fullName;
  late TextEditingController number;
  late TextEditingController denomination;
  late TextEditingController hobby;

  late TextEditingController street, region, country;

  @override
  void initState() {
    super.initState();

    Agent student = ref.read(currentUserProvider) as Agent;

    email = TextEditingController(text: student.email);
    fullName = TextEditingController(text: student.mergedNames);
    number = TextEditingController(text: student.contact);
    denomination = TextEditingController(text: student.denomination);

    profileImage = student.image;

    religion = student.religion;
    gender = student.gender;

    street = TextEditingController();
    region = TextEditingController();
    country = TextEditingController();

    pickedDate = student.dob;
    hobby = TextEditingController(
      text: pickedDate == null
          ? ""
          : formatDate(DateFormat("dd/MM/yyyy").format(pickedDate!),
          shorten: true),
    );
  }

  @override
  void dispose() {
    street.dispose();
    region.dispose();
    country.dispose();
    fullName.dispose();
    denomination.dispose();
    number.dispose();
    hobby.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Center(
                child: profileImage != null
                    ? CircleAvatar(
                  backgroundImage: FileImage(File(profileImage!)),
                  radius: 75.r,
                )
                    : Image.asset(
                  "assets/images/Choose Image.png",
                  width: 160.r,
                  height: 160.r,
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: GestureDetector(
                  onTap: () => FileManager.single(type: FileType.image).then(
                        (value) => setState(() => profileImage = value?.path),
                  ),
                  child: Container(
                    width: 135.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: weirdBlack.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_rounded,
                            color: weirdBlack50, size: 18.r),
                        SizedBox(width: 5.w),
                        Text(
                          "Upload Photo",
                          style: context.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: weirdBlack50,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    SpecialForm(
                      controller: fullName,
                      width: 414.w,
                      height: 50.h,
                      hint: "Full Name",
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Email Address",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    SpecialForm(
                      controller: email,
                      width: 414.w,
                      height: 50.h,
                      hint: "example@example.com",
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Phone Number",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    SpecialForm(
                      controller: number,
                      width: 414.w,
                      height: 50.h,
                      hint: "080 1234 5678",
                      prefix: SizedBox(
                        height: 50.h,
                        width: 30.w,
                        child: Center(
                          child: Text(
                            "+234",
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack50,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      type: TextInputType.number,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Street",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    SpecialForm(
                      controller: street,
                      width: 414.w,
                      height: 50.h,
                      hint: "i.e Behind Abans Factory, Accord Junction",
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "State/Region",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    SpecialForm(
                      controller: region,
                      width: 414.w,
                      height: 50.h,
                      hint: "i.e Ogun State",
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Country",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    SpecialForm(
                      controller: country,
                      width: 414.w,
                      height: 50.h,
                      hint: "i.e Nigeria",
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Gender",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    ComboBox(
                      hint: "Select Gender",
                      value: gender,
                      dropdownItems: const ["Male", "Female"],
                      onChanged: (val) => setState(() => gender = val),
                      icon: const Icon(Boxicons.bxs_down_arrow),
                      buttonWidth: 414.w,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Religion",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500),
                    ),
                    ComboBox(
                      hint: "Choose Religion",
                      value: religion,
                      dropdownItems: const ["Christianity", "Islam", "Other"],
                      onChanged: (val) => setState(() => religion = val),
                      icon: const Icon(Boxicons.bxs_down_arrow),
                      buttonWidth: 414.w,
                    ),
                    SizedBox(height: 16.h),
                    if (religion != null && religion == "Christianity")
                      Text(
                        "Denomination",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                    if (religion != null && religion == "Christianity")
                      SpecialForm(
                        controller: denomination,
                        width: 414.w,
                        height: 50.h,
                        hint: "What is the name of your church or mosque?",
                      ),
                    if (religion != null && religion == "Christianity")
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
                                  () => hobby.text = formatDate(
                                  DateFormat("dd/MM/yyyy").format(pickedDate!),
                                  shorten: true),
                            );
                          }
                        },
                      ),
                      controller: hobby,
                      width: 414.w,
                      hint: "Jan 1, 1960",
                      height: 50.h,
                      readOnly: true,
                    ),
                    SizedBox(height: 50.h),
                    GestureDetector(
                      onTap: () => context.router.pop(),
                      child: Container(
                        width: 414.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: appBlue,
                        ),
                        child: Text(
                          "Save Changes",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 414.w,
                        minHeight: 1.h,
                        maxWidth: 414.w,
                        maxHeight: 1.h,
                      ),
                      child: const ColoredBox(color: Colors.black12),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Delete Account",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Ready to say goodbye? Deleting your account is a final step – "
                          "make sure you've backed up any important data before proceeding.",
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack75,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    GestureDetector(
                      onTap: () {
                        unFocus();
                        delete();
                      },
                      child: Container(
                        width: 414.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: const Color(0xFFDD0A0A),
                        ),
                        child: Text(
                          "Delete Account",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void delete() => showModalBottomSheet(
    context: context,
    builder: (_) => SizedBox(
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
                        "assets/images/Questions.png",
                        width: 135.r,
                        height: 135.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Do you want to delete account?",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Fynda wants to ensure that users are deleting their account intentionally.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 180.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: appBlue),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            "No, cancel",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: appBlue,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          resetProviders(ref);
                          context.router.goNamed(Pages.splash);
                        },
                        child: Container(
                          width: 180.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: appBlue,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            "Yes, delete",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
