import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Color appBlue = Color.fromRGBO(6, 73, 151, 1.0);
const Color fadedBorder = Color.fromRGBO(1, 15, 30, 0.16);
const Color weirdBlack = Color.fromRGBO(1, 15, 30, 1.0);
const Color weirdBlack75 = Color.fromRGBO(1, 15, 30, 0.75);
const Color weirdBlack50 = Color.fromRGBO(1, 15, 30, 0.5);
const Color weirdBlack25 = Color.fromRGBO(1, 15, 30, 0.25);
const Color weirdBlack20 = Color.fromRGBO(1, 15, 30, 0.20);
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

  static const String viewAcquires = 'view-acquires';
  static const String viewAvailable = 'view-available';
  static const String viewRoomTypes = 'view-room-types';
  static const String filter = 'filter';
  static const String settings = 'settings';

  static const String profileSettings = 'profile-settings';
  static const String editProfile = 'edit-profile';
  static const String changePassword = 'change-password';
  static const String notificationSettings = 'notification-settings';
  static const String about = 'about';
  static const String help = 'help';
  static const String privacyPolicy = 'privacy-policy';

  static const String wallet = 'wallet';
  static const String notification = 'notification';

}

const String loremIpsum = "Lorem ipsum dolor sit amet, consectetur. Nam ut cursus ipsum dolor sit amet. "
    "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, "
    "consectetur. Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum"
    " dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. "
    "Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum "
    "dolor sit amet. Lorem ipsum dolor sit amet, consectetur.  Lorem ipsum dolor sit amet, consectetur. "
    "Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor sit amet, "
    "consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, consectetur. Lorem ipsum dolor "
    "sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, consectetur. Lorem "
    "ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, consectetur. "
    "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. Lorem ipsum dolor sit amet, "
    "consectetur.";


const List<String> states = [
  "Abia",
  "Adamawa",
  "Akwa Ibom",
  "Anambra",
  "Bauchi",
  "Bayelse",
  "Benue",
  "Borno",
  "Cross River",
  "Delta",
  "Ebonyi",
  "Edo",
  "Ekiti",
  "Enugu",
  "Gombe",
  "Imo",
  "Jigawa",
  "Kaduna",
  "Kano",
  "Katsina",
  "Kebbi",
  "Kogi",
  "Kwara",
  "Lagos",
  "Nassarawa",
  "Niger",
  "Ogun",
  "Ondo",
  "Osun",
  "Oyo",
  "Plateau",
  "Rivers",
  "Sokoto",
  "Taraba",
  "Yobe",
  "Zamfara",
  "FCT"
];