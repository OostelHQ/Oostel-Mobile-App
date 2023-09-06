import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/pages/auth/login.dart';
import 'package:my_hostel/pages/auth/password_details.dart';
import 'package:my_hostel/pages/auth/register.dart';
import 'package:my_hostel/pages/auth/register_type.dart';
import 'package:my_hostel/pages/home/dashboard.dart';
import 'package:my_hostel/pages/intro/splash.dart';

void main() {
  runApp(const ProviderScope(child: MyHostelApp()));
}

class MyHostelApp extends StatelessWidget {
  const MyHostelApp({super.key});

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
        darkTheme: FlexThemeData.dark(
          fontFamily: "WorkSans",
          useMaterial3: true,
          scheme: FlexScheme.tealM3,
        ),
        themeMode: ThemeMode.system,
        routerConfig: GoRouter(
          initialLocation: Pages.dashboard.path,
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
            )
          ],
        ),
      ),
      splitScreenMode: true,
      designSize: const Size(414, 896),
      minTextAdapt: true,
    );
  }
}
