import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hostel/api/user_service.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
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
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 20.r,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
      ),
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
                          if (emailController.text.isEmpty) return;
                          context.router.pushNamed(Pages.accountVerification);
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
  void initState() {
    super.initState();

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
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 20.r,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
      ),
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
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75, fontWeight: FontWeight.w500),
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
                      SizedBox(height: 144.h),
                      GestureDetector(
                        onTap: () {
                          if (passwordController.text.isEmpty ||
                              confirmController.text.isEmpty) return;
                          context.router.goNamed(Pages.login);
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
    this.email = "johndoe@mail.com",
  });

  @override
  ConsumerState<AccountVerificationPage> createState() =>
      _AccountVerificationPageState();
}

class _AccountVerificationPageState extends ConsumerState<AccountVerificationPage> {
  final List<TextStyle?> otpTextStyles = [];

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
    context.router.pushReplacementNamed(
      ref.read(isAStudent)
          ? Pages.studentDashboard
          : ref.read(isAgent)
              ? Pages.agentDashboard
              : Pages.ownerDashboard,
    );
  }

  Future<void> verify(String verificationCode) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          verifyOTP({"email": widget.email, "otp": verificationCode})
              .then((resp) {
            showError(resp.message);
            if (!resp.success) {
              Navigator.of(context).pop();
            } else {
              navigate();
            }
          });

          return const Dialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: loader,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 20.r,
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => context.router.pop(),
        ),
      ),
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
                    text: TextSpan(children: [
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
                    ]),
                  )),
              SizedBox(height: 46.h),
              OtpTextField(
                numberOfFields: 4,
                borderColor: appBlue,
                focusedBorderColor: accentPurpleColor,
                styles: otpTextStyles,
                showFieldAsBox: true,
                fieldWidth: 65.r,
                keyboardType: TextInputType.number,
                onSubmit: (verificationCode) => verify(verificationCode), // end onSubmit
              ),
              SizedBox(height: 80.h),
              Text(
                "Didn't get an email?",
                style: context.textTheme.bodyMedium!
                    .copyWith(color: weirdBlack75, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48.h),
              GestureDetector(
                onTap: () {},
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
