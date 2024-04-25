import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/api/create_hostel_data.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';


class StepOne extends ConsumerStatefulWidget {
  const StepOne({
    super.key,
  });

  @override
  ConsumerState<StepOne> createState() => _StepOneState();
}

class _StepOneState extends ConsumerState<StepOne> {
  late Map<String, dynamic> info;

  @override
  void initState() {
    super.initState();

    info = {
      "landlordId": ref.read(currentUserProvider).id,
      "hostelDescription": "",
      "hostelName": "",
      "street": "",
      "junction": "",
      "state": "",
      "country": "",
      "RuleAndRegulation": [],
      "priceBudgetRange": "",
      "homeSize": 0.0,
      "hostelCategory": 0,
      "totalRoom": 0,
      "rooms": [],
      "FacilityName": [],
      "medias": [],
      "minPrice": 0.0,
      "maxPrice": 0.0,
      "isAnyRoomVacant": null,
      "roomPropertyIndex": null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
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
                    setState(() => info["hostelCategory"] = 0);
                  } else if (result == "Save") {
                    HostelCreationData.saveStepOneData(info)
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
                  onTap: () => setState(() => info["hostelCategory"] = 1),
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
                                      value: info["hostelCategory"],
                                      groupValue: 1,
                                      onChanged: (value) => setState(
                                              () => info["hostelCategory"] = 1),
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
                  onTap: () => setState(() => info["hostelCategory"] = 2),
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
                                      value: info["hostelCategory"],
                                      groupValue: 2,
                                      onChanged: (value) => setState(
                                              () => info["hostelCategory"] = 2),
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
                  onTap: () => setState(() => info["hostelCategory"] = 3),
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
                                      value: info["hostelCategory"],
                                      groupValue: 3,
                                      onChanged: (value) => setState(
                                              () => info["hostelCategory"] = 3),
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
                  onTap: () => setState(() => info["hostelCategory"] = 4),
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
                                      value: info["hostelCategory"],
                                      groupValue: 4,
                                      onChanged: (value) => setState(
                                              () => info["hostelCategory"] = 4),
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
              if (info["hostelCategory"] == 0) return;
              context.router.pushNamed(Pages.stepTwo, extra: info);
            },
            child: Container(
              width: 414.w,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: info["hostelCategory"] == 0
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
