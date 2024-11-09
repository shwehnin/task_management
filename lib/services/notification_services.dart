import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:task_management/data/models/task_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_management/features/notification/views/notification_page.dart';

class NotificationServices {
  // Initialize the flutter notificatin plugin instance
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload == 'Theme Changed') {
      print("Nothing navigate");
    } else {
      await Get.to(() => NotificationPage(label: payload!));
    }
  }

  // Initialize the notification plugin
  static initializeNotification() async {
    _configureLocalTimeZone();
    // tz.initializeTimeZones();
    // define the ios initialization settings
    const DarwinInitializationSettings iOSinitializationSetting =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // define the android initialization settings
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('appicon');

    // combine android and ios initialization settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iOSinitializationSetting,
    );

    // initialize the plugin with the specified settings
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    // request notification permission for android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // show an instance notification
  static Future<void> showInstanceNotification(
      String title, String body) async {
    // define notification details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_id",
        "channel_name",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  // show a schedule notification
  static Future<void> showScheduledNotification(
      int hour, int minutes, TaskModel task) async {
    // String title, String body, DateTime scheduledTime
    // define notification details
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt(),
      task.title,
      task.note,
      _convertTime(hour, minutes),
      // tz.TZDateTime.now(tz.local).add(Duration(seconds: minutes)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name')),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exact,
      payload: "${task.title}| ${task.note}|",
    );
  }

  static tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final location = await tz.getLocation('Asia/Bangkok');
    tz.setLocalLocation(location);
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
