import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/pages/PgGzjd.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class ItemFlow extends StatelessWidget {
  RowsListBean item;
  List<Widget> mWidgets = List();
  String statusID;

  ItemFlow(this.item, this.statusID);

  @override
  Widget build(BuildContext context) {
    try {
      mWidgets.clear();
      List responseJson = json.decode(item.FlowSummary);
      responseJson.forEach((f) {
        mWidgets.add(Padding(
          padding: EdgeInsets.only(top: ScreenUtil.getScaleW(context, 5)),
          child: Text(
            '${f['Key']}  :  ${f['Value']}',
            style: Style.text_style_13_gray,
            softWrap: true,
          ),
        ));
      });
    } catch (e) {
      print(e);
    }

//    List<ModelSummary> data =
//        responseJson.map((m) => new ModelSummary.fromJson(m)).toList();

    return Container(
      padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: ScreenUtil.getScaleW(context, 27),
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("static/images/morentouxiang_n.png"),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil.getScaleW(context, 12),
                      top: ScreenUtil.getScaleW(context, 5)),
                  child: Text(
                    item.CreatorEmpName ?? '',
                    style: Style.text_style_13_gray,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(236, 236, 236, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
//                          offset: Offset(ScreenUtil.getScaleW(context, 1),
//                              ScreenUtil.getScaleW(context, 1)),
                        blurRadius: ScreenUtil.getScaleW(context, 1),
//                          spreadRadius: ScreenUtil.getScaleW(context, 1)
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil.getScaleW(context, 4))),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.text??item.FlowName??'',
                              style: Style.text_style_16_black,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: mWidgets,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 250, 250, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                  ScreenUtil.getScaleW(context, 4)),
                              bottomRight: Radius.circular(
                                  ScreenUtil.getScaleW(context, 4))),
                        ),
                        height: ScreenUtil.getScaleW(context, 40),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Help.goWhere(
                                    context,
                                    PgGzjd(item.FlowID == null
                                        ? '0'
                                        : item.FlowID.toString()));
                              },
                              child: Center(
                                child: Text(
                                  '查看进度',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )),
                            Container(
                              width: 1,
                              height: double.infinity,
                              color: Color.fromRGBO(236, 236, 236, 1),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (item.mModelMenuConfig != null){
                                    Help.go2PubView(context, item, statusID);
                                  }else{
                                    Help.Toast(context, '请到PC端操作');
                                  }

                                },
                                child: Center(
                                    child: Text(
                                  item.FlowStatusName ?? "查看详情",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                )),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
