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
  String listtype = "1";
  Map<String, String> map = {
    'BussProjCirculation': '深化流转单',
    'BussBiddingEstimateCost': '成本估算',
    'BussBiddingCost': '成本统计',
    'BussContract': '合同信息'
  };
  String reftable = "BussProjCirculation";
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
        "listtype": listtype,
        "reftable": reftable,
      },
      mCallback: (methodName, res) {
        ModelFlowList mModelFlowList = ModelFlowList.fromJson(res.data);
        List data = new List();
        mModelFlowList.rows.forEach((f) {
          data.add(ItemFlow(f, listtype));
          f.text=f.FlowName;
          f.mModelMenuConfig = ModelMenuConfig.fromJson(json
              .decode(Help.getRightdata(Help.mMap_bd[reftable], f.toJson())));
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
                          map[reftable],
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
                          listtype == '1' ? '待我审批' : '经我审批',
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
          PopupMenuItem<String>(
              value: "BussProjCirculation",
              child: Text(map['BussProjCirculation'])),
          PopupMenuDivider(height: 1.0),
          PopupMenuItem<String>(
              value: "BussBiddingEstimateCost",
              child: Text(map['BussBiddingEstimateCost'])),
          PopupMenuDivider(height: 1.0),
          PopupMenuItem<String>(
              value: "BussBiddingCost", child: Text(map['BussBiddingCost'])),
          PopupMenuDivider(height: 1.0),
          PopupMenuItem<String>(
              value: "BussContract", child: Text(map['BussContract'])),
        ]).then((v) {
      if (v == null) return;
      reftable = v.toString();
      mPullListView.other = {"listtype": listtype, "reftable": reftable};
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
                width: ScreenUtil.getScaleW(context, 100), child: Text('待我审批')),
          ),
          PopupMenuDivider(height: 1.0),
          PopupMenuItem<String>(value: "2", child: Text('经我审批')),
        ]).then((v) {
      if (v == null) return;
      listtype = v.toString();
      mPullListView.other = {"listtype": listtype, "reftable": reftable};
      mPullListView.reLoad();
      reLoad();
    });
  }
}
