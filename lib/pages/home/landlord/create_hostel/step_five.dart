import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/api/create_hostel_data.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';


class StepFive extends StatefulWidget {
  final Map<String, dynamic> info;

  const StepFive({
    super.key,
    required this.info,
  });

  @override
  State<StepFive> createState() => _StepFiveState();
}

class _StepFiveState extends State<StepFive> {
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

  final List<String> names = ["Light", "Tap", "Well", "Pool", "Security",];

  late List<String> facilities;

  @override
  void initState() {
    super.initState();
    facilities = toStringList(widget.info["FacilityName"]);
    widget.info["FacilityName"] = facilities;
  }

  @override
  Widget build(BuildContext context) {
    facilities.remove("None");

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
                    value: "Save",
                    child: Text(
                      "Save and Exit",
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: "Reset",
                    child: Text(
                      "Reset",
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ],
                onSelected: (result) {
                  if (result == "Reset") {
                    setState(() => facilities.clear());
                  } else if (result == "Save") {
                    HostelCreationData.saveStepFiveData(widget.info)
                        .then((_) => context.router.goNamed(Pages.ownerDashboard));
                  }
                },
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                          images[present ? index + 5 : index]),
                                      Text(
                                        names[index],
                                        style:
                                        context.textTheme.bodyMedium!.copyWith(
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
                if (facilities.isEmpty) {
                  facilities.add("None");
                }

                context.router.pushNamed(Pages.stepSix, extra: widget.info);
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
