import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController controller, loaderController;
  late Animation<double> logoAnimation, textAnimation, loadAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(milliseconds: 1500),
    );

    loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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

    loadAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut),
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => controller.forward().then(
        (_) async {
          bool? hasRegistered = await FileManager.loadBool("registeredFynda");
          bool? autoLogin = await FileManager.loadBool("autoLogin");
          Map<String, String>? auth = await FileManager.loadAuthDetails();

          if (auth != null && autoLogin != null && autoLogin) {
            loaderController.forward();
            loginUser(auth).then((response) {
              showError(response.message);
              loaderController.reverse().then((_) {
                if (response.success) {
                  FileManager.saveBool("registeredFynda", true);
                  ref.watch(hasInitializedProvider.notifier).state = true;
                  ref.watch(currentUserProvider.notifier).state =
                      response.payload!;
                }
                process(hasRegistered, autoLogin);
              });
            });
          } else {
            process(hasRegistered, autoLogin);
          }
        },
      ),
    );
  }

  void process(bool? hasRegistered, bool? autoLogin) =>
      controller.reverse().then(
        (_) {
          String destination = "";
          if (hasRegistered == null || !hasRegistered) {
            destination = Pages.registrationType;
          } else if (ref.watch(hasInitializedProvider)) {
            destination = ref.watch(isAStudent)
                ? Pages.studentDashboard
                : ref.watch(isLandlord)
                    ? Pages.ownerDashboard
                    : ref.watch(isAgent)
                        ? Pages.agentDashboard
                        : Pages.login;
          } else if (autoLogin != null && !autoLogin) {
            destination = Pages.login;
          }

          context.router.pushReplacementNamed(destination);
        },
      );

  @override
  void dispose() {
    loaderController.dispose();
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
              SizedBox(height: 80.h),
              FadeTransition(
                opacity: loadAnimation,
                child: loader,
              ),
              SizedBox(height: 200.h),
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
