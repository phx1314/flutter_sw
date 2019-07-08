import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/pages/PgGjkh.dart';
import 'package:flutter_std/pages/PgWebDetail.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/BaseStatelessWidget.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class ItemGjkh extends StatefulWidget {
  RowsListBean item;
  int position;

  ItemGjkh(this.item, this.position);

  @override
  ItemGjkhState createState() => new ItemGjkhState();
}

class ItemGjkhState extends BaseState<ItemGjkh> {
  List<Widget> mWidgets = List();

  @override
  void onSuccess(String methodName, res) {
    Help.Toast(context, '删除成功');
    Help.sendMsg('PgGjkh', widget.position == 0 ? 2 : 3, widget);
  }

  @override
  Widget build(BuildContext context) {
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
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: InkWell(
        onTap: () {
          Help.sendMsg('PgGjkh', 0, widget.item);
        },
        child: Container(
          padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mWidgets,
          ),
        ),
      ),
      enabled: widget.item.MenuNameEng .contains("CustomerInfo") ,
      secondaryActions: <Widget>[
        Visibility(
          visible: widget.position == 0 ,
          child: new IconSlideAction(
            caption: '新增',
            color: Colors.green,
            icon: Icons.add,
            onTap: () {
              Help.sendMsg('PgGjkh', 1, widget.item.Id.toString());
            },
          ),
        ),
        new IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            loadUrl(
                widget.position == 0
                    ? METHOD_CUSTLINKMANDEL
                    : METHOD_CUSTLINKDEL,
                {
                  'id':
                  widget.position == 0 ? widget.item.Id : widget.item.KeyID
                });
          },
        ),
      ],


    );
  }
}
