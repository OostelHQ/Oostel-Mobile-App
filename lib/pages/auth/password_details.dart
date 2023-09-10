import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 17.w),
                  child: IconButton(
                    iconSize: 26.r,
                    splashRadius: 20.r,
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: () => context.router.pop(),
                  ),
                ),
              ),
              SvgPicture.asset(
                "assets/images/single woman.svg",
                width: 220.r,
                height: 220.r,
              ),
              SizedBox(height: 12.h),
              Text(
                "Forgot Password",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700, color: weirdBlack),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  "Get started with any of your preferable account to be stress-free",
                  textAlign: TextAlign.center,
                  style:
                      context.textTheme.bodyMedium!.copyWith(color: weirdBlack),
                ),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: 414.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Address",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: weirdBlack),
                      ),
                      SpecialForm(
                        controller: emailController,
                        width: 414.w,
                        height: 50.h,
                        hintStyle: context.textTheme.bodyMedium!
                            .copyWith(color: fadedBorder),
                        hint: "example@example.com",
                        onValidate: (value) {
                          if (value!.trim().isEmpty || !value.contains("@")) {
                            showError("Invalid Email Address");
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 254.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(414.w, 50.h),
                          maximumSize: Size(414.w, 50.h),
                        ),
                        onPressed: () =>
                            context.router.pushNamed(Pages.resetPassword),
                        child: Text(
                          "Send",
                          style: context.textTheme.bodyLarge!.copyWith(
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
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 17.w),
                  child: IconButton(
                    iconSize: 26.r,
                    splashRadius: 20.r,
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: () => context.router.pop(),
                  ),
                ),
              ),
              SvgPicture.asset(
                "assets/images/single woman.svg",
                width: 220.r,
                height: 220.r,
              ),
              SizedBox(height: 12.h),
              Text(
                "Reset Password",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700, color: weirdBlack),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  "Get started with any of your preferable account to be stress-free",
                  textAlign: TextAlign.center,
                  style:
                      context.textTheme.bodyMedium!.copyWith(color: weirdBlack),
                ),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: 414.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Password",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: weirdBlack),
                      ),
                      SpecialForm(
                        controller: passwordController,
                        width: 414.w,
                        height: 50.h,
                        obscure: !showPassword,
                        suffix: AnimatedSwitcherTranslation.right(
                          duration: const Duration(milliseconds: 500),
                          child: !showPassword
                              ? GestureDetector(
                                  key: const ValueKey<bool>(false),
                                  child: Icon(
                                    Icons.visibility_outlined,
                                    size: 18.r,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    setState(() => showPassword = true);
                                  },
                                )
                              : GestureDetector(
                                  key: const ValueKey<bool>(true),
                                  child: Icon(
                                    Icons.visibility_off_outlined,
                                    size: 18.r,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    setState(() => showPassword = false);
                                  },
                                ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Password",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: weirdBlack),
                      ),
                      SpecialForm(
                        controller: confirmController,
                        width: 414.w,
                        height: 50.h,
                        obscure: !showConfirmPassword,
                        suffix: AnimatedSwitcherTranslation.right(
                          duration: const Duration(milliseconds: 500),
                          child: !showConfirmPassword
                              ? GestureDetector(
                                  key: const ValueKey<bool>(false),
                                  child: Icon(
                                    Icons.visibility_outlined,
                                    size: 18.r,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    setState(() => showConfirmPassword = true);
                                  },
                                )
                              : GestureDetector(
                                  key: const ValueKey<bool>(true),
                                  child: Icon(
                                    Icons.visibility_off_outlined,
                                    size: 18.r,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    setState(() => showConfirmPassword = false);
                                  },
                                ),
                        ),
                      ),
                      SizedBox(height: 164.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(414.w, 50.h),
                          maximumSize: Size(414.w, 50.h),
                        ),
                        onPressed: () =>
                            context.router.pushNamed(Pages.resetPassword),
                        child: Text(
                          "Confirm",
                          style: context.textTheme.bodyLarge!.copyWith(
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
            ],
          ),
        ),
      ),
    );
  }
}

class AccountVerificationPage extends StatefulWidget {
  final String email;

  const AccountVerificationPage({
    super.key,
    this.email = "johndoe@mail.com",
  });

  @override
  State<AccountVerificationPage> createState() =>
      _AccountVerificationPageState();
}

class _AccountVerificationPageState extends State<AccountVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 160.h),
            SvgPicture.asset(
              "assets/images/single woman.svg",
              width: 220.r,
              height: 220.r,
            ),
            SizedBox(height: 12.h),
            Text(
              "Email Verification",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700, color: weirdBlack),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                "An account activation link has been sent to the e-mail address ${widget.email}",
                textAlign: TextAlign.center,
                style:
                    context.textTheme.bodyMedium!.copyWith(color: weirdBlack),
              ),
            ),
            SizedBox(height: 196.h),
            Text(
              "Didn't get an email?",
              style: context.textTheme.bodySmall!.copyWith(color: weirdBlack),
            ),
            SizedBox(height: 48.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appBlue,
                  minimumSize: Size(414.w, 50.h),
                  maximumSize: Size(414.w, 50.h),
                ),
                onPressed: () => context.router.pushNamed(Pages.resetPassword),
                child: Text(
                  "Proceed",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 48.h),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Didn't get an email?",
                style: context.textTheme.bodySmall!.copyWith(color: appBlue),
              ),
            ),
            SizedBox(height: 48.h),
            const Center(child: Copyright()),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
