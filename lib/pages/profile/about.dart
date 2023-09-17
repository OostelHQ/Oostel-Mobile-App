import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "About",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  loremIpsum,
                  style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: weirdBlack75),
                ),
                SizedBox(height: 120.h),
                ElevatedButton(
                  onPressed: () => context.router.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBlue,
                    minimumSize: Size(414.w, 50.h),
                    maximumSize: Size(414.w, 50.h),
                  ),
                  child: Text(
                    "Done",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
                const Center(child: Copyright()),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
