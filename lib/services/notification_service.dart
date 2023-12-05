import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static final AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    '1',
    'thecodexhub',
    channelDescription: 'channel description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  //  IOSNotificationDetails _iosNotificationDetails = IOSNotificationDetails(
  //   presentAlert: bool?,
  //   presentBadge: bool?,
  //   presentSound: bool?,
  //   badgeNumber: int?
  //   attachments: List<IOSNotificationAttachment>?
  //   subtitle: String?,
  //       threadIdentifier: String?
  // );

  final NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidNotificationDetails, iOS: null);

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('both');

    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: selectNotification,
    );
  }

  Future<void> displayText(String text) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      text,
      platformChannelSpecifics,
      payload: "Payload",
    );
  }
}
