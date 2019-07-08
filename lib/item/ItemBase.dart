import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/pages/PgGjkh.dart';
import 'package:flutter_std/pages/PgWebDetail.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class ItemBase extends StatefulWidget {
  RowsListBean item;

  ItemBase(this.item);

  @override
  ItemBaseState createState() => new ItemBaseState();
}

class ItemBaseState extends BaseState<ItemBase> {
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
        if (widget.item.MenuNameEng == "CustomerInfo" ||
            widget.item.MenuNameEng == "CustPool") {
          //跟进客户
          Help.goWhere(context, PgGjkh(widget.item, widget.item.Id.toString()));
        } else if (widget.item.mModelMenuConfig != null) {
          Help.go2PubView(context, widget.item, "");
        } else {
          Help.goWhere(
              context,
              PgWebDetail(
                  widget.item.Id, "OaNotice", "oa/oanoticemobile/Query"));
        }
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
