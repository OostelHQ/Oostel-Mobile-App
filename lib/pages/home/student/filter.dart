import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class FilterPage extends ConsumerStatefulWidget {
  final bool hostel;

  const FilterPage({
    super.key,
    required this.hostel,
  });

  @override
  ConsumerState<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPage>
    with TickerProviderStateMixin {
  final List<AnimationController> controllers = [];
  final List<Animation<double>> animations = [];

  final TextEditingController areaController = TextEditingController();
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    int count = widget.hostel ? 3 : 5;
    for (int i = 0; i < count; ++i) {
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
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    areaController.dispose();
    for (AnimationController controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void reset() {
    areaController.clear();
    minController.clear();
    maxController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    widget.hostel
                        ? _HostelFilter(
                            controllers: controllers,
                            animations: animations,
                            areaController: areaController,
                            maxController: maxController,
                            minController: minController,
                          )
                        : _RoommateFilter(
                            controllers: controllers,
                            animations: animations,
                            areaController: areaController,
                            maxController: maxController,
                            minController: minController,
                          ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 414.w,
                height: 90.h,
                color: paleBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: reset,
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
            )
          ],
        ),
      ),
    );
  }
}

class _HostelFilter extends ConsumerStatefulWidget {
  final List<AnimationController> controllers;
  final List<Animation<double>> animations;
  final TextEditingController areaController;
  final TextEditingController minController;
  final TextEditingController maxController;

  const _HostelFilter({
    super.key,
    required this.controllers,
    required this.animations,
    required this.areaController,
    required this.minController,
    required this.maxController,
  });

  @override
  ConsumerState<_HostelFilter> createState() => _HostelFilterState();
}

class _HostelFilterState extends ConsumerState<_HostelFilter> {
  late List<bool> selectedCategories, selectedLocations;
  bool expandedCategories = true, expandedArea = true, expandedPrice = true;

  @override
  void initState() {
    super.initState();
    selectedCategories =
        List.generate(ref.read(roomTypesProvider).length, (index) => false);
    selectedLocations =
        List.generate(ref.read(locationProvider).length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Categories",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            GestureDetector(
              onTap: () {
                setState(() => expandedCategories = !expandedCategories);
                if (expandedCategories) {
                  widget.controllers[0].forward();
                } else {
                  widget.controllers[0].reverse();
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
          sizeFactor: widget.animations[0],
          child: SizedBox(
            height: 170.h,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 40.h,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 20.w,
              ),
              itemCount: selectedCategories.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () => setState(() =>
                    selectedCategories[index] = !selectedCategories[index]),
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
                      color: selectedCategories[index] ? paleBlue : null),
                  child: Text(
                    ref.read(roomTypesProvider)[index],
                    style: context.textTheme.bodyMedium!.copyWith(
                        color:
                            selectedCategories[index] ? appBlue : weirdBlack50,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
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
                  widget.controllers[1].forward();
                } else {
                  widget.controllers[1].reverse();
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
          sizeFactor: widget.animations[1],
          child: Column(
            children: [
              SpecialForm(
                controller: widget.areaController,
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
                      crossAxisSpacing: 20.w),
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
                                  : fadedBorder),
                          borderRadius: BorderRadius.circular(5.r),
                          color: selectedLocations[index] ? paleBlue : null),
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
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            GestureDetector(
              onTap: () {
                setState(() => expandedPrice = !expandedPrice);
                if (expandedPrice) {
                  widget.controllers[2].forward();
                } else {
                  widget.controllers[2].reverse();
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
          sizeFactor: widget.animations[2],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpecialForm(
                controller: widget.minController,
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
                controller: widget.maxController,
                width: 120.w,
                height: 40.h,
                hint: "100,000",
                type: TextInputType.number,
              ),
            ],
          ),
        ),
        SizedBox(height: 150.h),
      ],
    );
  }
}

class _RoommateFilter extends ConsumerStatefulWidget {
  final List<AnimationController> controllers;
  final List<Animation<double>> animations;
  final TextEditingController areaController;
  final TextEditingController minController;
  final TextEditingController maxController;

  const _RoommateFilter({
    super.key,
    required this.controllers,
    required this.animations,
    required this.areaController,
    required this.maxController,
    required this.minController,
  });

  @override
  ConsumerState<_RoommateFilter> createState() => _RoommateFilterState();
}

class _RoommateFilterState extends ConsumerState<_RoommateFilter> {
  late List<bool> selectedGenders,
      selectedLevels,
      selectedStatus,
      selectedLocations;
  bool expandedGenders = true,
      expandedLevels = true,
      expandedStatus = true,
      expandedArea = true,
      expandedPrice = true;

  late List<String> levels;

  @override
  void initState() {
    super.initState();
    selectedStatus = [false, false];
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
    return Column(
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
                  widget.controllers[0].forward();
                } else {
                  widget.controllers[0].reverse();
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
          sizeFactor: widget.animations[0],
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
                  widget.controllers[1].forward();
                } else {
                  widget.controllers[1].reverse();
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
          sizeFactor: widget.animations[1],
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
              "Status",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            GestureDetector(
              onTap: () {
                setState(() => expandedStatus = !expandedStatus);
                if (expandedStatus) {
                  widget.controllers[2].forward();
                } else {
                  widget.controllers[2].reverse();
                }
              },
              child: Icon(
                !expandedStatus
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: weirdBlack50,
              ),
            )
          ],
        ),
        SizedBox(height: 12.h),
        SizeTransition(
          sizeFactor: widget.animations[2],
          child: SizedBox(
            height: 55.h,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 40.h,
                mainAxisSpacing: 20.h,
                crossAxisSpacing: 20.w,
              ),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () => setState(
                  () {
                    if (index == 0) {
                      selectedStatus[0] = true;
                      selectedStatus[1] = false;
                    } else {
                      selectedStatus[0] = false;
                      selectedStatus[1] = true;
                    }
                  },
                ),
                child: Container(
                  height: 40.h,
                  width: 115.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedStatus[index] ? appBlue : fadedBorder),
                      borderRadius: BorderRadius.circular(5.r),
                      color: selectedStatus[index] ? paleBlue : null),
                  child: Text(
                    (index == 0 ? "Gotten Hostel" : "No Hostel"),
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: selectedStatus[index] ? appBlue : weirdBlack50,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              itemCount: 2,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        if (selectedStatus[0])
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
                    widget.controllers[3].forward();
                  } else {
                    widget.controllers[3].reverse();
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
        if (selectedStatus[0]) SizedBox(height: 12.h),
        if (selectedStatus[0])
          SizeTransition(
            sizeFactor: widget.animations[3],
            child: Column(
              children: [
                SpecialForm(
                  controller: widget.areaController,
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
                                    : fadedBorder),
                            borderRadius: BorderRadius.circular(5.r),
                            color: selectedLocations[index] ? paleBlue : null),
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
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            GestureDetector(
              onTap: () {
                setState(() => expandedPrice = !expandedPrice);
                if (expandedPrice) {
                  widget.controllers[4].forward();
                } else {
                  widget.controllers[4].reverse();
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
          sizeFactor: widget.animations[4],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpecialForm(
                controller: widget.minController,
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
                controller: widget.maxController,
                width: 120.w,
                height: 40.h,
                hint: "100,000",
                type: TextInputType.number,
              ),
            ],
          ),
        ),
        SizedBox(height: 150.h),
      ],
    );
  }
}
