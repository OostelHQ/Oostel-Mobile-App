import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/components/transaction.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/pages/auth/login.dart';
import 'package:my_hostel/pages/auth/password_details.dart';
import 'package:my_hostel/pages/auth/privacy.dart';
import 'package:my_hostel/pages/auth/register.dart';
import 'package:my_hostel/pages/auth/register_type.dart';
import 'package:my_hostel/pages/chats/inbox.dart';
import 'package:my_hostel/pages/home/agent/dashboard.dart';
import 'package:my_hostel/pages/home/landlord/create-hostel.dart';
import 'package:my_hostel/pages/home/landlord/dashboard.dart';
import 'package:my_hostel/pages/home/landlord/landlord_hostel_details_page.dart';
import 'package:my_hostel/pages/home/landlord/view_hostels.dart';
import 'package:my_hostel/pages/home/notification.dart';
import 'package:my_hostel/pages/home/student/dashboard.dart';
import 'package:my_hostel/pages/home/student/explore.dart';
import 'package:my_hostel/pages/home/student/filter.dart';
import 'package:my_hostel/pages/home/student/student_hostel_details_page.dart';
import 'package:my_hostel/pages/home/student/view_acquires.dart';
import 'package:my_hostel/pages/home/student/view_availables.dart';
import 'package:my_hostel/pages/intro/splash.dart';
import 'package:my_hostel/pages/other/gallery.dart';
import 'package:my_hostel/pages/profile/about.dart';
import 'package:my_hostel/pages/profile/agent/edit_profile.dart';
import 'package:my_hostel/pages/profile/agent/profile.dart';
import 'package:my_hostel/pages/profile/agent/settings.dart';
import 'package:my_hostel/pages/profile/agent/wallet.dart';
import 'package:my_hostel/pages/profile/help.dart';
import 'package:my_hostel/pages/profile/owner/agents.dart';
import 'package:my_hostel/pages/profile/owner/create_profile.dart';
import 'package:my_hostel/pages/profile/owner/edit_profile.dart';
import 'package:my_hostel/pages/profile/owner/hostel_settings.dart';
import 'package:my_hostel/pages/profile/owner/profile.dart';
import 'package:my_hostel/pages/profile/owner/settings.dart';
import 'package:my_hostel/pages/profile/owner/wallet.dart';
import 'package:my_hostel/pages/profile/student/edit_profile.dart';
import 'package:my_hostel/pages/profile/student/other_student_profile.dart';
import 'package:my_hostel/pages/profile/student/pasword_notification.dart';
import 'package:my_hostel/pages/profile/student/profile.dart';
import 'package:my_hostel/pages/profile/student/settings.dart';
import 'package:my_hostel/pages/profile/student/wallet.dart';
import 'package:my_hostel/pages/profile/transaction.dart';

import 'misc/notification_controller.dart';

void main() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher_foreground',
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color.fromRGBO(6, 73, 151, 1.0),
          ledColor: Colors.white,
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
      )
    ],
  );
  bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
  if(!isNotificationAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

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
          builder: (_, state) => AccountVerificationPage(email: state.extra as String),
        ),
        GoRoute(
          path: Pages.privacyPolicy.path,
          name: Pages.privacyPolicy,
          builder: (_, __) => const PrivacyPolicyPage(),
        ),
        GoRoute(
          path: Pages.hostelSettings.path,
          name: Pages.hostelSettings,
          builder: (_, __) => const HostelSettingsPage(),
        ),
        GoRoute(
          path: Pages.stepOne.path,
          name: Pages.stepOne,
          builder: (_, __) => const StepOne(),
        ),
        GoRoute(
          path: Pages.stepTwo.path,
          name: Pages.stepTwo,
          builder: (_, state) =>
              StepTwo(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.stepThree.path,
          name: Pages.stepThree,
          builder: (_, state) =>
              StepThree(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.stepFour.path,
          name: Pages.stepFour,
          builder: (_, state) =>
              StepFour(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.stepFive.path,
          name: Pages.stepFive,
          builder: (_, state) =>
              StepFive(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.stepSix.path,
          name: Pages.stepSix,
          builder: (_, state) =>
              StepSix(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.stepSixHalf.path,
          name: Pages.stepSixHalf,
          builder: (_, state) =>
              StepSixHalf(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.stepSeven.path,
          name: Pages.stepSeven,
          builder: (_, state) =>
              StepSeven(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.stepEight.path,
          name: Pages.stepEight,
          builder: (_, state) =>
              StepEight(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.stepNine.path,
          name: Pages.stepNine,
          builder: (_, state) =>
              StepNine(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.stepTen.path,
          name: Pages.stepTen,
          builder: (_, state) =>
              StepTen(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.uploadHostel.path,
          name: Pages.uploadHostel,
          builder: (_, state) => UploadHostelPage(info: state.extra as Map<String, dynamic>),
        ),
        GoRoute(
          path: Pages.studentProfileSettings.path,
          name: Pages.studentProfileSettings,
          builder: (_, __) => const StudentProfileSettingsPage(),
        ),
        GoRoute(
          path: Pages.createStepOne.path,
          name: Pages.createStepOne,
          builder: (_, __) => const CreateProfilePageOne(),
        ),
        GoRoute(
          path: Pages.createStepTwo.path,
          name: Pages.createStepTwo,
          builder: (_, state) => const CreateProfilePageTwo(),
        ),
        GoRoute(
          path: Pages.createStepThree.path,
          name: Pages.createStepThree,
          builder: (_, state) => const CreateProfilePageThree(),
        ),
        GoRoute(
          path: Pages.createStepFour.path,
          name: Pages.createStepFour,
          builder: (_, state) => const CreateProfilePageFour(),
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
          path: Pages.editOwnerProfile.path,
          name: Pages.editOwnerProfile,
          builder: (_, __) => const EditOwnerProfilePage(),
        ),
        GoRoute(
          path: Pages.about.path,
          name: Pages.about,
          builder: (_, __) => const AboutPage(),
        ),
        GoRoute(
          path: Pages.tenantAgreement.path,
          name: Pages.tenantAgreement,
          builder: (_, __) => const TenantAgreementPage(),
        ),
        GoRoute(
          path: Pages.agreementSettings.path,
          name: Pages.agreementSettings,
          builder: (_, __) => const OwnerAgreementSettingsPage(),
        ),
        GoRoute(
          path: Pages.ownerAgreement.path,
          name: Pages.ownerAgreement,
          builder: (_, __) => const OwnerAgreementPage(),
        ),
        GoRoute(
          path: Pages.inbox.path,
          name: Pages.inbox,
          builder: (_, state) => Inbox(otherID: state.extra as String),
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
          builder: (_, state) => ResetPasswordPage(details: state.extra as List<String>),
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
          builder: (_, __) => const StudentProfilePage(),
        ),
        GoRoute(
          path: Pages.ownerProfile.path,
          name: Pages.ownerProfile,
          builder: (_, __) => const OwnerProfilePage(),
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
        GoRoute(
          path: Pages.ownerHostelInfo.path,
          name: Pages.ownerHostelInfo,
          builder: (_, state) =>
              LandlordHostelInformationPage(info: state.extra as HostelInfo),
        ),
        GoRoute(
          path: Pages.viewMedia.path,
          name: Pages.viewMedia,
          builder: (_, state) => ViewMedia(info: state.extra as ViewInfo),
        ),
        GoRoute(
          path: Pages.agents.path,
          name: Pages.agents,
          builder: (_, __) => const AgentsPage(),
        ),
        GoRoute(
          path: Pages.viewAgent.path,
          name: Pages.viewAgent,
          builder: (_, state) => ViewAgentPage(data: state.extra as AgentData),
        ),
        GoRoute(
          path: Pages.agentDashboard.path,
          name: Pages.agentDashboard,
          builder: (_, __) => const AgentDashboardPage(),
        ),
        GoRoute(
          path: Pages.agentSettings.path,
          name: Pages.agentSettings,
          builder: (_, __) => const AgentSettingsPage(),
        ),
        GoRoute(
          path: Pages.agentWallet.path,
          name: Pages.agentWallet,
          builder: (_, __) => const AgentWalletPage(),
        ),
        GoRoute(
          path: Pages.agentProfile.path,
          name: Pages.agentProfile,
          builder: (_, __) => const AgentProfilePage(),
        ),
        GoRoute(
          path: Pages.editAgentProfile.path,
          name: Pages.editAgentProfile,
          builder: (_, __) => const EditAgentProfilePage(),
        )
      ],
    );

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) => NotificationController.onActionReceivedMethod(context, receivedAction),
      onNotificationCreatedMethod: (ReceivedNotification receivedNotification) => NotificationController.onNotificationCreatedMethod(context, receivedNotification),
      onNotificationDisplayedMethod: (ReceivedNotification receivedNotification) => NotificationController.onNotificationDisplayedMethod(context, receivedNotification),
      onDismissActionReceivedMethod: (ReceivedAction receivedAction) => NotificationController.onDismissActionReceivedMethod(context, receivedAction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, widget) => MaterialApp.router(
        title: 'Fynda',
        theme: FlexThemeData.light(
          fontFamily: "WorkSans",
          useMaterial3: true,
          scheme: FlexScheme.tealM3,
          scaffoldBackground: const Color(0xFFFBFDFF),
          appBarBackground: const Color(0xFFFBFDFF),
        ),
        themeMode: ThemeMode.light,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      designSize: const Size(414, 896),
      minTextAdapt: true,
    );
  }
}
