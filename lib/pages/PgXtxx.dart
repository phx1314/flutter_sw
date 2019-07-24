import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/item/ItemXtxx.dart';
import 'package:flutter_std/model/ModelSystemList.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_std/utils/PullListView.dart';

import '../Help.dart';

class PgXtxx extends StatefulWidget {
  @override
  PgXtxxState createState() => new PgXtxxState();
}

class PgXtxxState extends BaseState<PgXtxx> {
  PullListView mPullListView;
  bool isShow = false;
  List<String> data = ["未读系统消息", "已读系统消息"];
  int status = 0;

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        mPullListView.reLoad();
        break;
    }
  }

  @override
  void initView() {
    mPullListView = PullListView(
      methodName: METHOD_GETLIST,
      other: {"status": "0"},
      mCallback: (methodName, res) {
        ModelSystemList mModelSystemList = ModelSystemList.fromJson(res.data);
        List data = new List();
        mModelSystemList.rows.forEach((item) {
          data.add(new ItemXtxx(item));
        });
        return data;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (isShow) {
            isShow = !isShow;
            reLoad();
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: new AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: InkWell(
                onTap: () {
                  isShow = !isShow;
                  reLoad();
                },
                child: Container(
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(data[status],style: Style.text_style_16_black,),

                      Icon(isShow
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,color:  Colors.black,)
                    ],
                  ),
                )),
            centerTitle: true,
          ),
          body: Container(
            color:  Colors.white,
            child: Stack(
              children: <Widget>[
                mPullListView,
                Visibility(
                    visible: isShow,
                    child: Container(
                      width: double.infinity,
                      color: Color(0x66000000),
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            height: ScreenUtil.getScaleW(context, 100),
                            child: ListView.separated(
                              itemCount: data.length,
                              separatorBuilder: (context, index) => Divider(
                                    height: 1,
                                  ),
                              // 添加分割线
                              itemBuilder: (context, index) {
                                return Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      status = index;
                                      mPullListView.other['status'] =
                                          index.toString();
                                      mPullListView.reLoad();
                                      isShow = !isShow;
                                      reLoad();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: ScreenUtil.getScaleW(context, 45),
//                                    padding: EdgeInsets.all(
//                                        ScreenUtil.getScaleW(context,30)),
                                      child: Text(
                                        data[index],
                                        style: Style.text_style_16_black,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    isShow = false;
                                    reLoad();
                                  },
                                  child: Container())),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
