import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:intro_slider/intro_slider.dart';

class Slide2 extends StatefulWidget {
  @override
  Slide2State createState() => new Slide2State();
}

class Slide2State extends BaseState<Slide2> with TickerProviderStateMixin {
  AnimationController controller;

  AnimationController controller1;
  AnimationController controller2;
  AnimationController controller3;
  CurvedAnimation curved;

  CurvedAnimation curved1;
  CurvedAnimation curved2;
  CurvedAnimation curved3;

  @override
  void initView() {
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    curved = new CurvedAnimation(parent: controller, curve: Curves.ease);
    controller1 = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    curved1 = new CurvedAnimation(parent: controller1, curve: Curves.ease);
    controller2 = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    curved2 = new CurvedAnimation(parent: controller2, curve: Curves.ease);
    controller3 = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    curved3 = new CurvedAnimation(parent: controller3, curve: Curves.ease);

    controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller2.forward();
      }
    });
    controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller3.forward();
      }
    });
    controller3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.forward();
      }
    });

    new Future.delayed(const Duration(seconds: 1), () {
      if (mounted) controller1.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            fit: StackFit.passthrough,
            overflow: Overflow.visible,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: ScreenUtil.getScaleW(context, 10)),
                child: Center(
                  child: Image.asset(
                    "static/images/guide2_bg.png",
                    width: ScreenUtil.getScaleW(context, 260),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: ScreenUtil.getScaleW(context, 38),
                top: ScreenUtil.getScaleW(context, 40),
                child: FadeTransition(
                  opacity: curved1,
                  child: Image.asset(
                    "static/images/guide2_item1.png",
                    width: ScreenUtil.getScaleW(context, 55),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                left: ScreenUtil.getScaleW(context, 85),
                top: ScreenUtil.getScaleW(context, 2),
                child: FadeTransition(
                  opacity: curved2,
                  child: Image.asset(
                    "static/images/guide2_item2.png",
                    width: ScreenUtil.getScaleW(context, 35),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              FadeTransition(
                opacity: curved3,
                child: Padding(
                  padding:
                      EdgeInsets.only(right: ScreenUtil.getScaleW(context, 25)),
                  child: Center(
                    child: Image.asset(
                      "static/images/guide2_item3.png",
                      width: ScreenUtil.getScaleW(context, 15),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: ScreenUtil.getScaleW(context, 70)),
                child: Center(
                  child: Image.asset(
                    "static/images/guide2_chat.png",
                    fit: BoxFit.fitWidth,
                    width: ScreenUtil.getScaleW(context, 130),
                  ),
                ),
              ),
              Positioned(
                left: ScreenUtil.getScaleW(context, 180),
                top: ScreenUtil.getScaleW(context, 200),
                child: FadeTransition(
                  opacity: curved,
                  child: Image.asset(
                    "static/images/guide2_item4.png",
                    width: ScreenUtil.getScaleW(context, 150),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
