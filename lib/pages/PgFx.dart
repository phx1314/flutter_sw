import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/pages/PgBd.dart';
import 'package:flutter_std/utils/BaseState.dart';

import 'PgRc.dart';
import 'PgSearch.dart';

class PgFx extends StatefulWidget {
  @override
  PgFxState createState() => new PgFxState();
}

class PgFxState extends BaseState<PgFx> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '发现',
          ),
          leading: Builder(
            builder: (context) => IconButton(
                  icon: Icon(Icons.crop_free,
                      size: ScreenUtil.getScaleW(context, 25)),
                  onPressed: () {
                    Help.scan(context);
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
                s1.text = "请输入标题、流程名称";
                s1.sqlstring =
                '{"isGroup":false,"list":[{"Key":"keytext","Contract":"like","Value":"#{value}"}]}';
                SearchListBean s2 = new SearchListBean();
                s2.type = "time_ymd";
                s2.text = "请选择开始时间";
                s2.sqlstring =
                '{"isGroup":false,"list":[{"Key":"FlowTimeS","Contract":">=","filedType":"Date","Value":"#{value}"}]}';
                SearchListBean s3 = new SearchListBean();
                s3.type = "time_ymd";
                s3.text = "请选择结束时间";
                s3.sqlstring =
                '{"isGroup":false,"list":[{"Key":"FlowTimeE","Contract":"<=","filedType":"Date","Value":"#{value}"}]}';
                search.add(s1);
                search.add(s2);
                search.add(s3);
                Help.goWhere(context, PgSearch('PgBd', search));
              },
            ),
          ],
          centerTitle: true,
        ),
        body: TabBarView(
          children: [PgBd()],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
