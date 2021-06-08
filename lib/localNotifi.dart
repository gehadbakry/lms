import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static int notificationId = 0;

  static void initializePlugin(BuildContext context) async {
    Future onDidReceiveLocalNotification(
        int id, String title, String body, String payload) async {
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            body,
            textAlign: TextAlign.center,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                if (payload != null) {
                  debugPrint('notification payload: ' + payload);
                }
              },
            )
          ],
        ),
      );
    }

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
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
      icon: '@mipmap/ic_launcher',
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
