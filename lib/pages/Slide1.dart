import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:intro_slider/intro_slider.dart';

class Slide1 extends StatefulWidget {
  @override
  Slide1State createState() => new Slide1State();
}

class Slide1State extends BaseState<Slide1> with TickerProviderStateMixin {
  AnimationController controller;

  AnimationController controller1;
  AnimationController controller2;
  AnimationController controller3;
  CurvedAnimation curved;
  Animation<double> animation;
  CurvedAnimation curved1;
  CurvedAnimation curved2;
  CurvedAnimation curved3;

  @override
  void initView() {
    controller = new AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 200,
        ));
    curved = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addListener(() {
      reLoad();
    });
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
    controller.addStatusListener((status) {
//      print(status.toString());
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    new Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        controller1.forward();
        controller.forward();
      }
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
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: ScreenUtil.getScaleW(context, 10)),
                child: Center(
                  child: Image.asset(
                    "static/images/guide1_bg.png",
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
                    "static/images/guide1_item1.png",
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
                    "static/images/guide1_item2.png",
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
                      "static/images/guide1_item3.png",
                      width: ScreenUtil.getScaleW(context, 15),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Transform.rotate(
                angle: curved.value,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: ScreenUtil.getScaleW(context, 30)),
                  child: Center(
                    child: Image.asset(
                      "static/images/guide1_hand.png",
                      fit: BoxFit.fitWidth,
                      width: ScreenUtil.getScaleW(context, 130),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
