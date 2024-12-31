import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../model/task.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    _notificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  static Future<void> scheduleNotification(Task task) async {
    final androidDetails = AndroidNotificationDetails(
      'task_channel',
      'Task Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    final darwinDetails = DarwinNotificationDetails();

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _notificationsPlugin.zonedSchedule(
      task.hashCode,
      task.title,
      task.description,
      tz.TZDateTime.from(task.reminderTime, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelNotification(Task task) async {
    await _notificationsPlugin.cancel(task.hashCode);
  }
}
