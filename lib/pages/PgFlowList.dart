import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemBase.dart';
import 'package:flutter_std/item/ItemFlow.dart';
import 'package:flutter_std/item/ItemXmxxdj.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelWork.dart';
import 'package:flutter_std/pages/PgSearch.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_std/utils/PullListView.dart';

class PgFlowList extends StatefulWidget {
  ModelWorkBean item;

  PgFlowList(this.item);

  @override
  State createState() => new PgFlowListState();
}

class PgFlowListState extends BaseState<PgFlowList> {
  PullListView mPullListView;
  String search;

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        mPullListView.reLoad();
        break;
      case 888:
        Map<String, dynamic> map = {"queryInfo": data.toString()};
        Map<String, dynamic> dd =
            widget.item.mModelMenuConfig.grid.queryParams[0];
        dd.remove("queryInfo");
        map.addAll(dd);
        mPullListView.other = map;
        mPullListView.reLoad();
        break;
      case 889:
        Map<String, dynamic> map =
            widget.item.mModelMenuConfig.grid.queryParams[0];
        map.addAll(data);
        mPullListView.other = map;
        mPullListView.reLoad();
        break;
    }
  }

  @override
  void initView() {
    try {
      search = json.encode(widget.item.mModelMenuConfig.search);
    } catch (e) {
      print(e);
    }

    mPullListView = PullListView(
      haline: true,
      methodName: widget.item.mModelMenuConfig.grid.url[0],
      other: widget.item.mModelMenuConfig.grid.queryParams[0],
      mCallback: (methodName, res) {
        ModelFlowList mModelFlowList = ModelFlowList.fromJson(res.data);
        List data = new List();
        mModelFlowList.rows.forEach((f) {
          f.MenuNameEng = widget.item.MenuNameEng;
          f.text = widget.item.text;
          f.MenuMobileConfig = widget.item.MenuMobileConfig;
          f.mModelMenuConfig = ModelMenuConfig.fromJson(json.decode(
              Help.getRightdata(widget.item.MenuMobileConfig, f.toJson())));
          if (widget.item.mModelMenuConfig.grid.listPage == "FlowList") {
            data.add(ItemFlow(f, ''));
          } else if (widget.item.mModelMenuConfig.grid.listPage ==
              "ProjectList") {
            data.add(ItemXmxxdj(f));
          } else if (widget.item.mModelMenuConfig.grid.listPage == "BaseList") {
            data.add(ItemBase(f));
          }
        });
        return data;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.item.text),
          centerTitle: true,
          actions: <Widget>[
            Visibility(
              visible: widget.item.MenuNameEng == 'OaGoing'||widget.item.MenuNameEng == 'OaLeave',
              child: InkWell(
                onTap: () {
                  Map<String, dynamic> map =
                      widget.item.mModelMenuConfig.grid.queryParams[0];
                  map.addAll({"dayNow": Help.getCurrentTime()});
                  mPullListView.other = map;
                  mPullListView.reLoad();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    '今天',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: search != null,
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: ScreenUtil.getScaleW(context, 25),
                ),
                onPressed: () {
                  widget.item.mModelMenuConfig.search =
                      (json.decode(search) as List)
                          .map((i) => SearchListBean.fromJson(i))
                          .toList();
                  Help.goWhere(
                      context,
                      PgSearch(widget.toString(),
                          widget.item.mModelMenuConfig.search));
                },
              ),
            ),
          ],
        ),
        body: mPullListView,
        floatingActionButton: widget.item.mModelMenuConfig.grid.addUrl !=
                    null &&
                widget.item.mModelMenuConfig.grid.addUrl.length > 0
            ? FloatingActionButton(
                onPressed: () {
                  RowsListBean mRowsListBean = new RowsListBean();
                  mRowsListBean.mModelMenuConfig = widget.item.mModelMenuConfig;
                  mRowsListBean.MenuNameEng = widget.item.MenuNameEng;
                  mRowsListBean.text = widget.item.text;
                  Help.go2PubView(context, mRowsListBean, "");
                },
                child: Icon(Icons.add, size: ScreenUtil.getScaleW(context, 40)),
              )
            : null);
  }
}
