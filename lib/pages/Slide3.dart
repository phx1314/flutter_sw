import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:intro_slider/intro_slider.dart';

class Slide3 extends StatefulWidget {
  @override
  Slide3State createState() => new Slide3State();
}

class Slide3State extends BaseState<Slide3> with TickerProviderStateMixin {
  AnimationController controller;

  CurvedAnimation curved;

  @override
  void initView() {
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    curved = new CurvedAnimation(parent: controller, curve: Curves.ease);

    new Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
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
                    "static/images/guide3_bg.png",
                    width: ScreenUtil.getScaleW(context, 260),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              FadeTransition(
                opacity: curved,
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Image.asset(
                        "static/images/guide3_pic.png",
                        fit: BoxFit.fitWidth,
                        width: ScreenUtil.getScaleW(context, 180),
                      ),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
