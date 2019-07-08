import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelYjDetail.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Help.dart';
import 'PgFileList.dart';
import 'PgSendEmail.dart';

class PgEmailDetail extends StatefulWidget {
  String id;
  int type;

  PgEmailDetail(this.id, this.type);

  @override
  PgEmailDetailState createState() => new PgEmailDetailState();
}

class PgEmailDetailState extends BaseState<PgEmailDetail> {
  ModelYjDetail mModelYjDetail;
  List<String> strs = List();
  bool isFinishEd = false;

  @override
  void initView() {
    if (widget.type == 1) strs.add('回复');
    strs.add('转发');
    strs.add(widget.type == 4 ? '恢复' : '删除');
    strs.add('彻底删除');
    strs.add('查看附件');
  }

  @override
  void loadData() {
    loadUrl(METHOD_OAMAILDETAIL,
        {"Id": widget.id, "ReceiveFlag": widget.type == 1 ? "1" : "0"});
    loadUrl(
        METHOD_UpdateReadByIds +
            widget.id +
            "_" +
            Help.mModelUser.UserInfo.EmpID.toString(),
        null,
        isShow: false,
        biaoshi: METHOD_UpdateReadByIds);
  }

  void deleteOmail(String id, String ischedi) {
    if (widget.type == 1 || widget.type == 4) {
      loadUrl(METHOD_OAMAILDEL, {"ids": id, "DelType": ischedi});
    } else {
      loadUrl(METHOD_OAMAILDELCG, {"ids": id, "DelType": ischedi});
    }
  }

  @override
  void onSuccess(String methodName, res) {
    if (methodName == METHOD_OAMAILDEL ||
        methodName == METHOD_OAMAILDELCG ||
        methodName == METHOD_OAHUIFU) {
      Help.sendMsg('PgEmailList,PgWode', 0, '');
      Help.Toast(context, '操作成功');
      finish();
    } else if (methodName == METHOD_UpdateReadByIds) {
      Help.sendMsg('PgWode', 0, '');
    } else if (methodName == METHOD_OAMAILDETAIL) {
      mModelYjDetail = ModelYjDetail.fromJson(res.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('邮件详情'),
            Visibility(
              child: Container(
                margin:
                    EdgeInsets.only(left: ScreenUtil.getScaleW(context, 10)),
                child: CupertinoActivityIndicator(),
              ),
              visible: !isFinishEd,
            )
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              size: ScreenUtil.getScaleW(context, 25),
            ),
            onPressed: () {
              Help.showPop(
                context,
                strs,
                (v) {
                  if (v == '查看附件') {
                    Help.goWhere(
                        context, PgFileList(widget.id, refTable_OaMail));
                  } else if (v == '回复') {
                    Help.goWhere(
                        context,
                        PgSendEmail(
                          id: widget.id,
                          name: mModelYjDetail.model.CreatorEmpName,
                        ));
                  } else if (v == '转发') {
                    Help.goWhere(context, PgSendEmail(id: widget.id));
                  } else if (v == '删除') {
                    deleteOmail(widget.id, "false");
                  } else if (v == '彻底删除') {
                    deleteOmail(widget.id, "true");
                  } else if (v == '恢复') {
                    loadUrl(METHOD_OAHUIFU_READ,
                        {"id": widget.id, "IsResum": "true"},
                        isShow: false);
                    loadUrl(
                        METHOD_OAHUIFU, {"id": widget.id, "IsResum": "true"},
                        isShow: false);
                  }
                },
                left: 1,
              );
            },
          ),
        ],
      ),
      body: WebView(
          onPageFinished: (f) {
            isFinishEd = true;
            reLoad();
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              "${Help.BASEURL}/oa/OaMailMobile/edit?id=${widget.id}&a=${Help.mModelUser.name}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}"),
    );
  }
}
