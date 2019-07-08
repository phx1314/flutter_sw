import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:udid/udid.dart';

import '../Help.dart';

class PgSjbd extends StatefulWidget {
  @override
  PgSjbdState createState() => new PgSjbdState();
}

class PgSjbdState extends BaseState<PgSjbd> {
  String udid;

  @override
  void initView() async {
    udid = await Udid.udid;
    reLoad();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('提示'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '设备号',
              style: Style.text_style_16_black,
            ),
            Padding(padding: EdgeInsets.all(20)),
            GestureDetector(
              onLongPress: () {
                ClipboardData data = new ClipboardData(text: udid);
                Clipboard.setData(data);
                Help.Toast(context, '已复制到剪切板');
              },
              child: Text(
                udid ?? '',
                style: Style.text_style_18_black,
              ),
            ),
            Padding(padding: EdgeInsets.all(20)),
            Text(
              '该账户未在指定设备登录',
              style: Style.text_style_16_black,
            ),
            Padding(padding: EdgeInsets.all(20)),
            Text(
              '如需切换设备请长按设备号复制发给管理员',
              style: Style.text_style_16_black,
            ),
          ],
        ),
      ),
    );
  }
}
