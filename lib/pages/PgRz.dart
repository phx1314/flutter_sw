import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemRz.dart';
import 'package:flutter_std/model/ModelSearch.dart';
import 'package:flutter_std/model/ModelRz.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/PullListView.dart';

class PgRz extends StatefulWidget {
  int type;

  PgRz(this.type);

  @override
  PgRzState createState() => new PgRzState();
}

class PgRzState extends BaseState<PgRz> {
  List<Tab> tabs = new List();
  List<Widget> widgets = new List();
  PullListView mPullListView1;
  PullListView mPullListView2;

  @override
  void initView() {
    tabs.add(Tab(
      text: "业务日志",
    ));
    tabs.add(Tab(
      text: "审计日志",
    ));
    mPullListView1 = PullListView(
      methodName:  METHOD_BASELOG,
      other: _getquary(1),
      mCallback: _callBack,
    );
    mPullListView2 = PullListView(
      methodName:  METHOD_BASELOG,
      other: _getquary(0),
      mCallback: _callBack,
    );
    widgets.add(mPullListView1);
    widgets.add(mPullListView2);
  }

  _getquary(int type) {
    List mModelSearchs = new List();
    ModelSearch modelSearch = new ModelSearch();
    ListListBean mListBean = new ListListBean();
    mListBean.Value = '10';
    mListBean.Key = "BaseLogTypeID";
    mListBean.Contract = type == 1 ? '>=' : "<";
    mListBean.filedType = "Int";
    modelSearch.list.add(mListBean);
    mModelSearchs.add(modelSearch);
    Map<String, dynamic> other = {"queryInfo": json.encode(mModelSearchs)};
    return other;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.type,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "日志统计",
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                size: ScreenUtil.getScaleW(context,25),
              ),
              onPressed: () {},
            ),
          ],
          centerTitle: true,
          bottom: TabBar(
            tabs: tabs,
            isScrollable: false,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            unselectedLabelStyle: new TextStyle(fontSize: 16.0),
            labelStyle:
                new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: widgets,
        ),
      ),
    );
  }

  List _callBack(String methodName, res) {
    ModelRz mModelRz = ModelRz.fromJson(res.data);
    List data = new List();
    mModelRz.rows.forEach((item) {
      data.add(new ItemRz(item, widget.type));
    });
    return data;
  }
}
