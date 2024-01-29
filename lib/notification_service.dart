import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

// /// PACKAGES
// firebase_messaging:
// flutter_local_notifications:
//
//
//
// /// CODE TO INTEGRATE IN MAIN START -----------------------------------------------
//
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   importance: Importance.high,
//   playSound: true,
// );
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
//
// NotificationService().getFCMToken();
// FirebaseMessaging.onBackgroundMessage(
// NotificationService.firebaseMessagingBackgroundHandler);
// await flutterLocalNotificationsPlugin
//     .resolvePlatformSpecificImplementation<
// AndroidFlutterLocalNotificationsPlugin>()
//     ?.createNotificationChannel(channel);
//
// await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
// alert: true,
// badge: true,
// sound: true,
// );
// const AndroidInitializationSettings initializationSettingsAndroid =
// AndroidInitializationSettings('@mipmap/ic_launcher');
// const DarwinInitializationSettings initializationSettingsDarwin =
// DarwinInitializationSettings(
// requestAlertPermission: false,
// requestBadgePermission: false,
// requestSoundPermission: false,
// );
// await flutterLocalNotificationsPlugin
//     .resolvePlatformSpecificImplementation<
// IOSFlutterLocalNotificationsPlugin>()
//     ?.requestPermissions(
// alert: true,
// badge: true,
// sound: true,
// );
// const InitializationSettings initializationSettings = InitializationSettings(
// android: initializationSettingsAndroid,
// iOS: initializationSettingsDarwin,
// );
// NotificationService.getInitialMsg();
// NotificationService.showMsgHandler();
// NotificationService.onMsgOpen();
// flutterLocalNotificationsPlugin.initialize(
// initializationSettings,
// onDidReceiveNotificationResponse:
// (NotificationResponse notificationResponse) {
// log('notificationResponse-----${notificationResponse.payload}');
// },
// );

/// CODE TO INTEGRATE IN MAIN END -----------------------------------------------

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  getFCMToken() async {
    log('hello...');
    try {
      String? token = await messaging.getToken();

      log('fcmtoken>> ${token}');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('fcmToken', token!);
    } catch (e) {
      log('eeee>> $e');
    }
  }

  static void showMsgHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      log("notification>>>>>${notification ?? "notification"}${notification?.body ?? "Body"} ${notification?.title ?? "Title"}");
      // FlutterRingtonePlayer.stop();
      showMsg(notification!, message);
    });
  }

  /// handle notification when app in fore ground..///close app
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        //  FlutterRingtonePlayer.stop();

        // _singleListingMainTrailController.setSlugName(
        //     slugName: '${message?.data['slug_name']}');
      }
    });
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification, RemoteMessage message) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        '${notification.title}',
        '${notification.body}',
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // id
              'High Importance Notifications', // title
              //'This channel is used for important notifications.',
              // description
              importance: Importance.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: DarwinNotificationDetails(
                presentSound: true, presentAlert: true)),
        payload: jsonEncode(message.data));
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    log('Handling a background message ${message.data}');
    RemoteNotification? notification = message.notification;

    // RemoteNotification notification = message.notification ion!;
  }

  ///call when click on notification back
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
      log('listen->${message.data}');
    });
  }
}
