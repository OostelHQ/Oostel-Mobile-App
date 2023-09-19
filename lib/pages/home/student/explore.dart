import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => ExplorePageState();
}

class ExplorePageState extends ConsumerState<ExplorePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<HostelInfo> hostels = ref.watch(availableHostelsProvider);
    List<Student> roommates = ref.watch(availableRoommatesProvider);
    List<String> roomTypes = ref.watch(roomTypesProvider);

    return CustomScrollView(
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
                  width: 414.w,
                  height: 50.h,
                  fillColor: Colors.white,
                  hint: "Search here...",
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "All Room Categories",
                      child: Text("Categories",
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600, color: weirdBlack)),
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
                    itemCount: 3,
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
                  height: 260.h,
                  width: 414.w,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {},
                      child: HostelExploreCard(
                        info: hostels[index],
                      ),
                    ),
                    separatorBuilder: (_, __) => SizedBox(width: 5.w),
                    itemCount: 2,
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
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => Column(
                children: [
                  StudentCard(info: roommates[index]),
                  SizedBox(height: 10.h)
                ],
              ),
              childCount: 2,
            ),
          ),
        )
      ],
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
