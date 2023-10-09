import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/room_details.dart';
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

class CreateHostelPage extends ConsumerStatefulWidget {
  const CreateHostelPage({super.key});

  @override
  ConsumerState<CreateHostelPage> createState() => _CreateHostelPageState();
}

class _CreateHostelPageState extends ConsumerState<CreateHostelPage> {
  int index = 1;
  final int total = 10;

  late Map<String, dynamic> info;

  int? roomPropertyIndex;

  @override
  void initState() {
    super.initState();

    info = {
      "name": "",
      "image": Uint8List(0),
      "bedrooms": 0,
      "bathrooms": 0,
      "area": 0,
      "address": "###",
      "price": 0,
      "rules": [],
      "category": "",
      "totalRooms": 0,
      "description": "",
      "roomsLeft": [],
      "hostelFacilities": [],
      "media": [],
    };
  }

  void next() => setState(() {
        if (index == 7) {
          index = !(info["vacancy"] as bool) ? 10 : 8;
        } else if (index == 8) {
          index = 10;
        } else if (index == 9) {
          index = 8;
        } else {
          ++index;
        }
      });

  void previous() => setState(() {
        if (index == 10) {
          index = 8;
        } else {
          --index;
        }
      });

  Widget get child {
    switch (index) {
      case 1:
        return _StepOne(info: info, next: next);
      case 2:
        return _StepTwo(info: info, next: next, previous: previous);
      case 3:
        return _StepThree(info: info, next: next, previous: previous);
      case 4:
        return _StepFour(info: info, next: next, previous: previous);
      case 5:
        return _StepFive(info: info, next: next, previous: previous);
      case 6:
        return _StepSix(info: info, next: next, previous: previous);
      case 7:
        return _StepSeven(info: info, next: next, previous: previous);
      case 8:
        return _StepEight(
          info: info,
          next: next,
          previous: previous,
          onCreate: ({int? roomIndex}) => setState(() {
            index = 9;
            roomPropertyIndex = roomIndex;
          }),
        );
      case 9:
        return _StepNine(
            info: info, index: roomPropertyIndex, onProceed: previous);
      case 10:
        return _StepTen(info: info, previous: previous);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}

class _StepOne extends StatefulWidget {
  final Map<String, dynamic> info;
  final VoidCallback next;

  const _StepOne({
    super.key,
    required this.info,
    required this.next,
  });

  @override
  State<_StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<_StepOne> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                width: 414.w,
                child: LinearProgressIndicator(
                  value: 0.1,
                  color: appBlue,
                  minHeight: 1.5.h,
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  iconSize: 26.r,
                  splashRadius: 20.r,
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          sliver: SliverToBoxAdapter(
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
                  "Get started with any of your preferable account to be stress-free",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
                  ),
                ),
                SizedBox(height: 44.h),
                Card(
                  elevation: 1.0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                                    value: widget.info["category"],
                                    groupValue: "Self Contained",
                                    onChanged: (value) => setState(() => widget
                                        .info["category"] = "Self Contained"),
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
                SizedBox(height: 16.h),
                Card(
                  elevation: 1.0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                                    value: widget.info["category"],
                                    groupValue: "One-Room",
                                    onChanged: (value) => setState(() =>
                                        widget.info["category"] = "One-Room"),
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
                SizedBox(height: 16.h),
                Card(
                  elevation: 1.0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                                    value: widget.info["category"],
                                    groupValue: "Face-to-Face",
                                    onChanged: (value) => setState(() => widget
                                        .info["category"] = "Face-to-Face"),
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
                SizedBox(height: 16.h),
                Card(
                  elevation: 1.0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                                    value: widget.info["category"],
                                    groupValue: "Flat",
                                    onChanged: (value) => setState(
                                        () => widget.info["category"] = "Flat"),
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
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 48.h),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 414.w,
                  minWidth: 414.w,
                  minHeight: 90.h,
                  maxHeight: 90.h,
                ),
                child: ColoredBox(
                  color: paleBlue,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBlue,
                            minimumSize: Size(414.w, 50.h),
                          ),
                          onPressed: () {
                            if (widget.info["category"].isEmpty) {
                              showError(
                                  "Please choose a category for your hostel");
                              return;
                            }

                            widget.next();
                          },
                          child: Text(
                            "Next",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepTwo extends StatefulWidget {
  final Map<String, dynamic> info;
  final VoidCallback next, previous;

  const _StepTwo({
    super.key,
    required this.info,
    required this.next,
    required this.previous,
  });

  @override
  State<_StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<_StepTwo> {
  late TextEditingController name;
  late TextEditingController description;
  late TextEditingController rooms;
  late TextEditingController area;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.info["name"]);
    description = TextEditingController(text: widget.info["description"]);
    rooms = TextEditingController(text: widget.info["totalRooms"].toString());
    area = TextEditingController(text: widget.info["area"].toStringAsFixed(0));
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    rooms.dispose();
    area.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  width: 414.w,
                  child: LinearProgressIndicator(
                    value: 0.2,
                    color: appBlue,
                    minHeight: 1.5.h,
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 26.r,
                    splashRadius: 20.r,
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 18.h),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
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
                      "Get started with any of your preferable account to be stress-free",
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
                    onSave: (val) => widget.info["name"] = val!,
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
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please give a description for your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info["description"] = val!,
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
                    onSave: (val) =>
                        widget.info["totalRooms"] = int.parse(val!),
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
                    onSave: (val) => widget.info["area"] = double.parse(val!),
                  ),
                  SizedBox(height: 150.h),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 48.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 414.w,
                    minWidth: 414.w,
                    minHeight: 90.h,
                    maxHeight: 90.h,
                  ),
                  child: ColoredBox(
                    color: paleBlue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appBlue,
                              minimumSize: Size(180.w, 50.h),
                            ),
                            onPressed: widget.previous,
                            child: Text(
                              "Go Back",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appBlue,
                              minimumSize: Size(180.w, 50.h),
                            ),
                            onPressed: () {
                              if (!validate(formKey)) return;
                              widget.next();
                            },
                            child: Text(
                              "Next",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _StepThree extends StatefulWidget {
  final Map<String, dynamic> info;
  final VoidCallback next, previous;

  const _StepThree({
    super.key,
    required this.info,
    required this.next,
    required this.previous,
  });

  @override
  State<_StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<_StepThree>
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

    String address = widget.info["address"];

    List<String> subs = address.split("#");

    street = TextEditingController(text: subs[0]);
    junction = TextEditingController(text: subs[1]);
    state = TextEditingController(text: subs[2]);
    country = TextEditingController(text: subs[3]);

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  width: 414.w,
                  child: LinearProgressIndicator(
                    value: 0.3,
                    color: appBlue,
                    minHeight: 1.5.h,
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 26.r,
                    splashRadius: 20.r,
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 18.h),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
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
                      "Get started with any of your preferable account to be stress-free",
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
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the street of your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info["address"] =
                        "${val!}#${junction.text}#${state.text}#${country.text}",
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
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the junction of your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info["address"] =
                        "${street.text}#${val!}#${state.text}#${country.text}",
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
                    onValidate: (val) {
                      if (val == null || val!.trim().isEmpty) {
                        showError("Please enter the street of your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info["address"] =
                        "${street.text}#${junction.text}#${val!}#${country.text}",
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
                        showError("Please enter the street of your hostel.");
                        return '';
                      }
                      return null;
                    },
                    onSave: (val) => widget.info["address"] =
                        "${street.text}#${junction.text}#${state.text}#${val!}",
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Switch(
                        value: share,
                        onChanged: (value) {
                          setState(() => share = !share);
                          if (share) {
                            controller.forward();
                          } else {
                            controller.reverse();
                          }
                        },
                        activeColor: appBlue,
                      ),
                      Text(
                        "Activate Google Maps to share your location",
                        style: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: weirdBlack75,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SizeTransition(
                    sizeFactor: animation,
                    child: Card(
                      elevation: 1.0,
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
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 48.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 414.w,
                    minWidth: 414.w,
                    minHeight: 90.h,
                    maxHeight: 90.h,
                  ),
                  child: ColoredBox(
                    color: paleBlue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appBlue,
                              minimumSize: Size(180.w, 50.h),
                            ),
                            onPressed: widget.previous,
                            child: Text(
                              "Go Back",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appBlue,
                              minimumSize: Size(180.w, 50.h),
                            ),
                            onPressed: () {
                              if (!validate(formKey)) return;
                              widget.next();
                            },
                            child: Text(
                              "Next",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _StepFour extends StatefulWidget {
  final Map<String, dynamic> info;

  final VoidCallback previous, next;

  const _StepFour({
    super.key,
    required this.info,
    required this.next,
    required this.previous,
  });

  @override
  State<_StepFour> createState() => _StepFourState();
}

class _StepFourState extends State<_StepFour> {
  final TextEditingController rule = TextEditingController();

  late List<String> rules;

  @override
  void initState() {
    super.initState();
    rules = toStringList(widget.info["rules"]);
    widget.info["rules"] = rules;
  }

  @override
  void dispose() {
    rule.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                width: 414.w,
                child: LinearProgressIndicator(
                  value: 0.4,
                  color: appBlue,
                  minHeight: 1.5.h,
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  iconSize: 26.r,
                  splashRadius: 20.r,
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          sliver: SliverToBoxAdapter(
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
                    "Get started with any of your preferable account to be stress-free",
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
                        rules.add(text);
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
                    rules.length,
                    (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300.w,
                          child: Text(
                            "${index + 1}. ${rules[index]}",
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
                            rules.removeAt(index);
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 360.h),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 48.h),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 414.w,
                  minWidth: 414.w,
                  minHeight: 90.h,
                  maxHeight: 90.h,
                ),
                child: ColoredBox(
                  color: paleBlue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBlue,
                            minimumSize: Size(180.w, 50.h),
                          ),
                          onPressed: widget.previous,
                          child: Text(
                            "Go Back",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBlue,
                            minimumSize: Size(180.w, 50.h),
                          ),
                          onPressed: () {
                            if (rules.isEmpty) {
                              showError(
                                  "Please enter the rules for your hostel");
                              return;
                            }
                            widget.next();
                          },
                          child: Text(
                            "Next",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _StepFive extends StatefulWidget {
  final Map<String, dynamic> info;
  final VoidCallback next, previous;

  const _StepFive({
    super.key,
    required this.info,
    required this.next,
    required this.previous,
  });

  @override
  State<_StepFive> createState() => _StepFiveState();
}

class _StepFiveState extends State<_StepFive> {
  final List<String> images = [
    "assets/images/Light-Off.svg",
    "assets/images/Tap.svg",
    "assets/images/Well.svg",
    "assets/images/Pool.svg",
    "assets/images/Security.svg",
  ];

  final List<String> names = [
    "Light",
    "Tap Water",
    "Well Water",
    "Swimming Pool",
    "Security"
  ];

  late List<String> facilities;

  @override
  void initState() {
    super.initState();
    facilities = toStringList(widget.info["hostelFacilities"]);
    widget.info["hostelFacilities"] = facilities;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 0.5,
                color: appBlue,
                minHeight: 1.5.h,
              ),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 26.r,
                splashRadius: 20.r,
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        sliver: SliverToBoxAdapter(
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
                "Get started with any of your preferable account to be stress-free",
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
                    color: facilities.contains(names[index]) ? paleBlue : null,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(images[index],
                                  color: present ? appBlue : null),
                              Text(
                                names[index],
                                style: context.textTheme.bodyMedium!.copyWith(
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
          )),
      SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(height: 48.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 414.w,
                minWidth: 414.w,
                minHeight: 90.h,
                maxHeight: 90.h,
              ),
              child: ColoredBox(
                color: paleBlue,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(180.w, 50.h),
                        ),
                        onPressed: widget.previous,
                        child: Text(
                          "Go Back",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(180.w, 50.h),
                        ),
                        onPressed: () {
                          if (facilities.isEmpty) {
                            showError(
                                "Please choose facilities for your hostel");
                            return;
                          }
                          widget.next();
                        },
                        child: Text(
                          "Next",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

class _StepSix extends StatefulWidget {
  final Map<String, dynamic> info;
  final VoidCallback next, previous;

  const _StepSix({
    super.key,
    required this.info,
    required this.next,
    required this.previous,
  });

  @override
  State<_StepSix> createState() => _StepSixState();
}

class _StepSixState extends State<_StepSix> {
  late bool isEmpty;

  @override
  void initState() {
    super.initState();
    isEmpty = widget.info["image"].isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 0.6,
                color: appBlue,
                minHeight: 1.5.h,
              ),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 26.r,
                splashRadius: 20.r,
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
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
                "Get started with any of your preferable account to be stress-free",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack75,
                ),
              ),
              SizedBox(height: 44.h),
              GestureDetector(
                onTap: () => FileManager.single(type: FileType.image)
                    .then((response) async {
                  if (response == null) return;
                  Uint8List data =
                      await FileManager.convertSingleToData(response.path);
                  setState(() {
                    widget.info["image"] = data;
                    isEmpty = false;
                  });
                }),
                child: Container(
                  width: 350.w,
                  height: 270.h,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: isEmpty ? paleBlue : null,
                    image: isEmpty
                        ? null
                        : DecorationImage(
                            image: MemoryImage(widget.info["image"]),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: isEmpty
                      ? Column(
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
                              "Upload a front-view picture of your hostel",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Maximum size allowed is 20MB of png and jpg format",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      : null,
                ),
              ),
              SizedBox(height: 250.h),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(height: 48.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 414.w,
                minWidth: 414.w,
                minHeight: 90.h,
                maxHeight: 90.h,
              ),
              child: ColoredBox(
                color: paleBlue,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(180.w, 50.h),
                        ),
                        onPressed: widget.previous,
                        child: Text(
                          "Go Back",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(180.w, 50.h),
                        ),
                        onPressed: () {
                          if (isEmpty) {
                            showError(
                                "Please choose an image for your hostel front view");
                            return;
                          }
                          widget.next();
                        },
                        child: Text(
                          "Next",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

class _StepSeven extends StatefulWidget {
  final Map<String, dynamic> info;
  final VoidCallback next, previous;

  const _StepSeven({
    super.key,
    required this.info,
    required this.next,
    required this.previous,
  });

  @override
  State<_StepSeven> createState() => _StepSevenState();
}

class _StepSevenState extends State<_StepSeven> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 0.7,
                color: appBlue,
                minHeight: 1.5.h,
              ),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 26.r,
                splashRadius: 20.r,
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
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
                "Room Vacancy",
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: weirdBlack,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Do you have any vacancy room(s) in your hostel?",
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
              Card(
                elevation: 1.0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Image.memory(
                          widget.info["image"],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Yes",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack,
                                  ),
                                ),
                                Radio(
                                  value: widget.info["vacancy"],
                                  groupValue: true,
                                  onChanged: (value) => setState(
                                      () => widget.info["vacancy"] = true),
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
              Card(
                elevation: 1.0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Image.memory(
                          widget.info["image"],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "No",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack,
                                  ),
                                ),
                                Radio(
                                  value: widget.info["vacancy"],
                                  groupValue: false,
                                  onChanged: (value) => setState(
                                      () => widget.info["vacancy"] = false),
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
      SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(height: 48.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 414.w,
                minWidth: 414.w,
                minHeight: 90.h,
                maxHeight: 90.h,
              ),
              child: ColoredBox(
                color: paleBlue,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(180.w, 50.h),
                        ),
                        onPressed: widget.previous,
                        child: Text(
                          "Go Back",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(180.w, 50.h),
                        ),
                        onPressed: () {
                          if (widget.info["vacancy"] == null) {
                            showError(
                                "Please indicate if your hostel has vacancy");
                            return;
                          }
                          widget.next();
                        },
                        child: Text(
                          "Next",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

class _StepEight extends StatefulWidget {
  final Map<String, dynamic> info;
  final VoidCallback next, previous;
  final Function onCreate;

  const _StepEight({
    super.key,
    required this.info,
    required this.next,
    required this.previous,
    required this.onCreate,
  });

  @override
  State<_StepEight> createState() => _StepEightState();
}

class _StepEightState extends State<_StepEight> {
  late List<RoomInfo> rooms;

  @override
  void initState() {
    super.initState();
    rooms = toRoomList(widget.info["roomsLeft"]);
    widget.info["roomsLeft"] = rooms;
  }

  bool exists(int index) => index < rooms.length;

  int totalCards = 2;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(
              width: 414.w,
              child: LinearProgressIndicator(
                value: 0.8,
                color: appBlue,
                minHeight: 1.5.h,
              ),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 26.r,
                splashRadius: 20.r,
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        sliver: SliverToBoxAdapter(
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
                "Vacancy Presentation",
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: weirdBlack,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Get started with any of your preferable account to be stress-free",
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
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 16.h,
            ),
            itemCount: totalCards + 1,
            itemBuilder: (context, index) {
              if (index == totalCards) {
                return Column(
                  children: [
                    SizedBox(height: 32.h),
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
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: appBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }

              return !exists(index)
                  ? GestureDetector(
                      onTap: () => widget.onCreate(),
                      child: const _NoRoom(),
                    )
                  : GestureDetector(
                      onTap: () => widget.onCreate(roomIndex: index),
                      child: _CreateRoomCard(info: rooms[index]),
                    );
            },
          )),
      SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(height: 48.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 414.w,
                minWidth: 414.w,
                minHeight: 90.h,
                maxHeight: 90.h,
              ),
              child: ColoredBox(
                color: paleBlue,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(180.w, 50.h),
                        ),
                        onPressed: widget.previous,
                        child: Text(
                          "Go Back",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(180.w, 50.h),
                        ),
                        onPressed: () {
                          if (rooms.length < 2) {
                            showError("Please create at least two rooms");
                            return;
                          }
                          widget.next();
                        },
                        child: Text(
                          "Next",
                          style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

class _NoRoom extends StatelessWidget {
  const _NoRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _CreateRoomCard extends StatelessWidget {
  final RoomInfo info;

  const _CreateRoomCard({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    info.media[0],
                    width: 414.w,
                    height: 156.h,
                    fit: BoxFit.cover,
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
    );
  }
}

class _StepNine extends StatefulWidget {
  final Map<String, dynamic> info;
  final int? index;
  final VoidCallback onProceed;

  const _StepNine({
    super.key,
    required this.info,
    required this.onProceed,
    this.index,
  });

  @override
  State<_StepNine> createState() => _StepNineState();
}

class _StepNineState extends State<_StepNine> {
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
  late List<String> media;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    RoomInfo? room;

    if (widget.index != null) {
      List<RoomInfo> rooms = toRoomList(widget.info["roomsLeft"]);
      widget.info["roomsLeft"] = rooms;
      room = rooms[widget.index!];
      facilities = room.facilities;
      media = room.media;
    } else {
      facilities = [];
      media = [];
    }

    name = TextEditingController(text: room?.name);
    price = TextEditingController(text: room?.price.toStringAsFixed(0));
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  width: 414.w,
                  child: LinearProgressIndicator(
                    value: 0.9,
                    color: appBlue,
                    minHeight: 1.5.h,
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 26.r,
                    splashRadius: 20.r,
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 18.h),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "STEP 9",
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
                      "Get started with any of your preferable account to be stress-free",
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
                        showError("Please enter a valid price for this room.");
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
                    dropdownItems: const [],
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
                      color:
                          facilities.contains(names[index]) ? paleBlue : null,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(images[index],
                                    color: present ? appBlue : null),
                                Text(
                                  names[index],
                                  style: context.textTheme.bodyMedium!.copyWith(
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
                ])),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: media.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        width: 350.w,
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
                              "Upload a front-view picture of your hostel",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Maximum size allowed is 20MB of png and jpg format",
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: Image.file(
                            File(media[index]),
                            width: 110.r,
                            height: 110.r,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                            right: 20.r,
                            top: 20.r,
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => media.removeAt(index)),
                              child: const Icon(Boxicons.bx_x,
                                  color: Colors.white, size: 18),
                            )),
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
                      Text(
                        "*Note that you must to upload minimum of 8 and above images before you can proceed.",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall!.copyWith(
                          color: weirdBlack50,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      GestureDetector(
                        onTap: () => FileManager.multiple(type: FileType.image)
                            .then((response) async {
                          if (response.isEmpty) return;

                          for (var resp in response) {
                            media.add(resp.path);
                          }

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
                                style: context.textTheme.bodyMedium!.copyWith(
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
                SizedBox(height: 48.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 414.w,
                    minWidth: 414.w,
                    minHeight: 90.h,
                    maxHeight: 90.h,
                  ),
                  child: ColoredBox(
                    color: paleBlue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appBlue,
                              minimumSize: Size(180.w, 50.h),
                            ),
                            onPressed: widget.onProceed,
                            child: Text(
                              "Go Back",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appBlue,
                              minimumSize: Size(180.w, 50.h),
                            ),
                            onPressed: () {
                              if (!validate(formKey)) return;

                              if (widget.index == null) {
                                RoomInfo room = RoomInfo(
                                  id: "",
                                  name: name.text.trim(),
                                  price: double.parse(price.text),
                                  facilities: facilities,
                                  media: media,
                                );

                                List<RoomInfo> rooms =
                                    toRoomList(widget.info["roomsLeft"]);
                                rooms.add(room);
                              }

                              widget.onProceed();
                            },
                            child: Text(
                              "Next",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}

class _StepTen extends StatelessWidget {
  final Map<String, dynamic> info;
  final VoidCallback previous;

  const _StepTen({
    super.key,
    required this.info,
    required this.previous,
  });

  List<int> calculate(List<RoomInfo> rooms) {
    int baths = 0, kitchens = 0, toilets = 0;

    for (RoomInfo info in rooms) {
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
    }

    return [
      baths,
      toilets,
      kitchens,
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<String> media = toStringList(info["media"]);
    List<String> facilities = toStringList(info["hostelFacilities"]);
    List<String> rules = toStringList(info["rules"]);
    List<RoomInfo> rooms = toRoomList(info["roomsLeft"]);
    int availableRooms = rooms.length;
    int totalRooms = info["totalRooms"];

    List<int> totalProps = calculate(rooms);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                width: 414.w,
                child: LinearProgressIndicator(
                  value: 1.0,
                  color: appBlue,
                  minHeight: 1.5.h,
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  iconSize: 26.r,
                  splashRadius: 20.r,
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
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
                    "Preview",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: Text(
                    "Get started with any of your preferable account to be stress-free",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  ),
                ),
                SizedBox(height: 44.h),
                Card(
                  elevation: 1.0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            File(media[0]),
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
                              width: 280.w,
                              child: Text(
                                info["name"],
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
                          joinToAddress(info["address"]),
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
                                  "${(info["area"]).toStringAsFixed(0)} sqft",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      color: weirdBlack50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "${currency()} ${formatAmountInDouble(info["price"])}",
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
                          info["description"],
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Hostel Rules",
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
            ),
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
                  Text(
                    "Available Rooms",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                ]))),
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
              info: rooms[index],
              isAsset: false,
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
            itemBuilder: (_, index) => ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: Image.file(
                File(media[index]),
                width: 110.r,
                height: 110.r,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 48.h),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 414.w,
                  minWidth: 414.w,
                  minHeight: 90.h,
                  maxHeight: 90.h,
                ),
                child: ColoredBox(
                  color: paleBlue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBlue,
                            minimumSize: Size(180.w, 50.h),
                          ),
                          onPressed: previous,
                          child: Text(
                            "Go Back",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBlue,
                            minimumSize: Size(180.w, 50.h),
                          ),
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (context) => const _CreateHostelModal(),
                            isDismissible: false,
                          ).then(
                            (resp) => context.router.pop(),
                          ),
                          child: Text(
                            "Next",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

List<String> toStringList(List<dynamic> list) {
  List<String> result = [];
  for (var element in list) {
    result.add(element as String);
  }
  return result;
}

List<RoomInfo> toRoomList(List<dynamic> list) {
  List<RoomInfo> result = [];
  for (var element in list) {
    result.add(element as RoomInfo);
  }
  return result;
}

class _CreateHostelModal extends StatefulWidget {
  const _CreateHostelModal({super.key});

  @override
  State<_CreateHostelModal> createState() => _CreateHostelModalState();
}

class _CreateHostelModalState extends State<_CreateHostelModal> {
  bool created = false;

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
                        "assets/images/Hostel ${!created ? "Launch" : "Created"}.png",
                        width: 135.r,
                        height: 135.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Hostel ${!created ? "Launched" : "Created"} Successfully",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: weirdBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 42.h),
                  ElevatedButton(
                    onPressed: () {
                      if (!created) {
                        setState(() => created = true);
                      } else {
                        context.router.pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appBlue,
                    ),
                    child: Text(
                      "Ok, thanks",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
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
