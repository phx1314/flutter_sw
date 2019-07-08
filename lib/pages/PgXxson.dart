import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelSystemList.dart';
import 'package:flutter_std/model/ModelXtxxUnread.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/FontString.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

import '../Help.dart';
import 'PgXtgg.dart';
import 'PgXtxx.dart';

class PgXxson extends StatefulWidget {
  @override
  PgXxsonState createState() => new PgXxsonState();
}

class PgXxsonState extends BaseState<PgXxson>
    with AutomaticKeepAliveClientMixin {
  ModelXtxxUnread mModelXtxxUnread;
  ModelFlowList mModelFlowList;
  ModelSystemList mModelSystemList;

  @override
  void loadData() {
    loadUrl (METHOD_OANOTICE, null,
        isShow: false);
    loadUrl (METHOD_GetMessages, null,
        isShow: false);
    loadUrl (METHOD_GETLIST, {"status": "0"},
        isShow: false);
  }

  @override
  void onSuccess(String methodName, res) {
    if (methodName == METHOD_OANOTICE) {
      mModelFlowList = ModelFlowList.fromJson(res.data);
    } else if (methodName == METHOD_GetMessages) {
      mModelXtxxUnread = ModelXtxxUnread.fromJson(res.data);
      Help.sendMsg('PgHome', 2, mModelXtxxUnread.Total);
    } else if (methodName == METHOD_GETLIST) {
      mModelSystemList = ModelSystemList.fromJson(res.data);
    }
    reLoad();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Help.goWhere(context, PgXtgg());
            },
            child: Padding(
              // ignore: const_with_non_const
              padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: ScreenUtil.getScaleW(context, 30),
                    backgroundColor: Color.fromRGBO(238, 172, 46, 1),
                    child: Icon(
                      IconData(FontString.data['fa_volume_up'],
                          fontFamily: FontString.fontFamily),
                      size: ScreenUtil.getScaleW(context, 22),
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.all(ScreenUtil.getScaleW(context, 7))),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '系统公告',
                          style: Style.text_style_16_black,
                        ),
                        Padding(
                            padding: EdgeInsets.all(
                                ScreenUtil.getScaleW(context, 4))),
                        Text(
                          mModelFlowList != null &&
                                  mModelFlowList.rows.length > 0
                              ? mModelFlowList.rows[0].Title
                              : '',
                          style: Style.text_style_13_gray,
                        )
                      ],
                    ),
                  ),
                  Text(
                    mModelFlowList != null && mModelFlowList.rows.length > 0
                        ? mModelFlowList.rows[0].CreationTime
                        : '',
                    style: Style.text_style_13_gray,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil.getScaleW(context, 75)),
            child: Divider(height: 1),
          ),
          InkWell(
            onTap: (){
              Help.goWhere(context, PgXtxx());
            },
            child: Padding(
              // ignore: const_with_non_const
              padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: ScreenUtil.getScaleW(context, 30),
                    backgroundColor: Color.fromRGBO(227, 23, 37, 1),
                    child: Icon(
                      IconData(FontString.data['fa_bell_o'],
                          fontFamily: FontString.fontFamily),
                      size: ScreenUtil.getScaleW(context, 22),
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 7))),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '系统消息',
                          style: Style.text_style_16_black,
                        ),
                        Padding(
                            padding:
                                EdgeInsets.all(ScreenUtil.getScaleW(context, 4))),
                        Text(
                          mModelSystemList != null &&
                                  mModelSystemList.rows.length > 0
                              ? mModelSystemList.rows[0].MessTitle
                              : '',
                          style: Style.text_style_13_gray,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        mModelSystemList != null &&
                                mModelSystemList.rows.length > 0
                            ? Help.matchDate(mModelSystemList.rows[0].MessDate)
                            : '',
                        style: Style.text_style_13_gray,
                      ),
                      Padding(
                          padding:
                              EdgeInsets.all(ScreenUtil.getScaleW(context, 4))),
                      mModelXtxxUnread != null && mModelXtxxUnread.Total > 0
                          ? CircleAvatar(
                              radius: ScreenUtil.getScaleW(context, 10),
                              backgroundColor: Colors.red,
                              child: Text(
                                mModelXtxxUnread == null
                                    ? '0'
                                    : mModelXtxxUnread.Total.toString(),
                                style: Style.text_style_10_white,
                              ))
                          : Container(),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil.getScaleW(context, 75)),
            child: Divider(height: 1),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
