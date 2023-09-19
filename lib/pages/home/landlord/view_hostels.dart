import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/landlord_widgets.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class ViewHostelsPage extends ConsumerStatefulWidget {
  const ViewHostelsPage({super.key});

  @override
  ConsumerState<ViewHostelsPage> createState() => _ViewHostelsPageState();
}

class _ViewHostelsPageState extends ConsumerState<ViewHostelsPage> {
  List<HostelInfo> acquireList = [];

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    acquireList = ref.read(ownerHostelsProvider);
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
        elevation: 0.0,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 20.r,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
        centerTitle: true,
        title: Hero(
          tag: "My Hostels Header",
          flightShuttleBuilder: flightShuttleBuilder,
          child: Text(
            "My Hostels",
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpecialForm(
                controller: controller,
                width: 414.w,
                height: 50.h,
                hint: "Search Hostels ...",
                prefix: SizedBox(
                  height: 50.h,
                  width: 30.w,
                  child: const Center(
                    child: Icon(Boxicons.bx_search, color: weirdBlack20),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    if (index == acquireList.length) {
                      return Column(
                        children: [
                          SizedBox(height: 48.h),
                          const Center(child: Copyright()),
                          SizedBox(height: 24.h),
                        ],
                      );
                    }

                    return LandlordHostelCard(info: acquireList[index]);
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 20.h),
                  itemCount: acquireList.length + 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
