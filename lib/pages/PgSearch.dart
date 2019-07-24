import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemSearch.dart';
import 'package:flutter_std/item/ItemSearchTop.dart';
import 'package:flutter_std/model/ModelDx.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class PgSearch extends StatefulWidget {
  String from;
  List<SearchListBean> item;

  PgSearch(this.from, this.item);

  @override
  PgSearchState createState() => new PgSearchState();
}

class PgSearchState extends BaseState<PgSearch> {
  List json_history = new List();
  List<Widget> mWidgets_history = new List();
  TextEditingController mController = TextEditingController();

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        mController.text = data;
        reLoad();
        break;
    }
  }

  @override
  void initView() {
    widget.item.forEach((e) {
      if (e.type == "basedata") {
        e.mModelDxs = List();
        Help.mModelUser.BaseData.forEach((f) {
          if (f.BaseOrder.startsWith(e.baseorder)) {
            e.mModelDxs.add(ModelDx(f.BaseName, f.BaseID,f.BaseOrder));
          }
        });
      }
    });
  }

  @override
  void loadData() async {
    mController.text = widget.item[0].value != null ? widget.item[0].value : '';

    try {
      var data = await Help.get("json_history");
      if (data != null) {
        json_history = json.decode(data);
      }
    } catch (e) {
      print(e.toString());
    }

    json_history.forEach((f) {
      mWidgets_history.add(ItemSearchTop(f));
      reLoad();
    });
  }

  goBack() async {
    if (mController.text.isNotEmpty &&
        !json_history.contains(mController.text)) {
      json_history.add(mController.text);
      await Help.save('json_history', json.encode(json_history));
    }
    widget.item[0].value = mController.text;
    List<dynamic> objs = new List();
    Map<String, dynamic> map = new Map();
    widget.item.forEach((f) {
      if (f.sqlstring != null && f.sqlstring != '') {
        if (f.value != null && f.value.isNotEmpty) {
          f.sqlstring = f.sqlstring
              .replaceAll("#{value}", f.type == "basedata" ? f.ids : f.value);
          objs.add(jsonDecode(f.sqlstring));
        }
      } else {
        map.addAll({f.sqlkey: f.type == "basedata" ? f.ids : f.value ?? ''});
      }
    });
    if (widget.item[0].sqlstring != null && widget.item[0].sqlstring != '') {
      Help.sendMsg(widget.from, 888, jsonEncode(objs));
    } else {
      Help.sendMsg(widget.from, 889, map);
    }

    finish();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: mController,
                style: Style.text_style_13_white,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.all(ScreenUtil.getScaleW(context, 5)),
                    hintText: widget.item[0].text,
                    border: InputBorder.none,
                    hintStyle: Style.text_style_13_white),
                autofocus: false,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          InkWell(
            onTap: () => goBack(),
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                '搜索',
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '搜索历史',
                    style: Style.text_style_14_black,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Help.remove('json_history');
                    mWidgets_history.clear();
                    reLoad();
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                    size: ScreenUtil.getScaleW(context, 25),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: mWidgets_history,
              ),
            ),
            visible: mWidgets_history.length > 0,
          ),
          Padding(padding: EdgeInsets.all(4)),
          Divider(
            height: 1,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.item.length - 1,
              itemBuilder: (context, index) =>
                  ItemSearch(widget.item[index + 1]),
              separatorBuilder: (context, index) => Divider(
                    height: 1,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
