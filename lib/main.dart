import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_std/pages/PgMain.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import 'Help.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  JPush jPush = new JPush();
  Help.addEventHandler(JPush());
  jPush.applyPushAuthority(
      new NotificationSettingsIOS(sound: true, alert: true, badge: true));
  jPush.setup(
      appKey: "d5de47499dbd50db644a2431",
      channel: "developer-default",
      debug: true,
      production: true);
  Help.init().then((res) async {
    if (Help.ISFIRST == null) {
      runApp(new PgMain(0));
    } else {
      if (res != null) {
        runApp(new PgMain(2));
      } else {
        runApp(new PgMain(1));
      }
    }
  });
}
