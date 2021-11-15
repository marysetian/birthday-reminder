

/*
import 'package:cake_time/birthdays_fb_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';

class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    // Initialization settings for Android
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings(
        'app_icon');

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }


  Future<void> showScheduleNotification(int id, String title, String body, String name, int seconds, DateTime birthday, User loginUser) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Birthday Reminder',
      "It's " + name + "'s" + " birthday! Don't forget to wish them a happy birthday :) ",
      tz.TZDateTime.from(birthday, tz.local),

      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
          priority: Priority.max,
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,

    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
  Future selectNotification(BuildContext context) async {
      await Navigator.push(
        context,
        MaterialPageRoute (builder: (context) => BirthdaysFirebaseScreen(),
        ),
      );
  }

*/