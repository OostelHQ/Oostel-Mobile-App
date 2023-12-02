import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hostel/api/hostel_service.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => ExplorePageState();
}

class ExplorePageState extends ConsumerState<ExplorePage> {
  final TextEditingController controller = TextEditingController();
  bool loadingHostel = true, loadingRoommates = true;

  late List<HostelInfo> dummyHostels;
  late List<Student> dummyStudents;

  @override
  void initState() {
    super.initState();
    dummyHostels = List.generate(
      4,
      (index) => HostelInfo(
        owner: defaultOwner,
        name: "Dummy Hostel",
        bathrooms: 1,
        bedrooms: 3,
        area: 2034.55,
        price: 109808.0,
      ),
    );
    dummyStudents = List.generate(4, (index) => defaultStudent);
    refresh();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void refresh() {
    refreshHostel();
    refreshRoommates();
  }

  void refreshHostel() {
    getAllHostels({}).then((resp) {
      if (resp.payload.isEmpty) {
        showError(resp.message);
        setState(() => loadingHostel = false);
      }

      ref.watch(availableHostelsProvider.notifier).state.clear();
      ref.watch(availableHostelsProvider.notifier).state.addAll(resp.payload);
    });
  }

  void refreshRoommates() {
    getAvailableRoommates().then((resp) {
      if (resp.payload.isEmpty) {
        showError(resp.message);
        setState(() => loadingRoommates = false);
      }

      ref.watch(availableRoommatesProvider.notifier).state.clear();
      ref.watch(availableRoommatesProvider.notifier).state.addAll(resp.payload);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<HostelInfo> hostels = ref.watch(availableHostelsProvider);
    List<Student> roommates = ref.watch(availableRoommatesProvider);

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => loadingHostel = loadingRoommates = true);
        refresh();
      },
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h),
                  Text("Explore",
                      style: context.textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 8.h),
                  Text(
                      "Explore the variety of options provided to select your choice.",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: weirdBlack75, fontWeight: FontWeight.w500)),
                  SizedBox(height: 12.h),
                  SpecialForm(
                    controller: controller,
                    height: 50.h,
                    width: 414.w,
                    hint: "Search here...",
                    prefix:
                        const Icon(Icons.search_rounded, color: weirdBlack25),
                    borderColor: Colors.transparent,
                    fillColor: Colors.white,
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
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: "All Room Categories",
                        child: Text("Categories",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: weirdBlack)),
                      ),
                      GestureDetector(
                        onTap: () => context.pushNamed(Pages.viewRoomTypes),
                        child: Text(
                          "See All",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 110.r,
                    width: 414.w,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => RoomTypeCard(index: index),
                      separatorBuilder: (_, __) => SizedBox(width: 20.w),
                      itemCount: 5,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Hostels",
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      GestureDetector(
                        onTap: () => context.router
                            .pushNamed(Pages.viewAvailable, extra: true),
                        child: Text(
                          "See All",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                      height: 270.h,
                      width: 414.w,
                      child: loadingHostel
                        ?
                          Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: dummyHostels.length,
                          itemBuilder: (_, index) =>
                              HostelExploreCard(info: dummyHostels[index]),
                          separatorBuilder: (_, __) => SizedBox(width: 20.w),
                        ),
                      )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 750),
                            child: SlideAnimation(
                              horizontalOffset: 25.w,
                              child: FadeInAnimation(
                                child:
                                HostelExploreCard(info: hostels[index]),
                              ),
                            ),
                          ),
                          separatorBuilder: (_, __) => SizedBox(width: 20.w),
                          itemCount: hostels.length < 4 ? hostels.length : 4,
                        ),
                      ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Roommates",
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      GestureDetector(
                        onTap: () => context.router
                            .pushNamed(Pages.viewAvailable, extra: false),
                        child: Text(
                          "See All",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: appBlue, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList.separated(
              separatorBuilder: (_, __) => SizedBox(height: 20.h),
              itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 750),
                child: SlideAnimation(
                  horizontalOffset: 25.w,
                  child: FadeInAnimation(
                    child: StudentCard(info: roommates[index]),
                  ),
                ),
              ),
              itemCount: roommates.length < 4 ? roommates.length : 4,
            ),
          )
        ],
      ),
    );
  }
}

class RoomTypesPage extends ConsumerStatefulWidget {
  const RoomTypesPage({super.key});

  @override
  ConsumerState<RoomTypesPage> createState() => _RoomTypesPageState();
}

class _RoomTypesPageState extends ConsumerState<RoomTypesPage> {
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
        title: Hero(
          tag: "All Room Categories",
          flightShuttleBuilder: flightShuttleBuilder,
          child: Text(
            "Categories",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: DropdownButton<String>(
              items: const [],
              onChanged: (String? value) {},
              icon: Icon(
                Icons.more_vert_rounded,
                size: 26.r,
                color: weirdBlack50,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.w,
              mainAxisExtent: 110.r,
            ),
            itemBuilder: (_, index) => RoomTypeCard(index: index),
            itemCount: ref.read(roomTypesProvider).length,
          ),
        ),
      ),
    );
  }
}
