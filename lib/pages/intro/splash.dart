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
        reverseCurve: Curves.easeOut,
      ),
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => controller.forward().then(
        (_) async {
          int? registerStep = await FileManager.loadInt("registerStep");
          bool? autoLogin = await FileManager.loadBool("autoLogin");
          String? registeredEmail = await FileManager.load("registrationEmail");

          Map<String, String>? auth = await FileManager.loadAuthDetails();

          if (registerStep != null && registerStep != 0) {
            ref.watch(registrationProcessProvider.notifier).state =
                registerStep;
            process(
                registerStep: registerStep, registeredEmail: registeredEmail);
          } else if (auth != null && autoLogin != null && autoLogin) {
            loaderController.forward();
            loginUser(auth).then((response) {
              showError(response.message,
                  background: Colors.white, text: weirdBlack);
              loaderController.reverse().then((_) {
                if (response.success) {
                  FileManager.save("registrationEmail", "");
                  FileManager.saveInt("registerStep", 0);
                  ref.invalidate(registrationProcessProvider);
                  ref.watch(hasInitializedProvider.notifier).state = true;
                  ref.watch(currentUserProvider.notifier).state =
                      response.payload!;
                }

                process(loginSuccess: response.success);
              });
            });
          } else {
            process();
          }
        },
      ),
    );
  }

  void process(
          {int? registerStep, String? registeredEmail, bool? loginSuccess}) =>
      controller.reverse().then(
        (_) {
          String destination = Pages.login;
          if (loginSuccess != null && loginSuccess) {
            if(ref.read(isLandlord)) {
              int value = ref.read(currentUserProvider).hasCompletedProfile;
              if (value <= 20) {
                destination = Pages.createStepOne;
              } else {
                destination = Pages.ownerDashboard;
              }
            } else if(ref.read(isAgent)) {
              destination = Pages.agentDashboard;
            } else {
              destination = Pages.studentDashboard;
            }
          } else if (registeredEmail != null && registeredEmail.isNotEmpty && registerStep != null) {
            destination = Pages.register;
            ref.watch(otpOriginProvider.notifier).state = OtpOrigin.register;
          } else if (registerStep == null && registeredEmail == null) {
            destination = Pages.registrationType;
          }

          context.router
              .pushReplacementNamed(destination, extra: registeredEmail);
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
