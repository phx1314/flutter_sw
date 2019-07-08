import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemBase.dart';
import 'package:flutter_std/item/ItemGjkh.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/PullListView.dart';

import 'PgSearch.dart';

class PgGjkh extends StatefulWidget {
  String id;
  RowsListBean item;

  PgGjkh(this.item, this.id);

  @override
  PgGjkhState createState() => new PgGjkhState();
}

class PgGjkhState extends BaseState<PgGjkh>
    with SingleTickerProviderStateMixin {
  List<Tab> tabs = new List();
  List<Widget> widgets = new List();
  PullListView mPullListView1;
  PullListView mPullListView2;
  int position = 0;
  String addUrl1 = "";
  String addUrl2 = "";

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        RowsListBean mRowsListBean = data;
        if (widget.item.MenuNameEng == "CustomerInfo") {
          mRowsListBean.mModelMenuConfig.grid.editUrl[0] = position == 0
              ? mRowsListBean.mModelMenuConfig.grid.editUrl[1]
              : mRowsListBean.mModelMenuConfig.grid.editUrl[2];
        } else {
          mRowsListBean.mModelMenuConfig.grid.editUrl[0] = position == 0
              ? "bussiness/CustLinkManmobile/edit?id=" +
                  mRowsListBean.Id.toString()
              : "bussiness/CustLinkmobile/edit?id=" +
                  mRowsListBean.KeyID.toString();
        }
        mRowsListBean.MenuNameEng = 'CustomerInfo$position';
        Help.go2PubView(context, mRowsListBean, "");
        break;
      case 1:
        RowsListBean mRowsListBean = new RowsListBean();
        mRowsListBean.mModelMenuConfig = widget.item.mModelMenuConfig;
        mRowsListBean.MenuNameEng = widget.item.MenuNameEng;
        mRowsListBean.text = widget.item.text;
        addUrl2 = addUrl2.replaceAll("LinkManID=null", "LinkManID=" + data);
        mRowsListBean.mModelMenuConfig.grid.addUrl[0] = addUrl2;
        mRowsListBean.MenuNameEng = 'CustomerInfo1';
        Help.go2PubView(context, mRowsListBean, "");
        break;
      case 2:
        mPullListView1.data.remove(data);
        mPullListView1.setState();
        break;
      case 3:
        mPullListView2.data.remove(data);
        mPullListView2.setState();
        break;
      case 4:
        mPullListView1.reLoad();
        mPullListView2.reLoad();
        break;
      case 888:
        Map<String, dynamic> map = {"queryInfo": data.toString()};
        Map<String, dynamic> dd =
            widget.item.mModelMenuConfig.grid.queryParams[2];
        dd.remove("queryInfo");
        map.addAll(dd);
        mPullListView2.other = map;
        mPullListView2.reLoad();
        break;
    }
  }

  @override
  void initView() {
    if (widget.item.MenuNameEng == "CustomerInfo") {
      addUrl1 = widget.item.mModelMenuConfig.grid.addUrl[1]
          .replaceAll("CustID=null", "CustID=" + widget.id);
      addUrl2 = widget.item.mModelMenuConfig.grid.addUrl[2];
    }

    mTabController = TabController(length: 2, vsync: this);
    tabs.add(Tab(
      text: "联系人",
    ));
    tabs.add(Tab(
      text: "联系方式",
    ));
    widget.item.mModelMenuConfig.grid.queryParams[1]["CustID"] = widget.id;
    widget.item.mModelMenuConfig.grid.queryParams[2]["CustID"] = widget.id;
    mPullListView1 = PullListView(
      haline: true,
      methodName: widget.item.mModelMenuConfig.grid.url[1],
      other: widget.item.mModelMenuConfig.grid.queryParams[1],
      mCallback: (methodName, res) {
        ModelFlowList mModelFlowList = ModelFlowList.fromJson(res.data);
        List data = new List();
        mModelFlowList.rows.forEach((f) {
          f.MenuNameEng = widget.item.MenuNameEng;
          f.text = widget.item.text;
          f.MenuMobileConfig = widget.item.MenuMobileConfig;
          f.mModelMenuConfig = ModelMenuConfig.fromJson(json.decode(
              Help.getRightdata(widget.item.MenuMobileConfig, f.toJson())));
          data.add(ItemGjkh(f, 0));
        });
        return data;
      },
    );

    mPullListView2 = PullListView(
      haline: true,
      methodName: widget.item.mModelMenuConfig.grid.url[2],
      other: widget.item.mModelMenuConfig.grid.queryParams[2],
      mCallback: (methodName, res) {
        ModelFlowList mModelFlowList = ModelFlowList.fromJson(res.data);
        List data = new List();
        mModelFlowList.rows.forEach((f) {
          f.MenuNameEng = widget.item.MenuNameEng;
          f.text = widget.item.text;
          f.MenuMobileConfig = widget.item.MenuMobileConfig;
          f.mModelMenuConfig = ModelMenuConfig.fromJson(json.decode(
              Help.getRightdata(widget.item.MenuMobileConfig, f.toJson())));
          data.add(ItemGjkh(f, 1));
        });
        return data;
      },
    );
    widgets.add(mPullListView1);
    widgets.add(mPullListView2);
  }

  TabController mTabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "跟进客户",
          ),
          actions: <Widget>[
            Visibility(
              visible: position == 1,
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: ScreenUtil.getScaleW(context, 25),
                ),
                onPressed: () {
                  List<SearchListBean> search = List();
                  SearchListBean s1 = new SearchListBean();
                  s1.type = "text";
                  s1.text = "请输入联系内容、客户联系人、操作人";
                  s1.sqlstring =
                      '{"isGroup":false,"list":[{"Key":"LinkTitle","Contract":"like","Value":"#{value}"}]}';
                  search.add(s1);
                  Help.goWhere(context, PgSearch(widget.toString(), search));
                },
              ),
            ),
          ],
          centerTitle: true,
          bottom: TabBar(
            tabs: tabs,
            controller: mTabController,
            isScrollable: false,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            unselectedLabelStyle: new TextStyle(fontSize: 16.0),
            labelStyle:
                new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            onTap: (i) {
              position = i;
              reLoad();
            },
          ),
        ),
        body: IndexedStack(
          index: position,
          children: widgets,
        ),
        floatingActionButton: Visibility(
          visible: position == 0 && widget.item.MenuNameEng == "CustomerInfo",
          child: FloatingActionButton(
            onPressed: () {
              RowsListBean mRowsListBean = new RowsListBean();
              mRowsListBean.mModelMenuConfig = widget.item.mModelMenuConfig;
              mRowsListBean.MenuNameEng = widget.item.MenuNameEng;
              mRowsListBean.text = widget.item.text;
              mRowsListBean.mModelMenuConfig.grid.addUrl[0] = addUrl1;
              mRowsListBean.MenuNameEng = 'CustomerInfo$position';
              Help.go2PubView(context, mRowsListBean, "");
            },
            child: Icon(Icons.add, size: ScreenUtil.getScaleW(context, 40)),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
  }
}
