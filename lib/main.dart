import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/room_details.dart';
import 'package:my_hostel/components/roommate_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/pages/auth/login.dart';
import 'package:my_hostel/pages/auth/password_details.dart';
import 'package:my_hostel/pages/auth/register.dart';
import 'package:my_hostel/pages/auth/register_type.dart';
import 'package:my_hostel/pages/home/dashboard.dart';
import 'package:my_hostel/pages/home/explore.dart';
import 'package:my_hostel/pages/home/filter.dart';
import 'package:my_hostel/pages/home/hostel_information.dart';
import 'package:my_hostel/pages/home/view_acquires.dart';
import 'package:my_hostel/pages/home/view_availables.dart';
import 'package:my_hostel/pages/intro/splash.dart';
import 'package:my_hostel/pages/profile/profile.dart';
import 'package:my_hostel/pages/profile/other_student_profile.dart';

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
          path: Pages.dashboard.path,
          name: Pages.dashboard,
          builder: (_, __) => const DashboardPage(),
        ),
        GoRoute(
          path: Pages.viewAcquires.path,
          name: Pages.viewAcquires,
          builder: (_, state) => ViewAcquiresPage(hostel: (state.extra as bool)),
        ),
        GoRoute(
          path: Pages.viewAvailable.path,
          name: Pages.viewAvailable,
          builder: (_, state) => ViewAvailablePage(hostel: (state.extra as bool)),
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
          path: Pages.profile.path,
          name: Pages.profile,
          builder: (_, __) => const ProfilePage(),
        ),
        GoRoute(
          path: Pages.otherStudent.path,
          name: Pages.otherStudent,
          builder: (_, state) {
            Map<String, dynamic> data = state.extra as Map<String, dynamic>;
            return OtherStudentProfilePage(info: RoommateInfo.fromJson(data));
          },
        ),
        GoRoute(
          path: Pages.hostelInfo.path,
          name: Pages.hostelInfo,
          builder: (_, state) {
            Map<String, dynamic> map = state.extra as Map<String, dynamic>;
            List<RoomInfo> roomInfo = [];
            List<dynamic> values = map["roomsLeft"] as List<dynamic>;
            for(var element in values) {
              roomInfo.add(RoomInfo.fromJson(element));
            }
            map["roomsLeft"] = roomInfo;
            return HostelInformationPage(info: HostelInfo.fromJson(map));
          },
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
