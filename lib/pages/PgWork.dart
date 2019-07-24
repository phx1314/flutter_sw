import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemWork.dart';
import 'package:flutter_std/model/ModelWork.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/PullListView.dart';

class PgWork extends StatefulWidget {
  @override
  PgWorkState createState() => new PgWorkState();
}

class PgWorkState extends BaseState<PgWork> {
  PullListView mPullListView;

  @override
  void initView() {
    mPullListView = PullListView(
      haline: false,
      methodName: METHOD_GetWork,
      mCallback: (methodName, res) {
        ModelWork mModelWork = ModelWork.fromJson(res.data);
        List data = new List();
        mModelWork.rows.forEach((f) {
          data.add(ItemWork(f));
        });
        return data;
      },
      loadMoreEnable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          '工作',
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
        centerTitle: true, //标题是否居中，默认为false
      ),
      body: mPullListView,
    );
  }
}
