import 'package:flutter/material.dart';
import 'package:flutter_std/item/ItemBase.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/PullListView.dart';

import '../Help.dart';

class PgXtgg extends StatefulWidget {
  @override
  PgXtggState createState() => new PgXtggState();
}

class PgXtggState extends BaseState<PgXtgg> {
  PullListView mPullListView;

  @override
  void initView() {
    mPullListView = PullListView(
      methodName: METHOD_OANOTICE,
      mCallback: (methodName, res) {
        ModelFlowList mModelFlowList = ModelFlowList.fromJson(res.data);
        List data = new List();
        mModelFlowList.rows.forEach((f) {
          data.add(ItemBase(f));
        });
        return data;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('系统公告'),
        centerTitle: true,
      ),
      body: mPullListView,
    );
  }
}
