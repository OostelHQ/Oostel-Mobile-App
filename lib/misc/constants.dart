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
const Color faintBlue = Color.fromRGBO(1, 15, 30, 0.06);

const Color redDeadlineBackground = Color(0xFFFFD8D8);
const Color yellowDeadlineBackground = Color(0xFFFAF3E5);

const Color accentPurpleColor = Color(0xFF6A53A1);
const Color primaryColor = Color(0xFF121212);
const Color accentPinkColor = Color(0xFFF99BBD);
const Color accentDarkGreenColor = Color(0xFF115C49);
const Color accentYellowColor = Color(0xFFFFB612);
const Color accentOrangeColor = Color(0xFFEA7A3B);

const Color successColor = Color.fromRGBO(22, 152, 82, 1.0);
const Color pendingColor = Color.fromRGBO(255, 201, 44, 1.0);
const Color failColor = Color.fromRGBO(235, 11, 11, 1.0);


const Color incompleteBackground = Color(0xFFFFEF98);
const Color incompleteBar = Color(0xFFC6960B);
const Color incompleteFadedBar = Color(0x50C6960B);

const Color completeBackground = Color(0xFF8FF1BC);
const Color completeBar = Color(0xFF169852);

const int totalPages = 11;

extension PathExtension on String {
  String get path => "/$this";
}

extension OostelExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  GoRouter get router => GoRouter.of(this);
}

enum OtpOrigin {
  none,
  register,
  forgot
}

const String defaultAvatar = "https://gravatar.com/avatar/edault-avatar?s=400&d=robohash&r=x";

double statusBarHeight = 0.0;

class Pages
{
  static const String splash = "splash";
  static const String registrationType = 'registration-type';
  static const String register = 'register';
  static const String login = 'login';
  static const String accountVerification = 'verify-account';
  static const String forgotPassword = 'forgot-password';
  static const String resetPassword = 'reset-password';

  static const String studentProfile = 'student-profile';
  static const String ownerProfile = 'owner-profile';
  static const String otherStudent = 'other-student';
  static const String otherOwner = 'other-owner';

  static const String studentDashboard = 'student-dashboard';
  static const String ownerDashboard = 'owner-dashboard';
  static const String hostelInfo = 'hostel-info';
  static const String inbox = "inbox";

  static const String viewAcquires = 'view-acquires';
  static const String viewAvailable = 'view-available';
  static const String viewRoomTypes = 'view-room-types';
  static const String viewHostels = 'view-hostels';
  static const String filter = 'filter';
  static const String settings = 'settings';

  static const String studentProfileSettings = 'student-profile-settings';
  static const String ownerProfileSettings = 'owner-profile-settings';
  static const String editProfile = 'edit-profile';
  static const String editOwnerProfile = 'edit-owner-profile';

  static const String createStepOne = 'create-owner-one';
  static const String createStepTwo = 'create-owner-two';
  static const String createStepThree = 'create-owner-three';
  static const String createStepFour = 'create-owner-four';

  static const String changePassword = 'change-password';
  static const String notificationSettings = 'notification-settings';
  static const String about = 'about';
  static const String help = 'help';
  static const String privacyPolicy = 'privacy-policy';

  static const String studentWallet = 'student-wallet';
  static const String ownerWallet = 'owner-wallet';
  static const String notification = 'notification';

  static const String transactionHistory = 'transaction-history';
  static const String transactionDetails = 'transaction-details';
  static const String topUp = 'top-up';
  static const String withdraw = 'withdraw';

  static const String hostelSettings = 'hostel-settings';

  static const String viewMedia = 'view-media';
  static const String ownerHostelInfo = 'owner-hostel-info';

  static const String stepOne = 'step-one';
  static const String stepTwo = 'step-two';
  static const String stepThree = 'step-three';
  static const String stepFour = 'step-four';
  static const String stepFive = 'step-five';
  static const String stepSix = 'step-six';
  static const String stepSixHalf = 'step-six-half';
  static const String stepSeven = 'step-seven';
  static const String stepEight = 'step-eight';
  static const String stepNine = 'step-nine';
  static const String stepTen = 'step-ten';

  static const String editStepOne = 'edit-step-one';
  static const String editStepTwo = 'edit-step-two';
  static const String editStepThree = 'edit-step-three';
  static const String editStepFour = 'edit-step-four';
  static const String editStepFive = 'edit-step-five';
  static const String editStepSix = 'edit-step-six';
  static const String editStepSixHalf = 'edit-step-six-half';
  static const String editStepSeven = 'edit-step-seven';
  static const String editStepEight = 'edit-step-eight';
  static const String editStepNine = 'edit-step-nine';
  static const String editStepTen = 'edit-step-ten';


  static const String uploadHostel = 'upload-hostel';

  static const String agents = 'agents';
  static const String viewAgent = 'view-agent';
  static const String agentDashboard = 'agent-dashboard';
  static const String agentWallet = 'agent-wallet';
  static const String agentSettings = 'agent-settings';
  static const String agentProfile = 'agent-profile';
  static const String editAgentProfile = 'edit-agent-profile';

  static const String ownerAgreement = 'owner-agreement';
  static const String tenantAgreement = 'tenant-agreement';
  static const String agreementSettings = 'tenant-agreement-settings';

  static const String editRoom = 'edit-room';
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