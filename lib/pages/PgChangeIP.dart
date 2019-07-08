import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

import '../Help.dart';

class PgChangeIP extends StatefulWidget {
  @override
  PgChangeIPState createState() => new PgChangeIPState();
}

class PgChangeIPState extends BaseState<PgChangeIP> {
  TextEditingController mController = TextEditingController(text: Help.BASEURL);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('修改服务器地址'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () async {
              Help.BASEURL = mController.text;
              await Help.save("IP", mController.text);
              finish();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                '确定',
                style: Style.text_style_16_white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
        child: TextField(
          controller: mController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(ScreenUtil.getScaleW(context, 5)),
          ),
          autofocus: false,
        ),
      ),
    );
  }
}
