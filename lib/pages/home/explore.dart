import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/roommate_info.dart';
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
    List<HostelInfo> hostels = ref.watch(hostelsProvider);
    List<RoommateInfo> roommates = ref.watch(roommatesProvider);

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
                        .copyWith(fontWeight: FontWeight.w700)),
                SizedBox(height: 8.h),
                Text("Find the best and your desired hostel",
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: weirdBlack)),
                SizedBox(height: 12.h),
                SpecialForm(
                  controller: controller,
                  width: 414.w,
                  height: 40.h,
                  fillColor: Colors.white,
                  hint: "Search here...",
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categories",
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w600)),
                    GestureDetector(
                      onTap: () {},
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
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 110.r,
                        width: 110.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: paleBlue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 55.r,
                              width: 90.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            Text(
                              "Self Contained",
                              style: context.textTheme.bodySmall!.copyWith(
                                  color: weirdBlack,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
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
                      style: context.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {},
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
                    separatorBuilder: (_, __) => SizedBox(width: 20.w),
                    itemCount: 3,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Available Roommates",
                      style: context.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {},
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => Column(
              children: [
                RoommateInfoCard(info: roommates[index]),
                SizedBox(height: 10.h)
              ],
            ),
            childCount: roommates.length,
          ),
        )
      ],
    );
  }
}