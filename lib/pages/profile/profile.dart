import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/providers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Student student = ref.watch(studentProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25.h),
                Text("Profile",
                    style: context.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                    ),
                ),
                SizedBox(height: 20.h),
                CircleAvatar(
                  backgroundColor: appBlue,
                  radius: 60.r,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(student.image),
                    radius: 56.r,
                  ),
                ),
                SizedBox(height: 8.h),
                Text("${student.firstName} ${student.lastName}", style: context.textTheme.bodyLarge,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
