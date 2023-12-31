import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/widgets.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  final TextEditingController recent = TextEditingController();
  final TextEditingController newOne = TextEditingController();
  final TextEditingController confirm = TextEditingController();

  bool showRecent = false, showNew = false, showConfirm = false;

  @override
  void dispose() {
    recent.dispose();
    newOne.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Password",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enhance your security – Update your password to keep your account safe and protected from unauthorized access.",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Recent Password",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: recent,
                  width: 414.w,
                  height: 50.h,
                  obscure: !showRecent,
                  onChange: (val) {},
                  suffix: GestureDetector(
                    onTap: () => setState(() => showRecent = !showRecent),
                    child: AnimatedSwitcherTranslation.right(
                      duration: const Duration(milliseconds: 500),
                      child: Icon(
                        showRecent
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        key: ValueKey<bool>(showRecent),
                        size: 18.r,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "New Password",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75, fontWeight: FontWeight.w500),
                ),
                SpecialForm(
                  controller: newOne,
                  width: 414.w,
                  height: 50.h,
                  obscure: !showNew,
                  onChange: (val) {},
                  suffix: GestureDetector(
                    onTap: () => setState(() => showNew = !showNew),
                    child: AnimatedSwitcherTranslation.right(
                      duration: const Duration(milliseconds: 500),
                      child: Icon(
                        showNew
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        key: ValueKey<bool>(showNew),
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
                  controller: confirm,
                  width: 414.w,
                  height: 50.h,
                  obscure: !showConfirm,
                  onChange: (val) {},
                  suffix: GestureDetector(
                    onTap: () => setState(() => showConfirm = !showConfirm),
                    child: AnimatedSwitcherTranslation.right(
                      duration: const Duration(milliseconds: 500),
                      child: Icon(
                        showConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        key: ValueKey<bool>(showConfirm),
                        size: 18.r,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 370.h),
                GestureDetector(
                  onTap: () {
                    if(recent.text.isEmpty || newOne.text.isEmpty || confirm.text.isEmpty) return;
                    context.router.pop();
                  },
                  child: Container(
                    width: 414.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: (recent.text.isEmpty || newOne.text.isEmpty || confirm.text.isEmpty) ? appBlue.withOpacity(0.4) : appBlue
                    ),
                    child: Text(
                      "Save Changes",
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
    );
  }
}

class ProfileNotificationPage extends StatefulWidget {
  const ProfileNotificationPage({super.key});

  @override
  State<ProfileNotificationPage> createState() =>
      _ProfileNotificationPageState();
}

class _ProfileNotificationPageState extends State<ProfileNotificationPage> {
  bool settings = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Notification",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Stay informed with ease – Manage your notification preferences "
                      "to receive updates and alerts tailored to your needs.",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),
                SwitchListTile(
                  value: settings,
                  onChanged: (val) => setState(() => settings = val),
                  activeColor: appBlue,
                  subtitle: Text(
                    "Some notification subtitle",
                    style: context.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500, color: weirdBlack50),
                  ),
                  title: Text(
                    "Some notification option",
                    style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500, color: weirdBlack75),
                  ),
                ),
                SizedBox(height: 500.h),
                GestureDetector(
                  onTap: () => context.router.pop(),
                  child: Container(
                    width: 414.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: appBlue,
                    ),
                    child: Text(
                      "Save Changes",
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
    );
  }
}
