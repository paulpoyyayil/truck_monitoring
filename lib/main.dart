import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/firebase_options.dart';
import 'package:truck_monitor/utils/push_notification.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('login') ?? false;
  role = prefs.getString('role');

  await PushNotificationService().setupInteractedMessage();
  runApp(const MyApp());

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    navigatorKey.currentState!.push(
        MaterialPageRoute(builder: ((context) => Homepage(selectedIndex: 0))));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(390.0, 866.0),
      builder: (context, child) => Listener(
        onPointerDown: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Montserrat',
            inputDecorationTheme: const InputDecorationTheme(),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.kPrimaryColor,
              primary: AppColors.kPrimaryColor,
              secondary: AppColors.kPrimaryColor,
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColors.kPrimaryColor,
              selectionHandleColor: AppColors.kPrimaryColor,
              selectionColor: AppColors.kPrimaryColor.withOpacity(0.25),
            ),
            scaffoldBackgroundColor: AppColors.kBackgroundColor,
          ),
          home: isLoggedIn ? Homepage(selectedIndex: 0) : const LoginScreen(),
        ),
      ),
    );
  }
}
