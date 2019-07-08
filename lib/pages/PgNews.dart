import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelSearch.dart';
import 'package:flutter_std/pages/PgNewsSon.dart';
import 'package:flutter_std/utils/BaseState.dart';

import 'PgSearch.dart';

class PgNews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PgNewsState();
}

class PgNewsState extends BaseState<PgNews>
    with SingleTickerProviderStateMixin {
  List<Tab> tabs = new List();
  List<Widget> widgets = new List();
  TabController mTabController;
  PageController mPageController = PageController();

  @override
  void initState() {
    super.initState();
    tabs.add(Tab(
      text: "全部",
    ));
    widgets.add(PgNewsSon(
      METHOD_OANEW,
      new Map(),
    ));
    Help.mModelUser.BaseDataSystem.forEach((value) {
      if (value.BaseOrder.startsWith("002_")) {
        tabs.add(Tab(
          text: value.BaseName,
        ));
        widgets
            .add(PgNewsSon(METHOD_OANEW, _getquary(value.BaseID.toString())));
      }
    });

    mTabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  onSuccess(String methodName, res) {}

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
    mPageController.dispose();
  }

//  "http://via.placeholder.com/288x188"
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "新闻",
        ),
        leading: Builder(
          builder: (context) => IconButton(
                icon: Icon(Icons.crop_free,
                    size: ScreenUtil.getScaleW(context, 25)),
                onPressed: () {
//                    print(DefaultTabController.of(context).index.toString());
                  Help.scan(context);
//                    widgets[DefaultTabController
//                        .of(context)
//                        .index]
//                        .mPullListViewState
//                        .setState(() {});
//                    mBannerSwiper.mBannerSwiperState.setState(() {});
                },
              ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              size: ScreenUtil.getScaleW(context, 25),
            ),
            onPressed: () {
              List<SearchListBean> search = List();
              SearchListBean s1 = new SearchListBean();
              s1.type = "text";
              s1.text = "请输入标题、新闻内容";
              s1.sqlstring =
                  '{"isGroup":false,"list":[{"Key":"NewsTitle,NewsContent","Contract":"like","Value":"#{value}"}]}';
              search.add(s1);
              Help.goWhere(context, PgSearch('PgNewsSon', search));
            },
          ),
        ],
        centerTitle: true,
        bottom: TabBar(
          controller: mTabController,
          onTap: (i) => _changeTab(i),
          tabs: tabs,
          isScrollable: true,
//          labelColor: Colors.white,
//          unselectedLabelColor: Colors.white,
          unselectedLabelStyle: new TextStyle(fontSize: 16.0),
          labelStyle:
              new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: PageView(
        controller: mPageController,
        onPageChanged: _changePage,
        children: widgets,
      ),
    );
  }

  void _changeTab(int i) {
    mPageController.animateToPage(i,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _changePage(int i) {
    mTabController.animateTo(i,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  _getquary(String id) {
    List mModelSearchs = new List();
    ModelSearch modelSearch = new ModelSearch();
    ListListBean mListBean = new ListListBean();
    mListBean.Value = id == "0" ? "" : id;
    mListBean.Key = "NewsTypeID";
    mListBean.Contract = "in";
    modelSearch.list.add(mListBean);
    mModelSearchs.add(modelSearch);
    Map<String, dynamic> other = {"queryInfo": json.encode(mModelSearchs)};
    return other;
  }
}
