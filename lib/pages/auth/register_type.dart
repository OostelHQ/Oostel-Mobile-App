import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';

class RegistrationTypePage extends StatefulWidget {
  const RegistrationTypePage({super.key});

  @override
  State<RegistrationTypePage> createState() => _RegistrationTypePageState();
}

class _RegistrationTypePageState extends State<RegistrationTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 70.h),
            Image.asset(
              "assets/images/search houses.png",
              width: 283.r,
              height: 283.r,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 5.h),
            Text(
              "Get Started",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                "Select your preferred category",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium!.copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () => context.router.pushReplacementNamed(Pages.register),
                child: Card(
                  elevation: 1.0,
                  color: Colors.white,
                  child: SizedBox(
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          "assets/images/student.svg",
                          width: 60.r,
                          height: 60.r,
                        ),
                        Text(
                          "I am a Student",
                          style: context.textTheme.bodyLarge!
                              .copyWith(color: weirdBlack, fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 26.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () => context.router.pushReplacementNamed(Pages.register),
                child: Card(
                  elevation: 1.0,
                  color: Colors.white,
                  child: SizedBox(
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          "assets/images/landlord.svg",
                          width: 60.r,
                          height: 60.r,
                        ),
                        Text(
                          "I am a Landowner",
                          style: context.textTheme.bodyLarge!
                              .copyWith(color: weirdBlack, fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 26.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 48.h),
            const Copyright(),
          ],
        ),
      ),
    );
  }
}
