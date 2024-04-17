import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Messsages extends StatefulWidget {
  const Messsages({super.key});

  @override
  State<Messsages> createState() => _MesssagesState();
}

class _MesssagesState extends State<Messsages> {
  Map payload = {};
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is RemoteMessage){
      payload = data.data;
    }
    return Scaffold(
      appBar: AppBar(title: Text("your Message"),),
      body: Center(child: Text(payload.toString()),),
    );
  }
}
