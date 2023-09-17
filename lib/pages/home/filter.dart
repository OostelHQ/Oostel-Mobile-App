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
    for (AnimationController controller in controllers) {
      controller.dispose();
    }
    super.dispose();
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
                          )
                        : _RoommateFilter(
                            controllers: controllers,
                            animations: animations,
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
                      onTap: () => context.router.pop(),
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
                          "Cancel",
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

  const _HostelFilter({
    super.key,
    required this.controllers,
    required this.animations,
  });

  @override
  ConsumerState<_HostelFilter> createState() => _HostelFilterState();
}

class _HostelFilterState extends ConsumerState<_HostelFilter> {
  late List<bool> selectedCategories, selectedLocations;
  bool expandedCategories = true, expandedArea = true, expandedPrice = true;
  final TextEditingController areaController = TextEditingController();
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    areaController.dispose();
    super.dispose();
  }

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
            IconButton(
              onPressed: () {
                setState(() => expandedCategories = !expandedCategories);
                if (expandedCategories) {
                  widget.controllers[0].forward();
                } else {
                  widget.controllers[0].reverse();
                }
              },
              icon: Icon(
                expandedCategories
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: weirdBlack50,
              ),
            )
          ],
        ),
        SizeTransition(
          sizeFactor: widget.animations[0],
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.w,
            children: List.generate(
              selectedCategories.length,
              (index) => GestureDetector(
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
        SizedBox(height: !expandedCategories ? 10.h : 28.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Area",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            IconButton(
              onPressed: () {
                setState(() => expandedArea = !expandedArea);
                if (expandedArea) {
                  widget.controllers[1].forward();
                } else {
                  widget.controllers[1].reverse();
                }
              },
              icon: Icon(
                expandedArea
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: weirdBlack50,
              ),
            )
          ],
        ),
        SizeTransition(
          sizeFactor: widget.animations[1],
          child: Column(
            children: [
              SpecialForm(
                controller: areaController,
                width: 414.w,
                height: 45.h,
                hint: "Type Address",
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.w,
                children: List.generate(
                  selectedLocations.length,
                  (index) => GestureDetector(
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
        SizedBox(height: !expandedArea ? 10.h : 28.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Price",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            IconButton(
              onPressed: () {
                setState(() => expandedPrice = !expandedPrice);
                if (expandedPrice) {
                  widget.controllers[2].forward();
                } else {
                  widget.controllers[2].reverse();
                }
              },
              icon: Icon(
                expandedPrice
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: weirdBlack50,
              ),
            )
          ],
        ),
        SizeTransition(
          sizeFactor: widget.animations[2],
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
        SizedBox(height: 150.h),
      ],
    );
  }
}

class _RoommateFilter extends ConsumerStatefulWidget {
  final List<AnimationController> controllers;
  final List<Animation<double>> animations;

  const _RoommateFilter({
    super.key,
    required this.controllers,
    required this.animations,
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
  final TextEditingController areaController = TextEditingController();
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  late List<String> levels;

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    areaController.dispose();
    super.dispose();
  }

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
            IconButton(
              onPressed: () {
                setState(() => expandedGenders = !expandedGenders);
                if (expandedGenders) {
                  widget.controllers[0].forward();
                } else {
                  widget.controllers[0].reverse();
                }
              },
              icon: Icon(
                expandedGenders
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: weirdBlack50,
              ),
            )
          ],
        ),
        SizeTransition(
          sizeFactor: widget.animations[0],
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.w,
            children: List.generate(
              selectedGenders.length,
              (index) => GestureDetector(
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
            ),
          ),
        ),
        SizedBox(height: !expandedGenders ? 10.h : 28.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Level",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            IconButton(
              onPressed: () {
                setState(() => expandedLevels = !expandedLevels);
                if (expandedLevels) {
                  widget.controllers[1].forward();
                } else {
                  widget.controllers[1].reverse();
                }
              },
              icon: Icon(
                expandedLevels
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: weirdBlack50,
              ),
            )
          ],
        ),
        SizeTransition(
          sizeFactor: widget.animations[1],
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.w,
            children: List.generate(
              selectedLevels.length,
              (index) => GestureDetector(
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
            ),
          ),
        ),
        SizedBox(height: !expandedLevels ? 10.h : 28.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Status",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            IconButton(
              onPressed: () {
                setState(() => expandedStatus = !expandedStatus);
                if (expandedStatus) {
                  widget.controllers[2].forward();
                } else {
                  widget.controllers[2].reverse();
                }
              },
              icon: Icon(
                expandedStatus
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: weirdBlack50,
              ),
            )
          ],
        ),
        SizeTransition(
          sizeFactor: widget.animations[2],
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.w,
            children: List.generate(
              selectedStatus.length,
              (index) => GestureDetector(
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
            ),
          ),
        ),
        SizedBox(height: !expandedStatus ? 10.h : 28.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Area",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            IconButton(
              onPressed: () {
                setState(() => expandedArea = !expandedArea);
                if (expandedArea) {
                  widget.controllers[3].forward();
                } else {
                  widget.controllers[3].reverse();
                }
              },
              icon: Icon(
                expandedArea
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: weirdBlack50,
              ),
            )
          ],
        ),
        SizeTransition(
          sizeFactor: widget.animations[3],
          child: Column(
            children: [
              SpecialForm(
                controller: areaController,
                width: 414.w,
                height: 45.h,
                hint: "Type Address",
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.w,
                children: List.generate(
                  selectedLocations.length,
                  (index) => GestureDetector(
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
        SizedBox(height: !expandedArea ? 10.h : 28.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Price",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            IconButton(
              onPressed: () {
                setState(() => expandedPrice = !expandedPrice);
                if (expandedPrice) {
                  widget.controllers[4].forward();
                } else {
                  widget.controllers[4].reverse();
                }
              },
              icon: Icon(
                expandedPrice
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: weirdBlack50,
              ),
            )
          ],
        ),
        SizeTransition(
          sizeFactor: widget.animations[4],
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
        SizedBox(height: 150.h),
      ],
    );
  }
}
