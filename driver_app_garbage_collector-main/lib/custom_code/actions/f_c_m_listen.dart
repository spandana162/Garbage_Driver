// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_messaging/firebase_messaging.dart';

Future fCMListen(
  Future Function(RemoteMessage message)? foregroundMessagereceived,
  Future Function(RemoteMessage message)? backgroundMessageReceived,
  Future Function(RemoteMessage message)? notificationMessageOpened,
) async {
  // function to  receive messages from firebase trigger actions passed as arguments and pass message
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (foregroundMessagereceived != null) {
      await foregroundMessagereceived(message);
    }
  });

  FirebaseMessaging.onBackgroundMessage((message) async {
    if (backgroundMessageReceived != null) {
      await backgroundMessageReceived(message);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    if (notificationMessageOpened != null) {
      await notificationMessageOpened(message);
    }
  });
}
