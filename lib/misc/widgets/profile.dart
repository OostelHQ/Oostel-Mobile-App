import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';




class ProfileInfoCard extends StatelessWidget {
  final String image;
  final String header;
  final String text;

  const ProfileInfoCard({
    super.key,
    required this.image,
    required this.header,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE0E5EC),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: SizedBox(
        height: 75.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.w),
            Container(
              width: 50.r,
              height: 50.r,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: paleBlue,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(image),
            ),
            SizedBox(width: 15.w),
            SizedBox(
              width: 290.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    header,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600, color: weirdBlack),
                  ),
                  Text(
                    text,
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: weirdBlack50, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BasicStudentInfo extends StatelessWidget {
  final Student student;

  const BasicStudentInfo({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileInfoCard(
          image: "assets/images/Profile Level.svg",
          header: "${student.level}",
          text: "School level",
        ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Gender.svg",
          header: student.gender,
          text: "Gender",
        ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Religion.svg",
          header: student.religion,
          text: "Religion",
        ),
        if (student.religion == "Christianity") SizedBox(height: 15.h),
        if (student.religion == "Christianity")
          ProfileInfoCard(
            image: "assets/images/Profile Church.svg",
            header: student.denomination,
            text: "Denomination",
          ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Age.svg",
          header: student.ageRange,
          text: "Age",
        ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Origin.svg",
          header: student.origin,
          text: "State of origin",
        ),
        SizedBox(height: 15.h),
        ProfileInfoCard(
          image: "assets/images/Profile Hobby.svg",
          header: student.hobby,
          text: "Hobbies",
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
