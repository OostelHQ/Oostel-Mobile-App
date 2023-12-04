import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class ViewAvailablePage extends ConsumerStatefulWidget {
  final bool hostel;

  const ViewAvailablePage({
    super.key,
    required this.hostel,
  });

  @override
  ConsumerState<ViewAvailablePage> createState() => _ViewAvailablePageState();
}

class _ViewAvailablePageState extends ConsumerState<ViewAvailablePage> {
  List<dynamic> acquireList = [];

  late bool isHostel;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    isHostel = widget.hostel;
    acquireList = widget.hostel
        ? ref.read(availableHostelsProvider)
        : ref.read(availableRoommatesProvider);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
          "Explore",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeSwitcher(
                useDefault: true,
                initialHostel: isHostel,
                onHostelDisplayed: () => setState(() {
                  acquireList = ref.watch(availableHostelsProvider);
                  isHostel = true;
                }),
                onRoommateDisplayed: () => setState(() {
                  acquireList = ref.watch(availableRoommatesProvider);
                  isHostel = false;
                }),
              ),
              SizedBox(height: 12.h),
              SpecialForm(
                controller: controller,
                width: 414.w,
                height: 50.h,
                hint: "Search ${widget.hostel ? "Hostel" : "Roommate"}...",
                prefix: SizedBox(
                  height: 50.h,
                  width: 30.w,
                  child: const Center(
                    child: Icon(Boxicons.bx_search, color: weirdBlack20),
                  ),
                ),
                suffix: GestureDetector(
                  onTap: () {
                    unFocus();
                    context.router.pushNamed(Pages.filter, extra: isHostel);
                  },
                  child: SizedBox(
                    height: 50.h,
                    width: 30.w,
                    child: const Center(
                      child: Icon(Boxicons.bx_filter, color: weirdBlack20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: isHostel
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.r,
                          crossAxisSpacing: 15.r,
                          mainAxisExtent: 260.h,
                        ),
                        itemBuilder: (_, index) =>
                            HostelExploreCard(info: acquireList[index]),
                        itemCount: acquireList.length,
                      )
                    : ListView.separated(
                        itemBuilder: (_, index) =>
                            StudentCard(info: acquireList[index]),
                        separatorBuilder: (_, __) => const SizedBox(),
                        itemCount: acquireList.length,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
