import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:truck_monitor/main.dart';
import 'package:truck_monitor/models/push_notification.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/utils/custom_navigator.dart';

class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        navigatorKey.currentState!.push(
          CustomPageRoute(
            Homepage(selectedIndex: 0),
          ),
        );
      },
    );
    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = DarwinInitializationSettings();
    var initSetttings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onDidReceiveNotificationResponse: onTapNotification,
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage? message) {
        RemoteNotification? notification = message!.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          PushNotificationLocal notification = PushNotificationLocal(
            title: message.notification?.title,
            body: message.notification?.body,
            dataBody: message.data.toString(),
          );

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: '@mipmap/launcher_icon',
                enableVibration: true,
              ),
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentSound: true,
              ),
            ),
            payload: notification.dataBody,
          );
        }
      },
    );
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
    );
  }

  androidNotificationChannel() => AndroidNotificationChannel(
        'high_importance_channel',
        'Important Updates',
        description: "This channel is used for important notifications.",
        importance: Importance.max,
        enableVibration: true,
        showBadge: true,
      );
}

Future<void> onTapNotification(NotificationResponse? response) async {
  navigatorKey.currentState!.push(
    CustomPageRoute(
      Homepage(selectedIndex: 0),
    ),
  );
}
