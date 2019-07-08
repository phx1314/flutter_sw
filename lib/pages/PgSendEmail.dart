import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFjList.dart';
import 'package:flutter_std/model/ModelUser.dart';
import 'package:flutter_std/model/ModelYjDetail.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

import 'PgFileList.dart';
import 'PgFileListEdit.dart';
import 'PgXzry.dart';

class PgSendEmail extends StatefulWidget {
  String id;
  int type;
  String name;

  PgSendEmail({this.id, this.name, this.type = 1});

  @override
  PgSendEmailState createState() => new PgSendEmailState();
}

class PgSendEmailState extends BaseState<PgSendEmail> {
  List<String> strs = List();
  ModelYjDetail mModelYjDetail;
  ModelFjList mModelFjList = new ModelFjList();
  String ids = '';
  String name = '请选择收件人';
  String Title = '';
  bool isChecked = false;
  TextEditingController mTextEditingController1;

  TextEditingController mTextEditingController2 = new TextEditingController();

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 101:
        name = Help.getNames(data);
        ids = Help.getIDs(data);
        break;
    }
  }

  @override
  void initView() {
    strs.add('立即发送');
    strs.add('存为草稿');
    if (widget.type == 3) strs.add('删除');
    if (widget.type == 3) strs.add('彻底删除');
    mTextEditingController1 = new TextEditingController(text: Title);
    mModelFjList.rows = new List();
  }

  @override
  void loadData() {
    if (widget.name != null) {
      loadUrl(METHOD_OAMAILDETAIL, {"Id": widget.id, "ReceiveFlag": "0"});
    } else if (widget.id != null) {
      if (widget.type == 3) {
        loadUrl(METHOD_GETATTACHFILES,
            {"refID": widget.id, "refTable": refTable_OaMail},
            isShow: false);
      }
      loadUrl(METHOD_OAMAILDETAIL,
          {"Id": widget.id, "ReceiveFlag": "0", "type": "1"});
    }
  }

  @override
  void onSuccess(String methodName, res) {
    if (methodName == METHOD_OAMAILDETAIL) {
      mModelYjDetail = ModelYjDetail.fromJson(res.data);
      if (widget.name != null) {
        Title = "【回复】" + mModelYjDetail.model.MailTitle;
        name = mModelYjDetail.model.CreatorEmpName;
        ids = mModelYjDetail.model.CreatorEmpId.toString();
      } else if (widget.type == 3) {
        Title = mModelYjDetail.model.MailTitle;
        name = mModelYjDetail.SendEmp;
        ids = mModelYjDetail.SendEmpID + "";
      } else {
        Title = "【转发】" + mModelYjDetail.model.MailTitle;
        isChecked = mModelYjDetail.model.MailIsBBC == 0;
        mModelYjDetail.AttachData.forEach((item) {
          DataBean mRowsBean = new DataBean();
          mRowsBean.IDD = item.FileName;
          mRowsBean.LastModifyDate = item.LastModifiedTime;
          mRowsBean.Size = int.parse(item.Size);
          mRowsBean.Name = item.RealName;
          mRowsBean.UploadDate = item.UploadTime;
          mRowsBean.EmpName = item.EmpName;
          mModelFjList.rows.add(mRowsBean);
        });
      }
      reLoad();
    } else if (methodName == METHOD_GETATTACHFILES) {
      mModelFjList = ModelFjList.fromJson(json.decode(res.json));

      reLoad();
    } else if (methodName == METHOD_OAMAIL) {
      Help.sendMsg('PgEmailList', 0, '');
      Help.Toast(context, '成功');
      finish();
    } else if (methodName == METHOD_OAMAILDELCG) {
      Help.sendMsg('PgEmailList', 0, '');
      Help.Toast(context, '删除成功');
      finish();
    }
  }

  void saveData(int type) {
    if (ids.isEmpty) {
      Help.Toast(context, "请选择收件人");
      return;
    }
    if (mTextEditingController1.text.isEmpty) {
      Help.Toast(context, "请输入主题");
      return;
    }
    String uploadFile = '';
    uploadFile += "&lt;Root&gt;&lt;Files RefTable=\"OaMail\"&gt;&lt;";
    mModelFjList.rows.forEach((mRowsBean) {
      uploadFile += "File FileName=\"" +
          mRowsBean.Name +
          "\" LastModifiedTime=\"" +
          Help.getCurrentTime(type: 1) +
          "\"&gt;" +
          mRowsBean.IDD +
          "&lt;/File&gt;&lt;";
    });
    uploadFile += "/Files&gt;&lt;/Root&gt;";
    loadUrl(METHOD_OAMAIL, {
      "Id": widget.type == 3 ? widget.id : "0",
      "MailFlag": type.toString(),
      "TypeID": widget.type == 3 ? "3" : "0",
      "SendEmp": name,
      "MailTitle": mTextEditingController1.text,
      "MailNote": mTextEditingController2.text,
      "MailIsBBC": type == 1 ? "" : (isChecked ? "0" : "1"),
      "MailDate": Help.getCurrentTime(),
      "\$uplohad\$_cache_y12\$t1m": uploadFile
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(() {
          if (widget.name != null) {
            return "回复邮件";
          } else if (widget.type == 3) {
            return "草稿邮件";
          } else if (widget.id != null) {
            return "转发邮件";
          } else {
            return "写邮件";
          }
        }()),
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
                  if (v == '立即发送') {
                    saveData(0);
                  } else if (v == '存为草稿') {
                    saveData(1);
                  } else if (v == '删除') {
                    loadUrl(METHOD_OAMAILDELCG,
                        {"ids": widget.id, "DelType": "false"});
                  } else if (v == '彻底删除') {
                    loadUrl(METHOD_OAMAILDELCG,
                        {"ids": widget.id, "DelType": "true"});
                  }
                },
                left: 1,
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color(GSYColors.f2f2f2),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 8),
              height: ScreenUtil.getScaleW(context, 50),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Style.text_style_16_black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Help.goWhere(
                          context,
                          PgXzry(
                            widget.toString(),
                            ids: ids,
                          ));
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.blue,
                      size: ScreenUtil.getScaleW(context, 25),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 8),
              height: ScreenUtil.getScaleW(context, 50),
              child: TextField(
                style: Style.text_style_16_black,
                controller: mTextEditingController1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.all(ScreenUtil.getScaleW(context, 5)),
                  hintText: '请输入主题',
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              height: ScreenUtil.getScaleW(context, 100),
              child: TextField(
                style: Style.text_style_16_black,
                controller: mTextEditingController2,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.all(ScreenUtil.getScaleW(context, 5)),
                  hintText: '请输入',
                ),
              ),
            ),
            Container(
              height: ScreenUtil.getScaleW(context, 15),
              color: Color(GSYColors.f2f2f2),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 8),
              height: ScreenUtil.getScaleW(context, 50),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '是否密送',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Style.text_style_16_black,
                    ),
                  ),
                  Checkbox(
                      value: isChecked,
                      onChanged: (bool newValue) {
                        isChecked = newValue;
                        reLoad();
                      })
                ],
              ),
            ),
            Container(
              height: ScreenUtil.getScaleW(context, 20),
              color: Color(GSYColors.f2f2f2),
            ),
            InkWell(
              onTap: () {
                Help.goWhere(
                    context,
                    PgFileListEdit(widget.id, refTable_OaMail,
                        widget.toString(), mModelFjList.rows));
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                height: ScreenUtil.getScaleW(context, 50),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '附件列表',
                        style: Style.text_style_16_black,
                      ),
                    ),
                    CircleAvatar(
                      radius: ScreenUtil.getScaleW(context, 23),
                      backgroundColor: Colors.red,
                      child: Text(
                        mModelFjList.rows == null
                            ? '0'
                            : mModelFjList.rows.length.toString(),
                        style: Style.text_style_13_white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          finish();
        },
        child: Icon(Icons.close, size: ScreenUtil.getScaleW(context, 40)),
        backgroundColor: Colors.red,
      ),
    );
  }
}
