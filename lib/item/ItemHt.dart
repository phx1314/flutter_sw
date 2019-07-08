import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelHt.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

import '../Help.dart';

class ItemHt extends StatefulWidget {
  var item;

  ItemHt(this.item);

  @override
  ItemHtState createState() => new ItemHtState();
}

class ItemHtState extends BaseState<ItemHt> {
  List<Widget> mWidgets = List();

  @override
  void loadData() {
    try {
      mWidgets.clear();
      List responseJson = json.decode(widget.item.FlowSummary);
      responseJson.forEach((f) {
        mWidgets.add(Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            '${f['Key']}  :  ${f['Value']}',
            style: Style.text_style_13_black,
            softWrap: true,
          ),
        ));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Help.sendMsg("PgPubView", 0, json.encode(widget.item.toJson()));
        finish();
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: mWidgets,
        ),
      ),
    );
  }
}
