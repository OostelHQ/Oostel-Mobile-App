import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                height: 50.h,
                width: 414.w,
                hint: "Search Hostels...",
                prefix: const Icon(Icons.search_rounded, color: weirdBlack25),
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
                    ]
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    if (index == acquireList.length) {
                      return SizedBox(height: 48.h);
                    }

                    return LandlordHostelCard(info: acquireList[index]);
                  },
                  separatorBuilder: (_, __) => const SizedBox(),
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
