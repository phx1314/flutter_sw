import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemEmail.dart';
import 'package:flutter_std/model/ModelEmail.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelSearch.dart';
import 'package:flutter_std/model/ModelSearchGk.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_std/utils/PullListView.dart';

import 'PgSearch.dart';
import 'PgSendEmail.dart';

class PgEmailList extends StatefulWidget {
  int type;

  PgEmailList({this.type = 1});

  @override
  PgEmailListState createState() => new PgEmailListState();
}

class PgEmailListState extends BaseState<PgEmailList> {
  String method;
  bool isShow = false;
  List<String> data = ["收件箱", "发件箱", "草稿箱", "垃圾箱"];
  PullListView mPullListView;

  @override
  void disMsg(what, data) {
    switch (what) {
      case 0:
        mPullListView.reLoad();
        Help.sendMsg('PgWode', 0, '');
        break;
      case 110:
        RowsListBean item = data;
        delEmail(item.MailID.toString());
        break;
      case 888:
        mPullListView.other.addAll({"queryInfo": data.toString()});
        mPullListView.reLoad();
        break;
    }
  }

  @override
  void onSuccess(String methodName, res) {
    mPullListView.reLoad();
    Help.sendMsg('PgWode', 0, '');
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == 1) {
      method = METHOD_MAILRECEIVEJSON1;
    } else if (widget.type == 2) {
      method = METHOD_MAILRECEIVEJSON2;
    } else if (widget.type == 3) {
      method = METHOD_MAILRECEIVEJSON3;
    } else if (widget.type == 4) {
      method = METHOD_MAILRECEIVEJSON4;
    }

    mPullListView = PullListView(
      methodName: method,
      mCallback: (methodName, res) {
        ModelEmail mModelNewsList = ModelEmail.fromJson(res.data);
        List data = new List();
        mModelNewsList.rows.forEach((item) {
          data.add(new ItemEmail(item, widget.type));
        });
        return data;
      },
    );
  }

  void reFreash() {
    isShow = !isShow;
    if (widget.type == 1) {
      method = METHOD_MAILRECEIVEJSON1;
    } else if (widget.type == 2) {
      method = METHOD_MAILRECEIVEJSON2;
    } else if (widget.type == 3) {
      method = METHOD_MAILRECEIVEJSON3;
    } else if (widget.type == 4) {
      method = METHOD_MAILRECEIVEJSON4;
    }
    mPullListView.methodName = method;
    mPullListView.reLoad();
    reLoad();
  }

  void delEmail(String id) {
    if (widget.type == 1) {
      loadUrl(METHOD_OAMAILDEL, {"id": id, "DelType": "false"});
    } else if (widget.type == 4) {
      loadUrl(METHOD_OAMAILDEL, {"id": id, "DelType": "true"});
    } else {
      loadUrl(METHOD_OAMAILDELCG, {"id": id, "DelType": "false"});
    }
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
      child: new Scaffold(
          appBar: AppBar(
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
                    Text(data[widget.type - 1]),
                    Icon(isShow
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down)
                  ],
                ),
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
                  s1.text = "请输入标题";
                  s1.sqlstring =
                      '{"isGroup":false,"list":[{"Key":"FK_OaMailRead_Id.MailTitle,FK_OaMailRead_Id.CreatorEmpName","Contract":"like","Value":"#{value}"}]}';
                  SearchListBean s2 = new SearchListBean();
                  s2.type = "time_ymd";
                  s2.text = "请选择开始时间";
                  s2.sqlstring =
                      '{"isGroup":false,"list":[{"Key":"FK_OaMailRead_Id.MailDate","Contract":">=","filedType":"Date","Value":"#{value}"}]}';
                  SearchListBean s3 = new SearchListBean();
                  s3.type = "time_ymd";
                  s3.text = "请选择结束时间";
                  s3.sqlstring =
                      '{"isGroup":false,"list":[{"Key":"FK_OaMailRead_Id.MailDate","Contract":"<=","filedType":"Date","Value":"#{value}"}]}';
                  search.add(s1);
                  search.add(s2);
                  search.add(s3);
                  Help.goWhere(context, PgSearch(widget.toString(), search));
                },
              ),
            ],
          ),
          body: Container(
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
                            height: ScreenUtil.getScaleW(context, 185),
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
                                      widget.type = index + 1;
                                      reFreash();
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Help.goWhere(context, PgSendEmail());
            },
            child: Icon(Icons.add, size: ScreenUtil.getScaleW(context, 40)),
          )),
    );
  }
}
