import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/pages/PgGjkh.dart';
import 'package:flutter_std/pages/PgHtsk.dart';
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
  void loadData() {}

  @override
  Widget build(BuildContext context) {
    try {
      mWidgets.clear();
      List responseJson = json.decode(widget.item.FlowSummary);
      String time = '';
      for (int i = 0; i < responseJson.length; i++) {
        if (responseJson[i]['Key'].toString().contains('创建时间')) {
          time = '${responseJson[i]['Key']}  :  ${responseJson[i]['Value']}';
          responseJson.removeAt(i);
          break;
        }
      }
      for (int i = 0; i < responseJson.length; i++) {
        mWidgets.add(Padding(
          padding: EdgeInsets.only(top: 5),
          child: i == responseJson.length - 1
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${responseJson[i]['Key']}  :  ${responseJson[i]['Value']}',
                style: Style.text_style_13_gray,
                softWrap: true,
              ),
              Expanded(
                  child: Text(
                    time,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Style.text_style_13_gray,
                    softWrap: true,
                  ))
            ],
          )
              : Text(
            i == 0
                ? '${responseJson[i]['Value']}'
                : '${responseJson[i]['Key']}  :  ${responseJson[i]['Value']}',
            style: i == 0
                ? Style.text_style_16_black
                : Style.text_style_13_gray,
            softWrap: true,
          ),
        ));
      }
    } catch (e) {
      print(e);
    }
    return InkWell(
      onTap: () {
        if (widget.item.mModelMenuConfig != null) {
          if (widget.item.MenuNameEng == "CluePoolInfo" ||
              widget.item.MenuNameEng == "BussinessCustomerPool") {
            widget.item.isChecked = !widget.item.isChecked;
            reLoad();
          } else if (widget.item.MenuNameEng == "contract_feerecv" ||
              widget.item.MenuNameEng == "contract_invoice") {
            Help.goWhere(
                context,
                PgHtsk(
                    widget.item.mModelMenuConfig.grid.saveUrl[0],
                    widget.item.FormId,
                    "${Help.BASEURL}/${widget.item.mModelMenuConfig.grid
                        .editUrl[0]}&a=${Uri.encodeComponent(
                        Help.mModelUser.name)}&p=${md5.convert(
                        utf8.encode(Help.mModelUser.password)).toString()}",
                    widget.item.MenuNameEng));
          } else {
            Help.go2PubView(context, widget.item, "");
          }
        } else {
          Help.goWhere(
              context,
              PgWebDetail(
                  widget.item.Id, "OaNotice", "oa/oanoticemobile/Query"));
        }
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
        child: Row(children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: mWidgets,
            ),
          ),
          Visibility(
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(Icons.done, color: Colors.blue),
            ),
            visible: widget.item.isChecked &&
                (widget.item.MenuNameEng == 'CluePoolInfo' ||
                    widget.item.MenuNameEng == 'BussinessCustomerPool'),
          )
        ]),
      ),
    );
  }
}
