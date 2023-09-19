import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/transaction.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/pages/auth/login.dart';
import 'package:my_hostel/pages/auth/password_details.dart';
import 'package:my_hostel/pages/auth/privacy.dart';
import 'package:my_hostel/pages/auth/register.dart';
import 'package:my_hostel/pages/auth/register_type.dart';
import 'package:my_hostel/pages/home/landlord/dashboard.dart';
import 'package:my_hostel/pages/home/landlord/view_hostels.dart';
import 'package:my_hostel/pages/home/student/dashboard.dart';
import 'package:my_hostel/pages/home/student/explore.dart';
import 'package:my_hostel/pages/home/student/filter.dart';
import 'package:my_hostel/pages/home/student/student_hostel_details_page.dart';
import 'package:my_hostel/pages/home/notification.dart';
import 'package:my_hostel/pages/home/student/view_acquires.dart';
import 'package:my_hostel/pages/home/student/view_availables.dart';
import 'package:my_hostel/pages/intro/splash.dart';
import 'package:my_hostel/pages/profile/about.dart';
import 'package:my_hostel/pages/profile/owner/wallet.dart';
import 'package:my_hostel/pages/profile/student/edit_profile.dart';
import 'package:my_hostel/pages/profile/help.dart';
import 'package:my_hostel/pages/profile/student/pasword_notification.dart';
import 'package:my_hostel/pages/profile/student/profile.dart';
import 'package:my_hostel/pages/profile/student/settings.dart';
import 'package:my_hostel/pages/profile/owner/settings.dart';
import 'package:my_hostel/pages/profile/student/other_student_profile.dart';
import 'package:my_hostel/pages/profile/transaction.dart';
import 'package:my_hostel/pages/profile/student/wallet.dart';

void main() {
  runApp(const ProviderScope(child: MyHostelApp()));
}

class MyHostelApp extends StatefulWidget {
  const MyHostelApp({super.key});

  @override
  State<MyHostelApp> createState() => _MyHostelAppState();
}

class _MyHostelAppState extends State<MyHostelApp> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      initialLocation: Pages.splash.path,
      routes: [
        GoRoute(
          path: Pages.splash.path,
          name: Pages.splash,
          builder: (_, __) => const SplashPage(),
        ),
        GoRoute(
          path: Pages.registrationType.path,
          name: Pages.registrationType,
          builder: (_, __) => const RegistrationTypePage(),
        ),
        GoRoute(
          path: Pages.register.path,
          name: Pages.register,
          builder: (_, __) => const RegisterPage(),
        ),
        GoRoute(
          path: Pages.login.path,
          name: Pages.login,
          builder: (_, __) => const LoginPage(),
        ),
        GoRoute(
          path: Pages.accountVerification.path,
          name: Pages.accountVerification,
          builder: (_, __) => const AccountVerificationPage(),
        ),
        GoRoute(
          path: Pages.privacyPolicy.path,
          name: Pages.privacyPolicy,
          builder: (_, __) => const PrivacyPolicyPage(),
        ),
        GoRoute(
          path: Pages.studentProfileSettings.path,
          name: Pages.studentProfileSettings,
          builder: (_, __) => const StudentProfileSettingsPage(),
        ),
        GoRoute(
          path: Pages.ownerProfileSettings.path,
          name: Pages.ownerProfileSettings,
          builder: (_, __) => const OwnerProfileSettingsPage(),
        ),
        GoRoute(
          path: Pages.editProfile.path,
          name: Pages.editProfile,
          builder: (_, __) => const EditProfilePage(),
        ),
        GoRoute(
          path: Pages.about.path,
          name: Pages.about,
          builder: (_, __) => const AboutPage(),
        ),
        GoRoute(
          path: Pages.notification.path,
          name: Pages.notification,
          builder: (_, __) => const NotificationPage(),
        ),
        GoRoute(
          path: Pages.transactionDetails.path,
          name: Pages.transactionDetails,
          builder: (_, state) =>
              TransactionDetailsPage(transaction: state.extra as Transaction),
        ),
        GoRoute(
          path: Pages.transactionHistory.path,
          name: Pages.transactionHistory,
          builder: (_, __) => const TransactionHistoryPage(),
        ),
        GoRoute(
          path: Pages.topUp.path,
          name: Pages.topUp,
          builder: (_, state) => const WalletTopUpPage(),
        ),
        GoRoute(
          path: Pages.withdraw.path,
          name: Pages.withdraw,
          builder: (_, state) => const WithdrawPage(),
        ),
        GoRoute(
          path: Pages.help.path,
          name: Pages.help,
          builder: (_, __) => const HelpPage(),
        ),
        GoRoute(
          path: Pages.studentWallet.path,
          name: Pages.studentWallet,
          builder: (_, __) => const StudentWalletPage(),
        ),
        GoRoute(
          path: Pages.ownerWallet.path,
          name: Pages.ownerWallet,
          builder: (_, __) => const OwnerWalletPage(),
        ),
        GoRoute(
          path: Pages.changePassword.path,
          name: Pages.changePassword,
          builder: (_, __) => const PasswordChangePage(),
        ),
        GoRoute(
          path: Pages.notificationSettings.path,
          name: Pages.notificationSettings,
          builder: (_, __) => const ProfileNotificationPage(),
        ),
        GoRoute(
          path: Pages.forgotPassword.path,
          name: Pages.forgotPassword,
          builder: (_, __) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: Pages.resetPassword.path,
          name: Pages.resetPassword,
          builder: (_, __) => const ResetPasswordPage(),
        ),
        GoRoute(
          path: Pages.studentDashboard.path,
          name: Pages.studentDashboard,
          builder: (_, __) => const StudentDashboardPage(),
        ),
        GoRoute(
          path: Pages.ownerDashboard.path,
          name: Pages.ownerDashboard,
          builder: (_, __) => const LandownerDashboardPage(),
        ),
        GoRoute(
          path: Pages.viewAcquires.path,
          name: Pages.viewAcquires,
          builder: (_, state) =>
              ViewAcquiresPage(hostel: (state.extra as bool)),
        ),
        GoRoute(
          path: Pages.viewAvailable.path,
          name: Pages.viewAvailable,
          builder: (_, state) =>
              ViewAvailablePage(hostel: (state.extra as bool)),
        ),
        GoRoute(
          path: Pages.viewHostels.path,
          name: Pages.viewHostels,
          builder: (_, __) => const ViewHostelsPage(),
        ),
        GoRoute(
          path: Pages.filter.path,
          name: Pages.filter,
          builder: (_, state) => FilterPage(hostel: (state.extra as bool)),
        ),
        GoRoute(
          path: Pages.viewRoomTypes.path,
          name: Pages.viewRoomTypes,
          builder: (_, __) => const RoomTypesPage(),
        ),
        GoRoute(
          path: Pages.settings.path,
          name: Pages.settings,
          builder: (_, __) => const StudentSettingsPage(),
        ),
        GoRoute(
          path: Pages.studentProfile.path,
          name: Pages.studentProfile,
          builder: (_, __) => const ProfilePage(),
        ),
        GoRoute(
          path: Pages.otherStudent.path,
          name: Pages.otherStudent,
          builder: (_, state) =>
              OtherStudentProfilePage(info: state.extra as Student),
        ),
        GoRoute(
          path: Pages.hostelInfo.path,
          name: Pages.hostelInfo,
          builder: (_, state) =>
              HostelInformationPage(info: state.extra as HostelInfo),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, widget) => MaterialApp.router(
        title: 'Oostel',
        theme: FlexThemeData.light(
          fontFamily: "WorkSans",
          useMaterial3: true,
          scheme: FlexScheme.tealM3,
        ),
        themeMode: ThemeMode.light,
        routerConfig: _router,
      ),
      splitScreenMode: true,
      designSize: const Size(414, 896),
      minTextAdapt: true,
    );
  }
}
