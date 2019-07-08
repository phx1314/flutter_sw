import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class ItemXmxxdj extends StatefulWidget {
  RowsListBean item;

  ItemXmxxdj(this.item);

  @override
  ItemXmxxdjState createState() => new ItemXmxxdjState();
}

class ItemXmxxdjState extends BaseState<ItemXmxxdj> {
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
    return Column(
      children: <Widget>[
        ExpansionTile(
            initiallyExpanded:
                (widget.item.isExpand != null && widget.item.isExpand)
                    ? widget.item.isExpand
                    : false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: mWidgets,
            ),
            backgroundColor: Colors.white,
            trailing: Icon(
              (widget.item.isExpand != null && widget.item.isExpand)
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            onExpansionChanged: (bool) {
              if (widget.item.rows == null) {
                Map<String, dynamic> map = {
                  "id": widget.item.Id,
                  "page": "1",
                  "rows": 20
                };
                map.addAll(widget.item.mModelMenuConfig.grid.queryParams[1]);
                loadUrl(widget.item.mModelMenuConfig.grid.url[1], map);
              }
              widget.item.isExpand = bool;
              reLoad();
//              _changeOpacity(bool);
            },
            children:
                widget.item.mWidgets_son ??<Widget>[] ),
      ],
    );
  }

  @override
  onSuccess(String methodName, res) {
    widget.item.rows =
        (res.data as List).map((i) => RowsListBean.fromJson(i)).toList();
    widget.item.rows.forEach((f) {
      f.text = widget.item.text;
      f.MenuNameEng = widget.item.MenuNameEng;
      f.mModelMenuConfig = ModelMenuConfig.fromJson(json
          .decode(Help.getRightdata(widget.item.MenuMobileConfig, f.toJson())));

      List responseJson = json.decode(f.FlowSummary);
      List<Widget> mWidgets = List();
      widget.item.mWidgets_son = new List();
      Widget mwidget = InkWell(
        onTap: () {
          Help.go2PubView(context, f, "");
        },
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: mWidgets)),
      );
      responseJson.forEach((f) {
        mWidgets.add(Container(
          padding: EdgeInsets.only(top: ScreenUtil.getScaleW(context,5)),
          child: Text(
            '${f['Key']}  :  ${f['Value']}',
            style: Style.text_style_13_gray,
            softWrap: true,
          ),
        ));
      });
      widget.item.mWidgets_son.add(mwidget);
    });
    reLoad();
  }
}
