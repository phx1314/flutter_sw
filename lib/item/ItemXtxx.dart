import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelSystemList.dart';
import 'package:flutter_std/pages/PgEmailDetail.dart';
import 'package:flutter_std/pages/PgWebView.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/FontString.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lpinyin/lpinyin.dart';

class ItemXtxx extends StatefulWidget {
  RowsListBean item;

  ItemXtxx(this.item);

  @override
  ItemXtxxState createState() => new ItemXtxxState();
}

class ItemXtxxState extends BaseState<ItemXtxx> {
  @override
  void onSuccess(String methodName, res) {
    if (methodName == METHOD_SetReadStatus || methodName == METHOD_DeleteRead) {
      Help.sendMsg('PgXtxx', 0, '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Help.goWhere(
            context,
            PgWebView(
                '${Help.BASEURL}/oa/Messagemobile/Display?id=${widget.item.Id.toString()}&a=${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}'));
      },
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: ScreenUtil.getScaleW(context, 60),
                width: ScreenUtil.getScaleW(context, 60),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(color: Color(0xFFD6D6D6), width: 1),
                  color: FontString.data[
                      PinyinHelper.getFirstWordPinyin(widget.item.MessEmpName)
                          .substring(0, 1)],
                ),
                child: Text(widget.item.MessEmpName.substring(0, 1),
                    style: Style.text_style_18_white),
              ),
              Padding(padding: EdgeInsets.all(8)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.item.MessEmpName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Style.text_style_16_black,
                          ),
                        ),
                        Text(
                          Help.matchDate(widget.item.MessDate),
                          style: Style.text_style_13_gray,
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(6)),
                    Text(
                      widget.item.MessTitle,
                      style: Style.text_style_14_black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: '已读',
            color: Colors.green,
            icon: Icons.drafts,
            onTap: () {
              loadUrl(METHOD_SetReadStatus,
                  {"idSet": widget.item.Id.toString(), "status": 1});
            },
          ),
          new IconSlideAction(
            caption: '删除',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              loadUrl(METHOD_DeleteRead, {"idSet": widget.item.Id.toString()});
            },
          ),
        ],
      ),
    );
  }
}
