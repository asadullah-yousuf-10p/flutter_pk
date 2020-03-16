import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/screens/apbar_widget/messages_board.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  void setUpFirebase(BuildContext context, String eventId) {
    _firebaseMessaging.subscribeToTopic("wtq");
    addListeners(context, eventId);
  }

  void addListeners(BuildContext context, String eventId) {
    if (Platform.isIOS) 
      requestIOSPermissions();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on onResume $message');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageBoard(eventId),
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on onLaunch $message');
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageBoard(eventId),
          ),
        );
      },
    );
  }

  void requestIOSPermissions() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}