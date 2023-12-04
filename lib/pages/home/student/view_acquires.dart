import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/misc/providers.dart';

class ViewAcquiresPage extends ConsumerStatefulWidget {
  final bool hostel;

  const ViewAcquiresPage({
    super.key,
    required this.hostel,
  });

  @override
  ConsumerState<ViewAcquiresPage> createState() => _ViewAcquiresPageState();
}

class _ViewAcquiresPageState extends ConsumerState<ViewAcquiresPage> {
  late bool isHostel;
  List<dynamic> acquireList = [];

  @override
  void initState() {
    super.initState();
    isHostel = widget.hostel;
    acquireList = widget.hostel
        ? ref.read(acquiredHostelsProvider)
        : ref.read(acquiredRoommatesProvider);
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
          onPressed: () => context.router.pop(isHostel),
        ),
        centerTitle: true,
        title: Hero(
          tag: "My Acquires Header",
          flightShuttleBuilder: flightShuttleBuilder,
          child: Text(
            "My Acquires",
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
              Hero(
                tag: "Home Switcher",
                flightShuttleBuilder: flightShuttleBuilder,
                child: HomeSwitcher(
                  initialHostel: isHostel,
                  onHostelDisplayed: () => setState(() {
                    acquireList = ref.watch(acquiredHostelsProvider);
                    isHostel = true;
                  }),
                  onRoommateDisplayed: () => setState(() {
                    acquireList = ref.watch(acquiredRoommatesProvider);
                    isHostel = false;
                  }),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    dynamic element = acquireList[index];
                    if (element is HostelInfo) {
                      return HostelInfoCard(info: element);
                    } else {
                      return StudentCard(info: element);
                    }
                  },
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
