import 'dart:convert';
import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemFlow.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelSearchGk.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_std/utils/PullListView.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PgBd extends StatefulWidget {
  @override
  PgBdState createState() => new PgBdState();
}

class PgBdState extends BaseState<PgBd> {
  String statusID = "1";
  String modular = "2";
  PullListView mPullListView;

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        mPullListView.reLoad();
        break;
      case 888:
        List list = (json.decode(data.toString()) as List)
            .map((i) => ModelSearchGk.fromJson(i))
            .toList();
        ModelSearchGk mModelSearchGk = list[0];
        mPullListView.other.addAll({"text": mModelSearchGk.list[0].Value});
        mPullListView.reLoad();
        break;
    }
  }

  @override
  void initView() {
    mPullListView = PullListView(
      haline: false,
      isFirstLoad: false,
      methodName: METHOD_GetToDoList,
      other: {
        "statusID": statusID,
        "modular": modular,
      },
      mCallback: (methodName, res) {
        ModelFlowList mModelFlowList = ModelFlowList.fromJson(res.data);
        List data = new List();
        mModelFlowList.rows.forEach((f) {
          data.add(ItemFlow(f, statusID));
          for (int j = 0; j < Help.mModelWorkBeans.length; j++) {
            if (Help.mModelWorkBeans[j].MenuMobileConfig
                    .contains(f.FlowRefTable) &&
                f.FlowRefTable ==
                    Help.mModelWorkBeans[j].mModelMenuConfig.flow.refTable) {
              f.text = Help.mModelWorkBeans[j].text;
              f.mModelMenuConfig = ModelMenuConfig.fromJson(json.decode(
                  Help.getRightdata(
                      Help.mModelWorkBeans[j].MenuMobileConfig, f.toJson())));
              break;
            }
          }
        });
        return data;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    showLefPop();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          modular == '0'
                              ? '全部'
                              : modular == '1' ? '项目表单' : '办公表单',
                          style: Style.text_style_16_gray,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: ScreenUtil.getScaleW(context, 1),
                color: Color(0xFFE0E0E0),
                height: ScreenUtil.getScaleW(context, 40),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    showRightPop();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          statusID == '1' ? '未审批' : '已审批',
                          style: Style.text_style_16_gray,
                        ),
                        Icon(Icons.keyboard_arrow_down, color: Colors.grey)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            height: ScreenUtil.getScaleW(context, 1),
          ),
          Expanded(
            child: mPullListView,
          )
        ],
      ),
    );
  }

  void showLefPop() async {
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
            0,
            MediaQueryData.fromWindow(window).padding.top +
                AppBar().preferredSize.height +
                ScreenUtil.getScaleW(context, 45),
            0,
            0),
        items: <PopupMenuEntry<String>>[
//          PopupMenuItem<String>(
//            value: "0",
//            child: Container(
//                width: ScreenUtil.getScaleW(context, 100), child: Text('全部')),
//          ),
//          PopupMenuDivider(height: 1.0),
          PopupMenuItem<String>(value: "1", child: Text('项目表单')),
          PopupMenuDivider(height: 1.0),
          PopupMenuItem<String>(value: "2", child: Text('办公表单')),
        ]).then((v) {
      if (v == null) return;
      modular = v.toString();
      mPullListView.other = {"statusID": statusID, "modular": modular};
      mPullListView.reLoad();
      reLoad();
    });
  }

  void showRightPop() async {
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
            ScreenUtil.getScaleW(context, 100),
            MediaQueryData.fromWindow(window).padding.top +
                AppBar().preferredSize.height +
                ScreenUtil.getScaleW(context, 45),
            0,
            0),
        items: <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: "1",
            child: Container(
                width: ScreenUtil.getScaleW(context, 100), child: Text('未审批')),
          ),
          PopupMenuDivider(height: 1.0),
          PopupMenuItem<String>(value: "2", child: Text('已审批')),
        ]).then((v) {
      if (v == null) return;
      statusID = v.toString();
      mPullListView.other = {"statusID": statusID, "modular": modular};
      mPullListView.reLoad();
      reLoad();
    });
  }
}
