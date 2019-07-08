import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemNews.dart';
import 'package:flutter_std/model/ModelBanner.dart';
import 'package:flutter_std/model/ModelNewsList.dart';
import 'package:flutter_std/model/ModelSearch.dart';
import 'package:flutter_std/model/ModelSearchGk.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/MyBanner.dart';
import 'package:flutter_std/utils/PullListView.dart';

class PgNewsSon extends StatefulWidget {
  var methodName;
  Map<String, dynamic> other;

  PgNewsSon(this.methodName, this.other);

  @override
  State<StatefulWidget> createState() => new PgNewsSonState();
}

class PgNewsSonState extends BaseState<PgNewsSon> {
  PullListView mPullListView;

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 888:
        List list = new List();
        list.addAll((json.decode(data.toString()) as List)
            .map((i) => ModelSearchGk.fromJson(i))
            .toList());
        if (mPullListView.other.containsKey('queryInfo')) {
          list.addAll((json.decode(mPullListView.other['queryInfo']) as List)
              .map((i) => ModelSearch.fromJson(i))
              .toList());
          mPullListView.other['queryInfo'] = json.encode(list);
        } else {
          mPullListView.other.addAll({"queryInfo": json.encode(list)});
        }
        mPullListView.reLoad();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
//    loadUrl(METHOD_GetImageNews, null, isShow: false);
    mPullListView = PullListView(
      methodName: widget.methodName,
      other: widget.other,
      mCallback: (methodName, res) {
        if (methodName == METHOD_OANEW) {
          ModelNewsList mModelNewsList = ModelNewsList.fromMap(res.data);
          List data = new List();
          mModelNewsList.rows.forEach((item) {
            data.add(new ItemNews(item));
          });
          return data;
        }
      },
    );
  }

  @override
  onSuccess(methodName, res) {
    if (methodName == METHOD_GetImageNews) {
      ModelBanner mModelBanner = ModelBanner.fromJson(res.data);
      List<Widget> data = new List();
      mModelBanner.rows.forEach((item) {
        data.add(CachedNetworkImage(
          imageUrl:
              "https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/whfpf%3D268%2C152%2C50/sign=1e121b741e3853438c9ad461f52e8248/8601a18b87d6277fb517da2026381f30e924fca5.jpg",
          cacheManager: Help.mImageCacheManager,
          fit: BoxFit.fill,
        ));
      });
      MyBanner mMyBanner = MyBanner(
          ScreenUtil.getScaleH(context, 140), METHOD_GetImageNews, data);
      mPullListView.head = mMyBanner;
      mPullListView.setState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return mPullListView;
  }
}
