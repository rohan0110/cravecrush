import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initialize() async {
    AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        )
      ],
    );
  }

  static Future<void> scheduleNotifications(List<dynamic> smokingTimes) async {
    List<String> stringTimes = smokingTimes.map((time) => time.toString()).toList();
    for (String time in stringTimes) {
      await _scheduleNotification(time);
    }
  }

  static Future<void> _scheduleNotification(String time) async {
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    List<String> encouragingMessages = [
      'Stay strong! You can do this!',
      'You are in control. Keep going!',
      'Remember your goal. You got this!',
      'Taking a break from smoking is a great choice!',
      'You are stronger than your cravings. Keep up the good work!'
    ];
    Random random = Random();
    String message = encouragingMessages[random.nextInt(encouragingMessages.length)];

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(100),
        channelKey: 'basic_channel',
        title: 'Reminder',
        body: message,
      ),
      schedule: NotificationCalendar(
        day: DateTime.now().day,
        month: DateTime.now().month,
        year: DateTime.now().year,
        hour: hour,
        minute: minute,
        second: 0,
      ),
    );
  }
}
