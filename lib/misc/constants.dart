import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Color appBlue = Color.fromRGBO(6, 73, 151, 1.0);
const Color fadedBorder = Color.fromRGBO(1, 15, 30, 0.16);
const Color weirdBlack = Color.fromRGBO(1, 15, 30, 1.0);
const Color infoRoomsLeftBackground = Color.fromRGBO(227, 245, 236, 1.0);
const Color infoRoomsLeft = Color.fromRGBO(22, 152, 82, 1.0);
const Color paleBlue = Color.fromRGBO(230, 237, 244, 1.0);

const Color accentPurpleColor = Color(0xFF6A53A1);
const Color primaryColor = Color(0xFF121212);
const Color accentPinkColor = Color(0xFFF99BBD);
const Color accentDarkGreenColor = Color(0xFF115C49);
const Color accentYellowColor = Color(0xFFFFB612);
const Color accentOrangeColor = Color(0xFFEA7A3B);

extension PathExtension on String {
  String get path => "/$this";
}

extension OostelExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  GoRouter get router => GoRouter.of(this);
}


class Pages
{
  static const String splash = "splash";
  static const String registrationType = 'registration-type';
  static const String register = 'register';
  static const String login = 'login';
  static const String accountVerification = 'verify-account';
  static const String forgotPassword = 'forgot-password';
  static const String resetPassword = 'reset-password';

  static const String profile = 'profile';
  static const String otherStudent = 'other-student';

  static const String dashboard = 'dashboard';
  static const String hostelInfo = 'hostel-info';

}