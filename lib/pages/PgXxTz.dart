import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

/**
 * webview版本
 * Created by guoshuyu
 * on 2018/7/27.
 */
class PgXxTz extends StatefulWidget {
  @override
  PgXxTzState createState() => new PgXxTzState();
}

class PgXxTzState extends BaseState<PgXxTz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息通知'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil.getScaleW(context,10),
              color: Color(GSYColors.f2f2f2),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil.getScaleW(context,10)),
              height: ScreenUtil.getScaleW(context,50),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    '接受消息通知',
                    style: Style.text_style_16_black,
                  )),
                  Switch(
                    value: false,
                    onChanged: (bool val) {
                      reLoad();
                    },
                  ),
                ],
              ),
            ),
//            Container(
//              height: ScreenUtil.getScaleW(context,10),
//              color: Color(GSYColors.f2f2f2),
//            ),
//            InkWell(
//              onTap: () {
//                print("ggg");
//              },
//              child: Container(
//                padding: EdgeInsets.all(ScreenUtil.getScaleW(context,10)),
//                height: ScreenUtil.getScaleW(context,50),
//                child: Row(
//                  children: [
//                    Expanded(
//                        child: Text(
//                      '开机自启动设置',
//                      style: Style.text_style_16_black,
//                    )),
//                    Icon(Icons.chevron_right, color: Colors.grey)
//                  ],
//                ),
//              ),
//            ),
//            Divider(height: 1),
//            InkWell(
//              onTap: () {
//                print("ggg");
//              },
//              child: Container(
//                padding: EdgeInsets.all(ScreenUtil.getScaleW(context,10)),
//                height: ScreenUtil.getScaleW(context,50),
//                child: Row(
//                  children: [
//                    Expanded(
//                        child: Text(
//                      '系统通知设置',
//                      style: Style.text_style_16_black,
//                    )),
//                    Icon(Icons.chevron_right, color: Colors.grey)
//                  ],
//                ),
//              ),
//            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Color(GSYColors.f2f2f2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
