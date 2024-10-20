import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hostel/api/file_manager.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void navigate() {
    ref.watch(otpOriginProvider.notifier).state = OtpOrigin.forgot;
    context.router.pushReplacementNamed(Pages.accountVerification,
        extra: emailController.text);
  }

  Future<void> sendOTP() async {
    // generateOTP(emailController.text).then((resp) {
    //   if (!mounted) return;
    //   showError(resp.message);
    //   if (!resp.success) {
    //     Navigator.of(context).pop();
    //   } else {
    //     navigate();
    //   }
    // });
    //
    // await showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Dialog(
    //     elevation: 0.0,
    //     backgroundColor: Colors.transparent,
    //     child: loader,
    //   ),
    // );
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   systemOverlayStyle: SystemUiOverlayStyle.dark,
      //   elevation: 0.0,
      //   leading: IconButton(
      //     iconSize: 26.r,
      //     splashRadius: 20.r,
      //     icon: const Icon(Icons.chevron_left_rounded),
      //     onPressed: () => context.router.pop(),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.h),
              SvgPicture.asset(
                "assets/images/Forgot Password.svg",
                width: 220.r,
                height: 220.r,
              ),
              SizedBox(height: 12.h),
              Text(
                "Forgot Password",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  "To reset your password, please enter your email address associated with your account.",
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
                        onChange: (val) => setState(() {}),
                        onValidate: (value) {
                          if (value!.trim().isEmpty || !value.contains("@")) {
                            showError("Invalid Email Address");
                            return '';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 230.h),
                      GestureDetector(
                        onTap: () {
                          emailController.text = emailController.text.trim();
                          if (emailController.text.isEmpty) return;
                          sendOTP();
                        },
                        child: Container(
                          width: 414.w,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: emailController.text.isEmpty
                                  ? appBlue.withOpacity(0.4)
                                  : appBlue),
                          child: Text(
                            "Send",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
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

class ResetPasswordPage extends ConsumerStatefulWidget {
  final List<String> details;

  const ResetPasswordPage({super.key, required this.details});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  bool showPassword = false;
  bool showConfirmPassword = false;

  late Map<String, dynamic> authDetails;

  @override
  void initState() {
    super.initState();
    authDetails = {
      "email": widget.details[0],
      "otp": widget.details[1],
      "password": "",
      "confirmPassword": "",
    };
  }

  void navigate() {
    ref.watch(otpOriginProvider.notifier).state = OtpOrigin.none;
    context.router.goNamed(Pages.login);
  }

  bool validate() {
    unFocus();
    FormState? currentState = formKey.currentState;
    if (currentState != null) {
      if (!currentState.validate()) return false;
      currentState.save();
      return true;
    }
    return false;
  }

  Future<void> reset() async {
    navigate();

    // resetPassword(authDetails).then((resp) {
    //   if (!mounted) return;
    //   showError(resp.message);
    //   if (!resp.success) {
    //     Navigator.of(context).pop();
    //   } else {
    //     navigate();
    //   }
    // });
    //
    // await showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Dialog(
    //     elevation: 0.0,
    //     backgroundColor: Colors.transparent,
    //     child: loader,
    //   ),
    // );
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   systemOverlayStyle: SystemUiOverlayStyle.dark,
      //   elevation: 0.0,
      //   leading: IconButton(
      //     iconSize: 26.r,
      //     splashRadius: 20.r,
      //     icon: const Icon(Icons.chevron_left_rounded),
      //     onPressed: () => context.router.pop(),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.h),
              SvgPicture.asset(
                "assets/images/Reset Password.svg",
                width: 220.r,
                height: 220.r,
              ),
              SizedBox(height: 12.h),
              Text(
                "Reset Password",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  "Enter your new password and regain access to your account.",
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
                          "New Password",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75, fontWeight: FontWeight.w500),
                        ),
                        SpecialForm(
                          controller: passwordController,
                          width: 414.w,
                          height: 50.h,
                          obscure: !showPassword,
                          onChange: (val) => textChecker(text: val!, onAction: () => setState(() {})),
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
                        SizedBox(height: 16.h),
                        Text(
                          "Confirm Password",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: weirdBlack75, fontWeight: FontWeight.w500),
                        ),
                        SpecialForm(
                          controller: confirmController,
                          width: 414.w,
                          height: 50.h,
                          obscure: !showConfirmPassword,
                          onChange: (val) => textChecker(text: val!, onAction: () => setState(() {})),
                          onValidate: (value) {
                            if (value!.trim() != passwordController.text.trim()) {
                              showError("The passwords do not match.");
                              return '';
                            }
                            return null;
                          },
                          onSave: (val) => setState(
                              () => authDetails["confirmPassword"] = val!),
                          suffix: GestureDetector(
                            onTap: () => setState(
                                () => showConfirmPassword = !showConfirmPassword),
                            child: AnimatedSwitcherTranslation.right(
                              duration: const Duration(milliseconds: 500),
                              child: Icon(
                                showConfirmPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                key: ValueKey<bool>(showConfirmPassword),
                                size: 18.r,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 144.h),
                        GestureDetector(
                          onTap: () {
                            if(!validate()) return;
                            reset();
                          },
                          child: Container(
                            width: 414.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: (passwordController.text.isEmpty ||
                                        confirmController.text.isEmpty)
                                    ? appBlue.withOpacity(0.4)
                                    : appBlue),
                            child: Text(
                              "Confirm",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class AccountVerificationPage extends ConsumerStatefulWidget {
  final String email;

  const AccountVerificationPage({
    super.key,
    this.email = "",
  });

  @override
  ConsumerState<AccountVerificationPage> createState() =>
      _AccountVerificationPageState();
}

class _AccountVerificationPageState
    extends ConsumerState<AccountVerificationPage> {
  final List<TextStyle?> otpTextStyles = [];

  String otp = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (otpTextStyles.isEmpty) {
      otpTextStyles.add(createStyle(accentPurpleColor));
      otpTextStyles.add(createStyle(accentDarkGreenColor));
      otpTextStyles.add(createStyle(accentOrangeColor));
      otpTextStyles.add(createStyle(accentPinkColor));
    }
  }

  TextStyle? createStyle(Color color) =>
      context.textTheme.displaySmall?.copyWith(color: color);

  void navigate() {
    if (ref.watch(otpOriginProvider) == OtpOrigin.register) {
      ref.watch(otpOriginProvider.notifier).state = OtpOrigin.none;
      ref.invalidate(registrationProcessProvider);
      FileManager.save("registrationEmail", "");
      context.router.goNamed(Pages.login);
    } else if (ref.watch(otpOriginProvider) == OtpOrigin.forgot) {
      context.router.pushReplacementNamed(Pages.resetPassword,
          extra: [widget.email, otp]);
    } else {
      context.router.pushNamed(Pages.login);
    }
  }

  Future<void> sendOTP() async {
    // generateOTP(widget.email).then((resp) {
    //   if (!mounted) return;
    //   showError(resp.message);
    //   Navigator.of(context).pop();
    // });
    //
    // await showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Dialog(
    //     elevation: 0.0,
    //     backgroundColor: Colors.transparent,
    //     child: loader,
    //   ),
    // );
  }

  Future<void> verify(String verificationCode) async {
    // verifyEmailOTP({"email": widget.email, "otp": verificationCode})
    //     .then((resp) {
    //   if (!mounted) return;
    //   showError(resp.message);
    //   if (!resp.success) {
    //     Navigator.of(context).pop();
    //   } else {
    //     setState(() => otp = verificationCode);
    //     navigate();
    //   }
    // });
    //
    // await showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Dialog(
    //     elevation: 0.0,
    //     backgroundColor: Colors.transparent,
    //     child: loader,
    //   ),
    // );
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   systemOverlayStyle: SystemUiOverlayStyle.dark,
      //   elevation: 0.0,
      //   leading: IconButton(
      //     iconSize: 26.r,
      //     splashRadius: 20.r,
      //     icon: const Icon(Icons.chevron_left_rounded),
      //     onPressed: () => context.router.pop(),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25.h),
              SvgPicture.asset(
                "assets/images/Confirm Email.svg",
                width: 220.r,
                height: 220.r,
              ),
              SizedBox(height: 12.h),
              Text(
                "Email Verification",
                style: context.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "We've just sent you an email with a link to activate your email account ",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: widget.email,
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: " provided.",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 46.h),
              OtpTextField(
                numberOfFields: 4,
                borderColor: appBlue,
                focusedBorderColor: accentPurpleColor,
                styles: otpTextStyles,
                showFieldAsBox: true,
                fieldWidth: 65.r,
                keyboardType: TextInputType.number,
                onSubmit: (verificationCode) =>
                    verify(verificationCode), // end onSubmit
              ),
              SizedBox(height: 80.h),
              Text(
                "Didn't get an email?",
                style: context.textTheme.bodyMedium!
                    .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48.h),
              GestureDetector(
                onTap: sendOTP,
                child: Text(
                  "Resend",
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: appBlue, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
