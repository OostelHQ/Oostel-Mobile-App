import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_hostel/misc/constants.dart';

TextTheme get lightTheme => TextTheme(
    bodySmall: TextStyle(
      fontSize: 12.sp,
      leadingDistribution: TextLeadingDistribution.proportional,
      height: (20 / 12),
      fontFamily: "WorkSans",
      color: weirdBlack,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      leadingDistribution: TextLeadingDistribution.proportional,
      height: (24 / 14),
      fontFamily: "WorkSans",
      color: weirdBlack,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.sp,
      leadingDistribution: TextLeadingDistribution.proportional,
      height: (20 / 18),
      fontFamily: "WorkSans",
      color: weirdBlack,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 16.sp,
      leadingDistribution: TextLeadingDistribution.proportional,
      height: (28 / 16),
      fontFamily: "WorkSans",
      color: weirdBlack,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 18.sp,
      leadingDistribution: TextLeadingDistribution.proportional,
      height: (30 / 18),
      fontFamily: "WorkSans",
      color: weirdBlack,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      fontSize: 20.sp,
      leadingDistribution: TextLeadingDistribution.proportional,
      height: (36 / 20),
      fontFamily: "WorkSans",
      color: weirdBlack,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      fontSize: 40.sp,
      leadingDistribution: TextLeadingDistribution.proportional,
      height: 1,
      fontFamily: "WorkSans",
      color: weirdBlack,
      fontWeight: FontWeight.w600,
    ),
);
