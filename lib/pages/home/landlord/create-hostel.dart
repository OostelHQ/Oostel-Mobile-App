import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';

class CreateHostelPage extends StatefulWidget {
  const CreateHostelPage({super.key});

  @override
  State<CreateHostelPage> createState() => _CreateHostelPageState();
}

class _CreateHostelPageState extends State<CreateHostelPage> {
  int index = 1, hostelCategory = -1;
  final int total = 11;

  final TextEditingController hostelName = TextEditingController();
  final TextEditingController hostelDescription = TextEditingController();
  final TextEditingController hostelRooms = TextEditingController();
  final TextEditingController hostelArea = TextEditingController();

  final TextEditingController hostelStreet = TextEditingController();
  final TextEditingController hostelJunction = TextEditingController();
  final TextEditingController hostelRegion = TextEditingController();
  final TextEditingController hostelNation = TextEditingController();

  final TextEditingController hostelRules = TextEditingController();

  final List<String> rules = [];
  final List<String> hostelFacilities = [];

  @override
  void dispose() {
    hostelRules.dispose();
    hostelStreet.dispose();
    hostelJunction.dispose();
    hostelRegion.dispose();
    hostelNation.dispose();
    hostelArea.dispose();
    hostelRooms.dispose();
    hostelDescription.dispose();
    hostelName.dispose();
    super.dispose();
  }

  Widget get child {
    switch (index) {
      case 1:
        return _StepOne(
          initial: hostelCategory,
          onChooseCategory: (category) => setState(() {
            hostelCategory = category;
            index = 2;
          }),
        );
      case 2:
        return _StepTwo(
          name: hostelName,
          description: hostelDescription,
          rooms: hostelRooms,
          area: hostelArea,
          previous: () => setState(() => index = 1),
          next: () => setState(() => index = 3),
        );
      case 3:
        return _StepThree(
          street: hostelStreet,
          junction: hostelJunction,
          state: hostelRegion,
          country: hostelNation,
          previous: () => setState(() => index = 2),
          next: () => setState(() => index = 4),
        );
      case 4:
        return _StepFour(
          rule: hostelRules,
          rules: rules,
          previous: () => setState(() => index = 3),
          next: () => setState(() => index = 5),
        );
      case 5:
        return _StepFive(
          facilities: hostelFacilities,
          previous: () => setState(() => index = 4),
          next: () => setState(() => index = 6),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 414.w,
                child: LinearProgressIndicator(
                  value: index / total,
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
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _StepOne extends StatefulWidget {
  final int initial;
  final Function onChooseCategory;

  const _StepOne({
    super.key,
    required this.initial,
    required this.onChooseCategory,
  });

  @override
  State<_StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<_StepOne> {
  late int category;

  @override
  void initState() {
    super.initState();
    category = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Self Contained",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack,
                                  ),
                                ),
                                Radio(
                                  value: category,
                                  groupValue: 0,
                                  onChanged: (value) =>
                                      setState(() => category = 0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "One-Room",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack,
                                  ),
                                ),
                                Radio(
                                  value: category,
                                  groupValue: 1,
                                  onChanged: (value) =>
                                      setState(() => category = 1),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Face-to-Face",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack,
                                  ),
                                ),
                                Radio(
                                  value: category,
                                  groupValue: 2,
                                  onChanged: (value) =>
                                      setState(() => category = 2),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Flat",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: weirdBlack,
                                  ),
                                ),
                                Radio(
                                  value: category,
                                  groupValue: 3,
                                  onChanged: (value) =>
                                      setState(() => category = 3),
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
              SizedBox(height: 120.h),
            ],
          ),
        ),
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
                  onPressed: () => widget.onChooseCategory(category),
                  child: Text(
                    "Next",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _StepTwo extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController description;
  final TextEditingController rooms;
  final TextEditingController area;

  final VoidCallback next, previous;

  const _StepTwo({
    super.key,
    required this.name,
    required this.description,
    required this.rooms,
    required this.area,
    required this.next,
    required this.previous,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                hint: "i.e 2500 sqft",
              ),
              SizedBox(height: 150.h),
            ],
          ),
        ),
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
                    onPressed: next,
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
        )
      ],
    );
  }
}

class _StepThree extends StatefulWidget {
  final TextEditingController street;
  final TextEditingController junction;
  final TextEditingController state;
  final TextEditingController country;

  final VoidCallback next, previous;

  const _StepThree({
    super.key,
    required this.street,
    required this.junction,
    required this.state,
    required this.country,
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

  @override
  void initState() {
    super.initState();
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    fontWeight: FontWeight.w500,
                    color: weirdBlack75,
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
                controller: widget.street,
                width: 414.w,
                height: 50.h,
                hint: "i.e Behind Abans Factory",
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
                controller: widget.junction,
                width: 414.w,
                height: 50.h,
                hint: "i.e Accord",
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
                controller: widget.state,
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
                controller: widget.country,
                width: 414.w,
                height: 50.h,
                hint: "i.e Nigeria",
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
                    onPressed: widget.next,
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
        )
      ],
    );
  }
}

class _StepFour extends StatefulWidget {
  final TextEditingController rule;
  final List<String> rules;

  final VoidCallback next, previous;

  const _StepFour({
    super.key,
    required this.rules,
    required this.rule,
    required this.next,
    required this.previous,
  });

  @override
  State<_StepFour> createState() => _StepFourState();
}

class _StepFourState extends State<_StepFour> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                controller: widget.rule,
                width: 414.w,
                height: 50.h,
                hint: "i.e The Do's and Don't's of the hostel",
                suffix: GestureDetector(
                  onTap: () {
                    String text = widget.rule.text.trim();
                    if (text.isNotEmpty) {
                      widget.rules.add(text);
                      widget.rule.clear();
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
                  widget.rules.length,
                  (index) => Text(
                    "${index + 1}. ${widget.rules[index]}",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: weirdBlack75,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 300.h),
            ],
          ),
        ),
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
                    onPressed: widget.next,
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
        )
      ],
    );
  }
}

class _StepFive extends StatefulWidget {
  final List<String> facilities;
  final VoidCallback next, previous;

  const _StepFive({
    super.key,
    required this.facilities,
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                "Get started with any of your preferable account to be stress-free",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack75,
                ),
              ),
              SizedBox(height: 44.h),
              SizedBox(
                height: 500.h,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.w,
                    mainAxisExtent: 90.h,
                  ),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 170.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: fadedBorder),
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
                                  SvgPicture.asset(images[index]),
                                  Text(
                                    names[index],
                                    style: context.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: weirdBlack50,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                if (widget.facilities.contains(names[index])) {
                                  widget.facilities.remove(names[index]);
                                } else {
                                  widget.facilities.add(names[index]);
                                }
                              }),
                              child: Container(
                                height: 15.r,
                                width: 15.r,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: fadedBorder),
                                  borderRadius: BorderRadius.circular(3.r),
                                  color:
                                      widget.facilities.contains(names[index])
                                          ? appBlue
                                          : null,
                                ),
                                child: widget.facilities.contains(names[index])
                                    ? const Icon(Icons.done_rounded,
                                        color: Colors.white, size: 10)
                                    : null,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: names.length,
                ),
              )
            ],
          ),
        ),
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
                      onPressed: widget.next,
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
        )
      ],
    );
  }
}
