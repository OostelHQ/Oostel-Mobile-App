import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:my_hostel/api/database_service.dart';
import 'package:my_hostel/misc/constants.dart';

import 'misc/routes.dart';

import 'misc/notification_controller.dart';
import 'misc/styles.dart';

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
          importance: NotificationImportance.Max,
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

  await ScreenUtil.ensureScreenSize();
  await DatabaseManager.init();

  //await DatabaseManager.clearAllMessages();

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
      routes: routes,
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
          textTheme: lightTheme,
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
