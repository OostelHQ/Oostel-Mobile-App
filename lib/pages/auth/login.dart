import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;
  bool remember = false;

  final Map<String, dynamic> authDetails = {
    "email": "",
    "password": "",
  };

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25.h),
              SvgPicture.asset(
                "assets/images/single woman.svg",
                width: 220.r,
                height: 220.r,
              ),
              SizedBox(height: 12.h),
              Text(
                "Welcome Back!",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  "Get started with any of your preferable account to be stress-free",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
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
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: emailController,
                        width: 414.w,
                        height: 50.h,
                        hintStyle: context.textTheme.bodyMedium!
                            .copyWith(color: fadedBorder),
                        hint: "example@example.com",
                        onChange: (text) => setState(() {}),
                        onSave: (val) =>
                            setState(() => authDetails["email"] = val!),
                        onValidate: (value) {
                          if (value!.trim().isEmpty || !value.contains("@")) {
                            showError("Invalid Email Address");
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Password",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: passwordController,
                        width: 414.w,
                        height: 50.h,
                        obscure: !showPassword,
                        onChange: (text) => setState(() {}),
                        onSave: (val) =>
                            setState(() => authDetails["password"] = val!),
                        suffix: GestureDetector(
                          onTap: () =>
                              setState(() => showPassword = !showPassword),
                          child: AnimatedSwitcherTranslation.right(
                            duration: const Duration(milliseconds: 500),
                            child: Icon(
                              showPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              key: ValueKey<bool>(showPassword),
                              size: 18.r,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: remember,
                                  activeColor: appBlue,
                                  onChanged: (val) =>
                                      setState(() => remember = !remember),
                                ),
                                Text(
                                  "Remember Me",
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      color: weirdBlack75,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                context.router.pushNamed(Pages.forgotPassword),
                            child: Text(
                              "Forgot Password",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: appBlue, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 140.h),
                      GestureDetector(
                        onTap: () {
                          if(!remember || (emailController.text.isEmpty || passwordController.text.isEmpty)) return;
                          context.router.pushReplacementNamed(
                            ref.read(isAStudent)
                                ? Pages.studentDashboard
                                : Pages.ownerDashboard,
                          );
                        },
                        child: Container(
                          width: 414.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: !remember || emailController.text.isEmpty || passwordController.text.isEmpty ? appBlue.withOpacity(0.4) : appBlue,
                          ),
                          child: Text(
                            "Login",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              "Don't have an account yet?",
                              style: context.textTheme.bodyMedium!.copyWith(
                                  color: weirdBlack75,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () => context.router
                                  .pushReplacementNamed(Pages.register),
                              child: Text(
                                " Create Account",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: appBlue,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
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
