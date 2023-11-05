import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hostel/misc/constants.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> logoAnimation, textAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 1),
    );

    logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.3,
          curve: Curves.bounceOut,
        ),
        reverseCurve: Curves.easeOut,
      ),
    );

    textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.2,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => controller.forward().then(
            (value) => controller.reverse().then(
                  (value) => context.router
                      .pushReplacementNamed(Pages.registrationType),
                ),
          ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlue,
      body: SafeArea(
        child: SizedBox(
          width: 414.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 305.h),
              ScaleTransition(
                scale: logoAnimation,
                child: Image.asset("assets/images/oostel.png",
                    width: 120.r, height: 120.r),
              ),
              FadeTransition(
                opacity: textAnimation,
                child: Text(
                  "Fynda",
                  style: context.textTheme.headlineLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 335.h),
              FadeTransition(
                opacity: textAnimation,
                child: Text(
                  "Version 1.0",
                  style: context.textTheme.bodySmall!
                      .copyWith(color: Colors.white.withOpacity(0.6)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
