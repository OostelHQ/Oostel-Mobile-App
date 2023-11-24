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

  final GlobalKey<FormState> formKey = GlobalKey();

  bool showPassword = false;
  bool readTerms = false;

  final Map<String, dynamic> authDetails = {
    "emailAddress": "",
    "password": "",
    "firstName": "",
    "lastName": "",
    "roletype": "",
  };

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool validate() {
    unFocus();
    FormState? currentState = formKey.currentState;
    if (currentState != null) {
      if (!currentState.validate()) return false;

      currentState.save();
      authDetails["roletype"] = (ref.read(isAStudent)) ? "Student" : "LandLord";
      return true;
    }
    return false;
  }

  void navigate() {
    FileManager.saveBool("registeredFynda", true);
    context.router.pushReplacementNamed(Pages.accountVerification, extra: authDetails["emailAddress"]);
  }

  Future<void> register() async {
    registerUser(authDetails).then((resp) {
      if(!mounted) return;
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
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
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
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
                          ),
                          SpecialForm(
                            controller: lastNameController,
                            width: 414.w,
                            height: 50.h,
                            hintStyle: context.textTheme.bodyMedium!
                                .copyWith(color: fadedBorder),
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
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
                          ),
                          SpecialForm(
                            controller: emailController,
                            width: 414.w,
                            height: 50.h,
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
                                color: weirdBlack75,
                                fontWeight: FontWeight.w500),
                          ),
                          SpecialForm(
                            controller: passwordController,
                            width: 414.w,
                            height: 50.h,
                            obscure: !showPassword,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: readTerms,
                                activeColor: appBlue,
                                onChanged: (val) =>
                                    setState(() => readTerms = !readTerms),
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    "I agree to Oostel's",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: weirdBlack75,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  GestureDetector(
                                    onTap: () => context.router
                                        .pushNamed(Pages.privacyPolicy),
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
                          SizedBox(height: 70.h),
                          GestureDetector(
                            onTap: () {
                              if (!readTerms) {
                                showError(
                                    "Please read and accept Fynda's Privacy Policy to proceed");
                                return;
                              }

                              if (!validate()) return;

                              register();
                            },
                            child: Container(
                              width: 414.w,
                              height: 50.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: !readTerms ||
                                          (emailController.text.isEmpty ||
                                              passwordController.text.isEmpty ||
                                              lastNameController.text.isEmpty ||
                                              firstNameController.text.isEmpty)
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
                                      .pushReplacementNamed(Pages.login),
                                  child: Text(
                                    " Login",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
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
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
