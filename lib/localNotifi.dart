import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static int notificationId = 0;

  static void initializePlugin(BuildContext context) async {
    // var initializationSettingsAndroid =
    // new AndroidInitializationSettings('@mipmap/noti_ic_launcher');
    // var initializationSettings = InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);
  }

  static Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  static Future showNotificationWithDefaultSoundWithDefaultChannel(
      Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'general',
      'General',
      '',
      enableLights: true,
      enableVibration: true,
     // icon: '@mipmap/noti_ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      // jsonDecode(message['data']['title'])[Get.locale.languageCode],
      // jsonDecode(message['data']['body'])[Get.locale.languageCode],
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
    );
    notificationId++;
  }
}
