import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                "Welcome Back!",
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
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: weirdBlack),
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
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: weirdBlack),
                      ),
                      SpecialForm(
                        controller: passwordController,
                        width: 414.w,
                        height: 50.h,
                        obscure: !showPassword,
                        onSave: (val) =>
                            setState(() => authDetails["password"] = val!),
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
                      //SizedBox(height: 16.h),
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
                                  onChanged: (val) =>
                                      setState(() => remember = !remember),
                                ),
                                Text(
                                  "Remember Me",
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(color: weirdBlack),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.router
                                .pushNamed(Pages.forgotPassword),
                            child: Text(
                              "Forgot Password",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  color: appBlue,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 36.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(414.w, 50.h),
                          maximumSize: Size(414.w, 50.h),
                        ),
                        onPressed: () => context.router.pushNamed(Pages.dashboard),
                        child: Text(
                          "Login",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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
                              style: context.textTheme.bodyLarge!
                                  .copyWith(color: weirdBlack),
                            ),
                            GestureDetector(
                              onTap: () => context.router
                                  .pushReplacementNamed(Pages.register),
                              child: Text(
                                " Create Account",
                                style: context.textTheme.bodyLarge!.copyWith(
                                    color: appBlue,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
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
