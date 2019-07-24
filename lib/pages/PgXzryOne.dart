import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/item/ItemTxl.dart';
import 'package:flutter_std/model/ModelUser.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:lpinyin/lpinyin.dart';

import '../Help.dart';
import 'PgAzList.dart';

class PgXzryOne extends StatefulWidget {
  String from;

  PgXzryOne(this.from);

  @override
  PgXzryOneState createState() => new PgXzryOneState();
}

class PgXzryOneState extends BaseState<PgXzryOne> {
  List<BaseEmployeeListBean> mBaseEmployeeListBeans;
  TextEditingController mTextEditingController = new TextEditingController();

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        Help.sendMsg(widget.from, 102, data);
        finish();
        break;
    }
  }

  @override
  void initView() {
    mBaseEmployeeListBeans =
        (json.decode(json.encode(Help.mModelUser.BaseEmployee)) as List)
            .map((i) => BaseEmployeeListBean.fromJson(i))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('选择人员'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: Style.text_style_16_black,
              controller: mTextEditingController,
              onChanged: (text) {
                mBaseEmployeeListBeans.clear();
                Help.mModelUser.BaseEmployee.forEach((f) {
                  if (f.EmpName.indexOf(text) != -1 ||
                      PinyinHelper.getFirstWordPinyin(
                              f.EmpName.substring(0, 1).toUpperCase())
                          .contains(text) ||
                      PinyinHelper.getFirstWordPinyin(f.EmpName.substring(0, 1))
                          .contains(text)) {
                    mBaseEmployeeListBeans.add(f);
                  }
                });
                reLoad();
              },
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  size: ScreenUtil.getScaleW(context, 20),
                ),
                contentPadding:
                    EdgeInsets.all(ScreenUtil.getScaleW(context, 5)),
                hintText: '请输入',
              ),
            ),
          ),
          Expanded(
              child: PgAzList(
                  Help.getModelAz(mBaseEmployeeListBeans, '0'), 1)),
        ],
      ),
    );
  }
}
