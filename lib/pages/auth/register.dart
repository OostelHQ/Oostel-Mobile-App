import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/functions.dart';
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
  final TextEditingController referralController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool showPassword = false;
  bool readTerms = false;

  late Map<String, dynamic> authDetails;

  @override
  void initState() {
    super.initState();
    authDetails = {
      "emailAddress": "",
      "password": "",
      "firstName": "",
      "lastName": "",
      "roletype": "",
    };

    if(ref.read(isAgent)) {
      authDetails["referralCode"] = "";
    }

    Future.delayed(const Duration(milliseconds: 750), () {
      if(ref.read(registrationProcessProvider) == 1) {
        context.router.pushNamed(Pages.accountVerification);
      }
    });
  }

  @override
  void dispose() {
    referralController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void navigate() {
    FileManager.saveInt("registerStep", 1);
    FileManager.save("registrationEmail", authDetails["emailAddress"]);
    ref.watch(otpOriginProvider.notifier).state = OtpOrigin.register;
    context.router.pushReplacementNamed(Pages.accountVerification,
        extra: authDetails["emailAddress"]);
  }

  Future<void> register() async {
    registerUser(authDetails).then((resp) {
      if (!mounted) return;
      showError(resp.message);
      if (!resp.success) {
        Navigator.of(context).pop();
      } else {
        navigate();
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: loader,
      ),
    );
  }

  bool get isFilled {
    if(!readTerms) return false;
    if(firstNameController.text.trim().isEmpty) return false;
    if(lastNameController.text.trim().isEmpty) return false;
    if(passwordController.text.trim().isEmpty) return false;
    if(emailController.text.trim().isEmpty) return false;

    if(ref.read(isAgent) && referralController.text.trim().isEmpty) return false;
    return true;
  }

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
        backgroundColor: Colors.transparent,
      ),
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
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: 414.w,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75, fontWeight: FontWeight.w500),
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
                          onChange: (val) => textChecker(text: val, onAction: () => setState(() {})),
                          onValidate: (value) {
                            if (value!.trim().isEmpty) {
                              showError("Please enter your surname");
                              return '';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Last Name",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75, fontWeight: FontWeight.w500),
                        ),
                        SpecialForm(
                          controller: lastNameController,
                          width: 414.w,
                          height: 50.h,
                          hintStyle: context.textTheme.bodyMedium!
                              .copyWith(color: fadedBorder),
                          onChange: (val) => textChecker(text: val, onAction: () => setState(() {})),
                          onValidate: (value) {
                            if (value!.trim().isEmpty) {
                              showError("Please enter your last name");
                              return '';
                            }
                            return null;
                          },
                          hint: "Other Name",
                          onSave: (val) =>
                              setState(() => authDetails["lastName"] = val!),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Email Address",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75, fontWeight: FontWeight.w500),
                        ),
                        SpecialForm(
                          controller: emailController,
                          width: 414.w,
                          height: 50.h,
                          onChange: (val) => textChecker(text: val, onAction: () => setState(() {})),
                          type: TextInputType.emailAddress,
                          onValidate: (value) {
                            if (value!.trim().isEmpty ||
                                !value!.contains("@")) {
                              showError("Please enter a valid email address");
                              return '';
                            }
                            return null;
                          },
                          hintStyle: context.textTheme.bodyMedium!
                              .copyWith(color: fadedBorder),
                          hint: "example@example.com",
                          onSave: (val) => setState(
                              () => authDetails["emailAddress"] = val!),
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
                          onChange: (val) => textChecker(text: val, onAction: () => setState(() {})),
                          onValidate: (value) {
                            if (value!.trim().length < 6) {
                              showError(
                                  "Please use at least 6 characters for your password");
                              return '';
                            }
                            return null;
                          },
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
                        if (ref.read(isAgent)) SizedBox(height: 16.h),
                        if (ref.read(isAgent))
                          Text(
                            "Referral Code",
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
                          ),
                        if (ref.read(isAgent))
                          SpecialForm(
                            controller: referralController,
                            width: 414.w,
                            height: 50.h,
                            onChange: (val) => textChecker(text: val, onAction: () => setState(() {})),
                            onValidate: (value) {
                              if (!ref.read(isAgent)) return null;

                              if (value!.trim().length != 6) {
                                showError(
                                    "Your referral code must be 6 digits");
                                return '';
                              }
                              return null;
                            },
                            onSave: (val) {
                              if (!ref.read(isAgent)) return;
                              setState(
                                  () => authDetails["referralCode"] = val!);
                            },
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: readTerms,
                              activeColor: appBlue,
                              onChanged: (val) =>
                                  setState(() => readTerms = !readTerms),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree to",
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                            color: weirdBlack75,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: " Privacy Policies",
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                            color: appBlue,
                                            fontWeight: FontWeight.w500),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => context.router
                                          .pushNamed(Pages.privacyPolicy),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 70.h),
                        GestureDetector(
                          onTap: () {
                            if (!readTerms) {
                              showError(
                                  "Please read and accept Fynda's Privacy Policy to proceed");
                              return;
                            }

                            if (!validateForm(formKey)) return;

                            authDetails["roletype"] = (ref.read(isAStudent))
                                ? "Student"
                                : ref.read(isLandlord)
                                ? "LandLord"
                                : "Agent";

                            register();
                          },
                          child: Container(
                            width: 414.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: !isFilled
                                    ? appBlue.withOpacity(0.4)
                                    : appBlue),
                            child: Text(
                              "Create Account",
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
                                "Already have an account?",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: weirdBlack75,
                                    fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: () => context.router
                                    .pushNamed(Pages.login),
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
                        SizedBox(height: 60.h),
                      ],
                    ),
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
