import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/IndicatorWidget.dart';

///广告banner
///author: yinbiao
///time:2018-12-5
class BannerView extends StatefulWidget {
  final int delayTime; //间隔时间秒
  final int scrollTime; //滑动耗时毫秒
  final double height; //banner高度
  final List<Widget> data; //banner内容
  int _index = 0; //当前位置

  BannerView(
      {Key key,
      @required this.data,
      this.delayTime = 3,
      this.scrollTime = 200,
      this.height = 200.0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new BannerViewState();
  }
}

class BannerViewState extends State<BannerView> {
  PageController controller = new PageController();
  Timer timer;

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  ///重置计时器
  void resetTimer() {
    clearTimer();
    timer = new Timer.periodic(new Duration(seconds: widget.delayTime),
        (Timer timer) {
      if (controller.positions.isNotEmpty) {
        ///这里controller.page会丢失精度,需要四舍五入
        widget._index = controller.page.round() + 1;
        controller.animateToPage(widget._index,
            duration: new Duration(milliseconds: widget.scrollTime),
            curve: Curves.linear);
        setState(() {});
      }
    });
  }

  ///清除计时器
  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        _buildBanner(),
        _renderIndicator(),
      ],
    );
  }

  Widget _buildBanner() {
    return new SizedBox(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      child: new GestureDetector(
        onTapDown: (details) {
          clearTimer();
        },
        onTapUp: (details) {
          resetTimer();
        },
        onTapCancel: () {
          resetTimer();
        },
        child: new PageView.builder(
          controller: controller,
          physics:
              const PageScrollPhysics(parent: const ClampingScrollPhysics()),
          itemBuilder: (BuildContext context, int index) {
            return widget.data[index % widget.data.length];
          },
          itemCount: 0x7fffffff,
          onPageChanged: (index) {
            setState(() {
              widget._index = index;
            });
          },
        ),
      ),
    );
  }

  /// indicator widget
  Widget _renderIndicator() {
    return new IndicatorWidget(
      size: widget.data.length,
      currentIndex: widget._index % widget.data.length,
    );
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}
