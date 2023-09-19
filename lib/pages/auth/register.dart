import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;
  bool readTerms = false;

  final Map<String, dynamic> authDetails = {
    "email": "",
    "password": "",
    "firstName": "",
    "lastName": ""
  };

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
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
                "assets/images/user transact.svg",
                width: 220.r,
                height: 220.r,
              ),
              SizedBox(height: 12.h),
              Text(
                "Create Account",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  "Tap to create a profile",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
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
                        "First Name",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: firstNameController,
                        width: 414.w,
                        height: 50.h,
                        hintStyle: context.textTheme.bodyMedium!
                            .copyWith(color: fadedBorder),
                        hint: "Surname",
                        onSave: (val) =>
                            setState(() => authDetails["firstName"] = val!),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Last Name",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: lastNameController,
                        width: 414.w,
                        height: 50.h,
                        hintStyle: context.textTheme.bodyMedium!
                            .copyWith(color: fadedBorder),
                        hint: "Other Name",
                        onSave: (val) =>
                            setState(() => authDetails["lastName"] = val!),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Email Address",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
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
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Password",
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      SpecialForm(
                        controller: passwordController,
                        width: 414.w,
                        height: 50.h,
                        obscure: !showPassword,
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
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: readTerms,
                            onChanged: (val) =>
                                setState(() => readTerms = !readTerms),
                          ),
                          Wrap(
                            children: [
                              Text(
                                "I agree to Oostel's",
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: () => context.router.pushNamed(Pages.privacyPolicy),
                                child: Text(
                                  " Privacy Policies",
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(
                                          color: appBlue,
                                          fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 36.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBlue,
                          minimumSize: Size(414.w, 50.h),
                          maximumSize: Size(414.w, 50.h),
                        ),
                        onPressed: () => context.router.pushNamed(ref.read(isAStudent)
                            ? Pages.studentDashboard
                            : Pages.ownerDashboard,
                        ),
                        child: Text(
                          "Create Account",
                          style: context.textTheme.bodyMedium!.copyWith(
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
                              "Already have an account?",
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () => context.router
                                  .pushReplacementNamed(Pages.login),
                              child: Text(
                                " Login",
                                style: context.textTheme.bodyMedium!.copyWith(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
