import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:intro_slider/intro_slider.dart';

import '../Help.dart';
import 'PgHome.dart';
import 'PgLogin.dart';
import 'Slide1.dart';
import 'Slide2.dart';
import 'Slide3.dart';

class PgYinDao extends StatefulWidget {
  static final String sName = "PgYinDao";

  @override
  PgYinDaoState createState() => new PgYinDaoState();
}

class PgYinDaoState extends BaseState<PgYinDao> {
  void onDonePress() async {
    await Help.save("ISFIRST", 'true');
    Help.pushReplacementNamed(context, PgLogin.sName);
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: <Slide>[
        Slide(
          title: '工作内容主动推送\n图纸条码一键查询',
          maxLineTitle: 2,
          styleTitle: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 30,
              decoration: TextDecoration.none),
          backgroundColor: Colors.white,
          centerWidget: Slide1(),
        ),
        Slide(
          title: '沟通你我互帮互助\n创建群组合谋大计',
          maxLineTitle: 2,
          styleTitle: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 30,
              decoration: TextDecoration.none),
          backgroundColor: Colors.white,
          centerWidget: Slide2(),
        ),
        Slide(
          title: '项目管理实时同步\n统计报表实时查阅',
          maxLineTitle: 2,
          styleTitle: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 30,
              decoration: TextDecoration.none),
          backgroundColor: Colors.white,
          centerWidget: Slide3(),
        ),
      ],
      nameSkipBtn: '跳过',
      styleNameSkipBtn: Style.text_style_16_black,
      nameNextBtn: '下一步',
      styleNameDoneBtn: Style.text_style_16_black,
      nameDoneBtn: '进入',
      colorActiveDot: Colors.blueGrey,
      colorDot: Color(0xFFE0E0E0),
      onDonePress: this.onDonePress,
    );
  }
}
