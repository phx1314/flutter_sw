import 'package:flutter/material.dart';

///颜色
class GSYColors {
  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

  static const int primaryValue = 0xFF24292E;
  static const int primaryLightValue = 0xFF42464b;
  static const int primaryDarkValue = 0xFF121917;

  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int miWhite = 0xffececec;
  static const int white = 0xFFFFFFFF;
  static const int actionBlue = 0xff267aff;
  static const int subTextColor = 0xff959595;
  static const int subLightTextColor = 0xffc4c4c4;
  static const int f2f2f2 = 0xFFF2F2F2;

  static const int mainBackgroundColor = miWhite;

  static const int mainTextColor = primaryDarkValue;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
}

///文本样式
class Style {
  static const String app_default_share_url =
      "https://github.com/CarGuo/GSYGithubAppFlutter";

  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 11.0;

  static const minText = TextStyle(
      color: Color(GSYColors.subLightTextColor),
      fontSize: minTextSize,
      decoration: TextDecoration.none);
  static const minTextWhite = TextStyle(
      color: Color(GSYColors.white),
      fontSize: minTextSize,
      decoration: TextDecoration.none);

  static const smallTextWhite = TextStyle(
      color: Colors.white,
      fontSize: smallTextSize,
      decoration: TextDecoration.none);
  static const text_style_16_gray = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      fontSize: 16,
      decoration: TextDecoration.none);
  static const text_style_16_white = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontSize: 16,
      decoration: TextDecoration.none);
  static const text_style_16_black = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 16,
      decoration: TextDecoration.none);
  static const text_style_18_gray = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      fontSize: 18,
      decoration: TextDecoration.none);
  static const text_style_18_white = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontSize: 18,
      decoration: TextDecoration.none);
  static const text_style_18_black = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 18,
      decoration: TextDecoration.none);
  static const text_style_14_gray = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      fontSize: 14,
      decoration: TextDecoration.none);
  static const text_style_14_white = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontSize: 14,
      decoration: TextDecoration.none);
  static const text_style_14_black = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 14,
      decoration: TextDecoration.none);
  static const text_style_10_gray = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey,
    fontSize: 10,
  );
  static const text_style_10_white = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontSize: 10,
      decoration: TextDecoration.none);
  static const text_style_10_black = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 10,
      decoration: TextDecoration.none);
  static const text_style_13_gray = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      fontSize: 13,
      decoration: TextDecoration.none);
  static const text_style_13_white = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontSize: 13,
      decoration: TextDecoration.none);
  static const text_style_13_black = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 13,
      decoration: TextDecoration.none);
  static const text_style_20_gray = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      fontSize: 20,
      decoration: TextDecoration.none);
  static const text_style_20_white = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontSize: 20,
      decoration: TextDecoration.none);
  static const text_style_20_black = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 20,
      decoration: TextDecoration.none);
}
