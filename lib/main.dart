import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/components/landowner.dart';
import 'package:my_hostel/components/roommate_info.dart';
import 'package:my_hostel/components/student.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/pages/auth/login.dart';
import 'package:my_hostel/pages/auth/password_details.dart';
import 'package:my_hostel/pages/auth/register.dart';
import 'package:my_hostel/pages/auth/register_type.dart';
import 'package:my_hostel/pages/home/dashboard.dart';
import 'package:my_hostel/pages/home/hostels.dart';
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
          path: Pages.profile.path,
          name: Pages.profile,
          builder: (_, __) => const ProfilePage(),
        ),
        GoRoute(
          path: Pages.otherStudent.path,
          name: Pages.otherStudent,
          builder: (_, state) {
            Map<String, dynamic> data = state.extra as Map<
                String,
                dynamic>;
            RoommateInfo info = RoommateInfo.fromJson(data);

            Student student = const Student(
              firstName: "John",
              lastName: "Doe",
              gender: "Male",
              image: "assets/images/watch man.jpg",
            );
            RoommateInfo info2 = RoommateInfo(level: 100,
                location: "Harmony",
                amount: 50000,
                available: true,
                student: student,
              origin: "Ebonyi",
              denomination: "Christ Apostolic Church",
              hobby: "Singing and dancing",
              ageRange: "23 - 30",
              religion: "Christianity",
            );
            return OtherStudentProfilePage(info: info);
          },
        ),
        GoRoute(
          path: Pages.hostelInfo.path,
          name: Pages.hostelInfo,
          builder: (_, state) {
            Map<String, dynamic> map = state.extra as Map<
                String,
                dynamic>;
            HostelInfo info = HostelInfo.fromJson(map);
            HostelInfo info2 = HostelInfo(
              id: "1",
              name: "Manchester Hostel Askj",
              image: "assets/images/street.jpg",
              bedrooms: 1,
              bathrooms: 1,
              area: 2500,
              price: 100000,
              roomsLeft: 5,
              address: "Harmony Estate",
              description:
              "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet. "
                  "Lorem ipsum dolor sit amet, consectetur.",
              rules: const [
                "Lorem ipsum dolor sit amet, consectetur.",
                "Nam utcurs usipsum dolor sit amet.",
                "Lorem ipsum dolor sit amet, consectetur.",
                "Nam utcurs usipsum dolor sit amet.",
                "Lorem ipsum dolor sit amet, consectetur. Nam utcurs usipsum dolor sit amet."
              ],
              facilities: const [
                "Light",
                "Water",
                "Security",
                "None",
                "Light",
                "Water",
                "Security",
              ],
              media: const [
                "assets/images/street.jpg",
                "assets/images/street.jpg",
                "assets/images/street.jpg",
                "assets/images/street.jpg",
                "assets/images/street.jpg",
                "assets/images/street.jpg",
                "assets/images/street.jpg",
                "assets/images/street.jpg",
                "assets/images/street.jpg",
              ],
              owner: Landowner(
                id: "12",
                image: "assets/images/watch man.jpg",
                lastName: "Julius",
                firstName: "Adeyemi",
                verified: true,
                ratings: 3.5,
                contact: "+2348012345678",
                totalRated: 234,
                dateJoined: DateTime.now(),
                address: "Ibadan, Nigeria",
              ),
            );
            return HostelInformationPage(info: info);
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
