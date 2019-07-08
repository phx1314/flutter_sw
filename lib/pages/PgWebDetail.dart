import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFjList.dart';
import 'package:flutter_std/pages/PgFileList.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PgWebDetail extends StatefulWidget {
  int id;
  String refTable;
  String editUrl;

  PgWebDetail(this.id, this.refTable, this.editUrl);

  @override
  PgWebDetailState createState() => new PgWebDetailState();
}

class PgWebDetailState extends BaseState<PgWebDetail> {
  List<String> strs = List();
  bool isFinishEd = false;

  @override
  void initView() {
    strs.add('查看附件');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('详情'),
            Visibility(
              child: Container(
                margin:
                    EdgeInsets.only(left: ScreenUtil.getScaleW(context, 10)),
                child: CupertinoActivityIndicator(),
              ),
              visible: !isFinishEd,
            )
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              size: ScreenUtil.getScaleW(context, 25),
            ),
            onPressed: () {
              Help.showPop(
                context,
                strs,
                (v) {
                  if (v == '查看附件') {
                    Help.goWhere(context,
                        PgFileList(widget.id.toString(), widget.refTable));
                  }
                },
                left: 1,
              );
            },
          ),
        ],
      ),
      body: WebView(
          onPageFinished: (f) {
            isFinishEd = true;
            reLoad();
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              "${Help.BASEURL}/${widget.editUrl}?id=${widget.id}&a=${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}"),
    );
  }
}
