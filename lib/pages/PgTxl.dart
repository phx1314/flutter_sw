import 'dart:convert';
import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

import 'PgAzList.dart';

class PgTxl extends StatefulWidget {
  @override
  PgTxlState createState() => new PgTxlState();
}

class PgTxlState extends BaseState<PgTxl> {
  String type = '0';

  @override
  void initView() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: InkWell(
            onTap: () {
              showPop();
            },
            child: Container(
              padding: EdgeInsets.all(ScreenUtil.getScaleH(context,10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    type == '0' ? '按A-Z' : '按部门',
                    style: Style.text_style_16_gray,
                  ),
                  Padding(padding: EdgeInsets.all(ScreenUtil.getScaleH(context,2))),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(child: PgAzList(Help.getModelAz(Help.mModelUser.BaseEmployee,type), 0)),
      ],
    );
  }

  void showPop() async {
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
            ScreenUtil.getScaleH(context,200),
            MediaQueryData.fromWindow(window).padding.top +
                AppBar().preferredSize.height +
                ScreenUtil.getScaleH(context,45),
            ScreenUtil.getScaleH(context,200),
            0),
        items: <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: "0",
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text('按A-Z')),
          ),
          PopupMenuDivider(height: 1.0),
          PopupMenuItem<String>(
              value: "1",
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text('按部门'))),
        ]).then((v) {
      if (v == null) return;
      type = v.toString();
      reLoad();
    });
  }
}
