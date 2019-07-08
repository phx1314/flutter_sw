import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_std/pages/PgMain.dart';

void main() {

//  Overlay
//  await AMap.init('71921fa552a5119c74d39fc297f1d2c4');
//  setDesignWHD(750, 1334);
//  ScreenUtil.getInstance();
//  AMap.init('71921fa552a5119c74d39fc297f1d2c4').then((v) {
  // 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(new PgMain());

//  });
}
