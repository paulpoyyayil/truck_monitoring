import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:truck_monitor/main.dart';
import 'package:truck_monitor/models/push_notification.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';

class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    try {
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
          navigatorKey.currentState!.push(MaterialPageRoute(
            builder: ((context) => Homepage(selectedIndex: 0)),
          ));
        },
      );
      await enableIOSNotifications();
      await registerNotificationListeners();
    } catch (e) {
      rethrow;
    }
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings =
        const AndroidInitializationSettings('@drawable/ic_firebase_icon');
    var iOSSettings = const DarwinInitializationSettings();
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
                icon: '@drawable/ic_firebase_icon',
                priority: Priority.high,
                importance: Importance.high,
                enableVibration: true,
                groupKey: 'com.truck.monitoring',
                styleInformation: const BigTextStyleInformation(''),
              ),
              iOS: const DarwinNotificationDetails(
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

  androidNotificationChannel() => const AndroidNotificationChannel(
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
    MaterialPageRoute(builder: ((context) => Homepage(selectedIndex: 0))),
  );
}
