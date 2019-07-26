import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../Help.dart';
import 'PgGrzl.dart';

/**
 * webview版本
 * Created by guoshuyu
 * on 2018/7/27.
 */
class PgAccount extends StatefulWidget {
  @override
  PgAccountState createState() => new PgAccountState();
}

class PgAccountState extends BaseState<PgAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('账户与安全'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil.getScaleW(context, 10),
              color: Color(GSYColors.f2f2f2),
            ),
            InkWell(
              onTap: () {
                Help.goWhere(context, PgGrzl(Help.mModelUser.UserInfo.EmpID));
              },
              child: Container(
                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                height: ScreenUtil.getScaleH(context, 45),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '账号',
                      style: Style.text_style_16_black,
                    )),
                    Text(
                      Help.mModelUser.UserInfo.EmpName,
                      style: Style.text_style_13_gray,
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
            ),
            Divider(height: ScreenUtil.getScaleW(context, 2)),
            InkWell(
              onTap: () {
              },
              child: Container(
                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                height: ScreenUtil.getScaleH(context, 45),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '手机号',
                      style: Style.text_style_16_black,
                    )),
                    Text(
                      Help.mModelUser.UserInfo.EmpTel,
                      style: Style.text_style_13_gray,
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
            ),
            Container(
              height: ScreenUtil.getScaleW(context, 10),
              color: Color(GSYColors.f2f2f2),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
              height: ScreenUtil.getScaleH(context, 45),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    '使用屏幕锁',
                    style: Style.text_style_16_black,
                  )),
                  Switch(
                    value: Help.mModelUser.UserInfo.isLock??false,
                    onChanged: (bool val) async{
                      Help.mModelUser.UserInfo.isLock=val;
                      await Help.save("mModelUser", json.encode(Help.mModelUser.toJson()));
                    },
                  ),
                ],
              ),
            ),
            Divider(height: ScreenUtil.getScaleW(context, 2)),
//            Container(
//              padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
//              height: ScreenUtil.getScaleH(context, 45),
//              child: Row(
//                children: [
//                  Expanded(
//                      child: Text(
//                    '使用应用锁',
//                    style: Style.text_style_16_black,
//                  )),
//                  Switch(
//                    value: false,
//                    onChanged: (bool val) {
//                      reLoad();
//                    },
//                  ),
//                ],
//              ),
//            ),
//            Divider(height: ScreenUtil.getScaleW(context, 2)),
            InkWell(
              child: Container(
                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                height: ScreenUtil.getScaleH(context, 45),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '解锁方式',
                      style: Style.text_style_16_black,
                    )),
                    Text(
                      '密码',
                      style: Style.text_style_13_gray,
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
            ),
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
