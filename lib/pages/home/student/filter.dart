import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class FilterPage extends StatelessWidget {
  final bool hostel;

  const FilterPage({
    super.key,
    required this.hostel,
  });

  @override
  Widget build(BuildContext context) {
    return hostel ? const _HostelFilter() : const _RoommateFilter();
  }
}

class _HostelFilter extends ConsumerStatefulWidget {
  const _HostelFilter();

  @override
  ConsumerState<_HostelFilter> createState() => _HostelFilterState();
}

class _HostelFilterState extends ConsumerState<_HostelFilter>
    with TickerProviderStateMixin {
  late List<bool> selectedCategories, selectedLocations;
  bool expandedCategories = true, expandedArea = true, expandedPrice = true;

  final List<AnimationController> controllers = [];
  final List<Animation<double>> animations = [];

  final TextEditingController areaController = TextEditingController();
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; ++i) {
      controllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        ),
      );
      animations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controllers[i],
            curve: Curves.easeInSine,
            reverseCurve: Curves.easeOutSine,
          ),
        ),
      );

      controllers[i].forward();
    }

    selectedCategories =
        List.generate(ref.read(roomTypesProvider).length, (index) => false);
    selectedLocations =
        List.generate(ref.read(locationProvider).length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0.0,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 20.r,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Text(
          "Filter",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Categories",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(
                            () => expandedCategories = !expandedCategories);
                        if (expandedCategories) {
                          controllers[0].forward();
                        } else {
                          controllers[0].reverse();
                        }
                      },
                      child: Icon(
                        !expandedCategories
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: weirdBlack50,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                SizeTransition(
                  sizeFactor: animations[0],
                  child: SizedBox(
                    height: 125.h,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 40.h,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 20.w,
                      ),
                      itemCount: selectedCategories.length,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () => setState(() => selectedCategories[index] =
                            !selectedCategories[index]),
                        child: Container(
                          height: 40.h,
                          width: 135.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectedCategories[index]
                                      ? appBlue
                                      : fadedBorder),
                              borderRadius: BorderRadius.circular(5.r),
                              color:
                                  selectedCategories[index] ? paleBlue : null),
                          child: Text(
                            ref.read(roomTypesProvider)[index],
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: selectedCategories[index]
                                    ? appBlue
                                    : weirdBlack50,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Area",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => expandedArea = !expandedArea);
                        if (expandedArea) {
                          controllers[1].forward();
                        } else {
                          controllers[1].reverse();
                        }
                      },
                      child: Icon(
                        !expandedArea
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: weirdBlack50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                SizeTransition(
                  sizeFactor: animations[1],
                  child: Column(
                    children: [
                      SpecialForm(
                        controller: areaController,
                        width: 414.w,
                        height: 45.h,
                        hint: "Type Address",
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 170.h,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 40.h,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 20.w,
                          ),
                          itemCount: selectedLocations.length,
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () => setState(() =>
                                selectedLocations[index] =
                                    !selectedLocations[index]),
                            child: Container(
                              height: 40.h,
                              width: 105.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: selectedLocations[index]
                                          ? appBlue
                                          : fadedBorder),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: selectedLocations[index]
                                      ? paleBlue
                                      : null),
                              child: Text(
                                ref.read(locationProvider)[index],
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: selectedLocations[index]
                                        ? appBlue
                                        : weirdBlack50,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Price",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => expandedPrice = !expandedPrice);
                        if (expandedPrice) {
                          controllers[2].forward();
                        } else {
                          controllers[2].reverse();
                        }
                      },
                      child: Icon(
                        !expandedPrice
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: weirdBlack50,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                SizeTransition(
                  sizeFactor: animations[2],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpecialForm(
                        controller: minController,
                        width: 120.w,
                        height: 40.h,
                        hint: "80,000",
                        type: TextInputType.number,
                      ),
                      Text(
                        "to",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack50, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: maxController,
                        width: 120.w,
                        height: 40.h,
                        hint: "100,000",
                        type: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: 414.w,
        height: 90.h,
        color: paleBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                selectedCategories =
                    List.generate(ref.read(roomTypesProvider).length, (index) => false);
                selectedLocations =
                    List.generate(ref.read(locationProvider).length, (index) => false);
                areaController.clear();
                minController.clear();
                maxController.clear();
                unFocus();
                setState(() {});
              },
              child: Container(
                width: 180.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: appBlue, width: 1.5),
                ),
                child: Text(
                  "Reset",
                  style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: appBlue),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 180.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: appBlue,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  "Apply",
                  style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RoommateFilter extends ConsumerStatefulWidget {
  const _RoommateFilter();

  @override
  ConsumerState<_RoommateFilter> createState() => _RoommateFilterState();
}

class _RoommateFilterState extends ConsumerState<_RoommateFilter>
    with TickerProviderStateMixin {
  late List<bool> selectedGenders, selectedLevels, selectedLocations;
  bool expandedGenders = true,
      expandedLevels = true,
      expandedArea = true,
      expandedPrice = true;

  late List<String> levels;

  final List<AnimationController> controllers = [];
  final List<Animation<double>> animations = [];

  final TextEditingController areaController = TextEditingController();
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 4; ++i) {
      controllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        ),
      );
      animations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controllers[i],
            curve: Curves.easeInSine,
            reverseCurve: Curves.easeOutSine,
          ),
        ),
      );

      controllers[i].forward();
    }

    selectedGenders = [false, false, false];
    selectedLevels = List.generate(8, (index) => false);
    selectedLocations =
        List.generate(ref.read(locationProvider).length, (index) => false);

    levels = const [
      "100 level",
      "200 level",
      "300 level",
      "400 level",
      "500 level",
      "600 level",
      "700 level",
      "Post Graduate",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0.0,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 20.r,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Text(
          "Filter",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Gender",
                      style: context.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => expandedGenders = !expandedGenders);
                        if (expandedGenders) {
                          controllers[0].forward();
                        } else {
                          controllers[0].reverse();
                        }
                      },
                      child: Icon(
                        !expandedGenders
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: weirdBlack50,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                SizeTransition(
                  sizeFactor: animations[0],
                  child: SizedBox(
                    height: 55.h,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 40.h,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 20.w,
                      ),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () => setState(
                          () {
                            if (index == 0) {
                              selectedGenders[1] = selectedGenders[2] = false;
                              selectedGenders[0] = true;
                            } else if (index == 1) {
                              selectedGenders[0] = selectedGenders[2] = false;
                              selectedGenders[1] = true;
                            } else {
                              selectedGenders[1] = selectedGenders[0] = false;
                              selectedGenders[2] = true;
                            }
                          },
                        ),
                        child: Container(
                          height: 40.h,
                          width: 75.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      selectedGenders[index] ? appBlue : fadedBorder),
                              borderRadius: BorderRadius.circular(5.r),
                              color: selectedGenders[index] ? paleBlue : null),
                          child: Text(
                            (index == 0
                                ? "All"
                                : (index == 1)
                                    ? "Male"
                                    : "Female"),
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: selectedGenders[index] ? appBlue : weirdBlack50,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      itemCount: 3,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Level",
                      style: context.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => expandedLevels = !expandedLevels);
                        if (expandedLevels) {
                          controllers[1].forward();
                        } else {
                          controllers[1].reverse();
                        }
                      },
                      child: Icon(
                        !expandedLevels
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: weirdBlack50,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                SizeTransition(
                  sizeFactor: animations[1],
                  child: SizedBox(
                    height: 170.h,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 40.h,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 20.w,
                      ),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () => setState(
                            () => selectedLevels[index] = !selectedLevels[index]),
                        child: Container(
                          height: 40.h,
                          width: 115.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectedLevels[index] ? appBlue : fadedBorder),
                              borderRadius: BorderRadius.circular(5.r),
                              color: selectedLevels[index] ? paleBlue : null),
                          child: Text(
                            levels[index],
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: selectedLevels[index] ? appBlue : weirdBlack50,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      itemCount: levels.length,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Area",
                      style: context.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => expandedArea = !expandedArea);
                        if (expandedArea) {
                          controllers[2].forward();
                        } else {
                          controllers[2].reverse();
                        }
                      },
                      child: Icon(
                        !expandedArea
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: weirdBlack50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                SizeTransition(
                  sizeFactor: animations[2],
                  child: Column(
                    children: [
                      SpecialForm(
                        controller: areaController,
                        width: 414.w,
                        height: 45.h,
                        hint: "Type Address",
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 170.h,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 40.h,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 20.w,
                          ),
                          itemCount: selectedLocations.length,
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () => setState(() =>
                                selectedLocations[index] = !selectedLocations[index]),
                            child: Container(
                              height: 40.h,
                              width: 105.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: selectedLocations[index]
                                          ? appBlue
                                          : fadedBorder,
                                  ),
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: selectedLocations[index] ? paleBlue : null),
                              child: Text(
                                ref.read(locationProvider)[index],
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: selectedLocations[index]
                                        ? appBlue
                                        : weirdBlack50,
                                    fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Price",
                      style: context.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => expandedPrice = !expandedPrice);
                        if (expandedPrice) {
                          controllers[3].forward();
                        } else {
                          controllers[3].reverse();
                        }
                      },
                      child: Icon(
                        !expandedPrice
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: weirdBlack50,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                SizeTransition(
                  sizeFactor: animations[3],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpecialForm(
                        controller: minController,
                        width: 120.w,
                        height: 40.h,
                        hint: "80,000",
                        type: TextInputType.number,
                      ),
                      Text(
                        "to",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: weirdBlack50, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: maxController,
                        width: 120.w,
                        height: 40.h,
                        hint: "100,000",
                        type: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: 414.w,
        height: 90.h,
        color: paleBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                selectedGenders = [false, false, false];
                selectedLevels = List.generate(8, (index) => false);
                selectedLocations =
                    List.generate(ref.read(locationProvider).length, (index) => false);
                areaController.clear();
                minController.clear();
                maxController.clear();
                unFocus();
                setState(() {});
              },
              child: Container(
                width: 180.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: appBlue, width: 1.5),
                ),
                child: Text(
                  "Reset",
                  style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: appBlue),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 180.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: appBlue,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  "Apply",
                  style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
