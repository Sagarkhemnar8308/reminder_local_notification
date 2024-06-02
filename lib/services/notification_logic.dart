import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/homescreen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationLogic {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  

  static Future _notificationsDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'Schedule Reminder',
        "Don't Forget to Drink water",
        importance: Importance.max,
        playSound: true,
        priority: Priority.max,
      ),
    );
  }

  static Future init( String uid) async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(
      android: android,
      
    );
    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const HomeScreen(),
        //     ));
        onNotification.add(payload as String);

      },
    );
  }

  static Future showNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime datetime,
  }) async {
    if (datetime.isBefore(DateTime.now())) {
      datetime = datetime.add(const Duration(seconds: 1));
    }
    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(datetime, tz.local),
      await _notificationsDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
