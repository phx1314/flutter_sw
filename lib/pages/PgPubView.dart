import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemDialogSub.dart';
import 'package:flutter_std/model/ModelFjList.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelJDInfo.dart';
import 'package:flutter_std/model/ModelUploadFile.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'PgFileList.dart';
import 'PgFileListEdit.dart';
import 'PgGzjd.dart';
import 'PgHtList.dart';
import 'PgXmList.dart';

//  https://github.com/tiagojencmartins/unicornspeeddial
class PgPubView extends StatefulWidget {
  RowsListBean item;
  String statusID;

  PgPubView(this.item, this.statusID);

  @override
  PgPubViewState createState() => new PgPubViewState();
}

class PgPubViewState extends BaseState<PgPubView> {
  String title;
  String url;
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();
  RaisedButton mRaisedButton_tj;
  RaisedButton mRaisedButton_bc;
  RaisedButton mRaisedButton_zc;
  RaisedButton mRaisedButton_back;
  RaisedButton mRaisedButton_yj;
  RaisedButton mRaisedButton_fj;
  RaisedButton mRaisedButton_finishi;
  RaisedButton mRaisedButton_hr;
  List<Widget> children = List();
  ModelJDInfo mModelJDInfo;
  Map<String, dynamic> map_json;
  bool isFinish = false;
  ModelUploadFile mModelUpload;
  List<String> mRefTables = List();
  List<DataBean> mModelWenjianUploads = new List();

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        flutterWebViewPlugin.evalJavascript(
            "${map_json['Method']}('${data.toString().replaceAll('\'', '')}')");
        break;
      case 300:
        Map<String, dynamic> map = data;
        map['_processor'] = widget.item.mModelMenuConfig.flow.processor;
        if (mModelWenjianUploads.length > 0) {
          String uploadFile = "&lt;Root&gt;";
          mRefTables.forEach((reftable) {
            uploadFile += "&lt;Files RefTable=\"$reftable\"&gt;";
            mModelWenjianUploads.forEach((mRowsBean) {
              if (mRowsBean.RefTable == reftable &&
                  mRowsBean.IDD != null &&
                  mRowsBean.IDD != '') {
                uploadFile +=
                    "&lt;File FileName=\"${mRowsBean.Name}\" LastModifiedTime=\"${Help.getCurrentTime(type: 1)}\"&gt;${mRowsBean.IDD}&lt;/File&gt;";
              }
            });
            uploadFile += "&lt;/Files&gt;";
          });
          uploadFile += "&lt;/Root&gt;";
          map["\$uplohad\$_cache_y12\$t1m"] = uploadFile;
        }
        map_json.addAll(map);
        loadUrl(METHOD_FLOWWIDGET, map_json);
        break;
      case 889:
        if (defaultTargetPlatform == TargetPlatform.android)
          flutterWebViewPlugin.resize(Rect.fromLTRB(
              0,
              MediaQueryData.fromWindow(window).padding.top +
                  AppBar().preferredSize.height,
              MediaQuery.of(context).size.width,
              data
                  ? MediaQuery.of(context).size.height -
                      ScreenUtil.getScaleW(context, 270)
                  : MediaQuery.of(context).size.height -
                      ScreenUtil.getScaleW(context, 50)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).isCurrent) {
      flutterWebViewPlugin?.show();
      print("显示" + ModalRoute.of(context).toString());
    } else {
      flutterWebViewPlugin?.hide();
      print("隐藏" + ModalRoute.of(context).toString());
    }
    return WebviewScaffold(
      withJavascript: true,
      clearCache: true,
      clearCookies: true,
      url: url,
      //      url:"http://192.170.0.7/GoldPM9_hncsxy/oa/OaCarmobile/add?a=%E9%99%88%E9%9C%B2&p=1A1DC91C907325C69271DDF0C944BC72",
      initialChild: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Center(
                    child: CupertinoActivityIndicator(
                      animating: true,
                    ),
                  ),
                ),
              ),
              () {
                if (isFinish) {
                  return Container();
                } else {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Divider(
                          height: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: ScreenUtil.getScaleW(context, 7)),
                          child: Row(
                            children: children,
                          ),
                        )
                      ],
                    ),
                  );
                }
              }()
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.item.text),
        centerTitle: true,
        actions: <Widget>[
          Visibility(
            visible: null != widget.item.mModelMenuConfig.flow.processor &&
                "" != widget.item.mModelMenuConfig.flow.processor,
            child: InkWell(
              onTap: () {
                Help.goWhere(
                    context,
                    PgGzjd(widget.item.FlowID == null
                        ? '0'
                        : widget.item.FlowID.toString()));
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  '查看进度',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  onSuccess(String methodName, res) {
    if (methodName == 'getApi') {
      mModelJDInfo = ModelJDInfo.fromJson(json.decode(res.json));
      if (widget.item.mModelMenuConfig.flow.isShowSave &&
          mModelJDInfo.StepOrder == 1) {
        addButton(mRaisedButton_zc);
      }
      if (((mModelJDInfo?.IsFinished || mModelJDInfo?.IsFlowFinished)) ||
          widget.statusID == '2') {
        isFinish = true;
      } else {
        flutterWebViewPlugin.resize(Rect.fromLTRB(
            0,
            MediaQueryData.fromWindow(window).padding.top +
                AppBar().preferredSize.height,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height -
                (isFinish
                    ? 0
                    : ScreenUtil.getScaleW(
                        context, 50 + MediaQuery.of(context).padding.bottom))));
      }

      mModelJDInfo.AllowEditControls = widget.statusID == '0'
          ? ""
          : mModelJDInfo.AllowEditControls == null
              ? ''
              : mModelJDInfo.AllowEditControls.replaceAll(",", ";");
      mModelJDInfo.SignDatas = mModelJDInfo.SignDatas?.replaceAll("\"", "\\\"");
      widget.item.IsNew = mModelJDInfo.IsNew;
      widget.item.FlowNodeID = mModelJDInfo.FlowNodeID;
      widget.item.FlowMultiSignID = mModelJDInfo.FlowMultiSignID;
      widget.item.FlowID = mModelJDInfo.FlowID;

      if (mModelJDInfo.NextAction > 0) {
        children.insert(0, Padding(padding: EdgeInsets.all(2)));
        children.insert(1, Expanded(child: mRaisedButton_tj));
      }
      if (mModelJDInfo.BackAction > 0) {
        addButton(mRaisedButton_back);
      }
      if (!mModelJDInfo.IsNew) {
        addButton(mRaisedButton_yj);
      }
      if (mModelJDInfo.RejectAction > 0) {
        addButton(mRaisedButton_fj);
      }
      if (mModelJDInfo.FinishAction > 0) {
        addButton(mRaisedButton_finishi);
      }
      if (mModelJDInfo.ChangeAction > 0) {
        addButton(mRaisedButton_hr);
      }
      flutterWebViewPlugin.evalJavascript(
          "initFormBegin('${json.encode(mModelJDInfo.toJson())}')");
      reLoad();
    } else if (methodName == METHOD_GETATTACHFILES) {
      ModelFjList mModelFjList = ModelFjList.fromJson(json.decode(res.json));
      mModelFjList.rows.forEach((f) {
        f.RefTable = mModelUpload.RefTable;
      });
      mModelWenjianUploads.addAll(mModelFjList.rows);
      goDie();
    } else {
      Fluttertoast.showToast(msg: "处理成功");
      Help.sendMsg('PgFlowList,PgBd', 0, '');
      Help.sendMsg('PgHome', 6, '');
      Help.sendMsg('PgGjkh', 4, '');
      finish();
    }
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  void addButton(RaisedButton mRaisedButton) {
    children.add(Padding(padding: EdgeInsets.all(2)));
    children.add(Expanded(child: mRaisedButton));
    reLoad();
  }

  @override
  void initView() {
    url = widget.item.Id != 0
        ? "${Help.BASEURL}/${widget.item.mModelMenuConfig.grid.editUrl[0]}&a=${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}"
        : "${Help.BASEURL}/${widget.item.mModelMenuConfig.grid.addUrl[0]}" +
            (widget.item.mModelMenuConfig.grid.addUrl[0].contains('?')
                ? '&a='
                : '?a=') +
            "${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}";
    print(url);
    mRaisedButton_tj = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_next';
        title = '提交';
        flutterWebViewPlugin.evalJavascript("validateFormBegin()");
      },
      child: Text(
        '提交',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_bc = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_next';
        title = '保存';
        flutterWebViewPlugin.evalJavascript("validateFormBegin()");
      },
      child: Text(
        '保存',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_zc = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'save';
        title = '暂存';
        flutterWebViewPlugin.evalJavascript("validateFormBegin()");
      },
      child: Text(
        '暂存',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_back = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_back';
        title = '回退';
        flutterWebViewPlugin.evalJavascript("noValidateFormBegin()");
      },
      child: Text(
        '回退',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_yj = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_transfer';
        title = '移交';
        flutterWebViewPlugin.evalJavascript("noValidateFormBegin()");
      },
      child: Text(
        '移交',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_fj = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_reject';
        title = '否决';
        flutterWebViewPlugin.evalJavascript("noValidateFormBegin()");
      },
      child: Text(
        '否决',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_finishi = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_finish';
        title = '直接完成';
        flutterWebViewPlugin.evalJavascript("validateFormBegin()");
      },
      child: Text(
        '完成',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    mRaisedButton_hr = RaisedButton(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      padding: EdgeInsets.all(10),
      color: Colors.lightBlue,
      onPressed: () {
        widget.item.action = 'load_change';
        title = '换人';
        flutterWebViewPlugin.evalJavascript("noValidateFormBegin()");
      },
      child: Text(
        '换人',
        style: Style.text_style_13_white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  void go2Where(String type) {
    try {
      if (type == '001') {
        if (title == '保存') {
          if (mModelWenjianUploads.length > 0) {
            String uploadFile = "&lt;Root&gt;";
            mRefTables.forEach((reftable) {
              uploadFile += "&lt;Files RefTable=\"" + reftable + "\"&gt;";
              mModelWenjianUploads.forEach((mRowsBean) {
                if (mRowsBean.RefTable == reftable &&
                    mRowsBean.IDD != null &&
                    mRowsBean.IDD != '') {
                  uploadFile +=
                      "&lt;File FileName=\"${mRowsBean.Name}\" LastModifiedTime=\"${Help.getCurrentTime(type: 1)}\"&gt;${mRowsBean.IDD}&lt;/File&gt;";
                }
              });
              uploadFile += "&lt;/Files&gt;";
            });
            uploadFile += "&lt;/Root&gt;";
            map_json["\$uplohad\$_cache_y12\$t1m"] = uploadFile;
          }
          loadUrl(widget.item.mModelMenuConfig.grid.saveUrl[0], map_json);
        } else if (title == '暂存') {
          Map<String, dynamic> map = new Map();
          map['_refID'] = widget.item.Id;
          map['_refTable'] = widget.item.FlowRefTable;
          map['_flowNodeID'] = widget.item.FlowNodeID;
          map['_action'] = widget.item.action;
          map['_flowMultiSignID'] = widget.item.FlowMultiSignID;
          map['_processor'] = widget.item.mModelMenuConfig.flow.processor;
          if (mModelWenjianUploads.length > 0) {
            String uploadFile = "&lt;Root&gt;";
            mRefTables.forEach((reftable) {
              uploadFile += "&lt;Files RefTable=\"" + reftable + "\"&gt;";
              mModelWenjianUploads.forEach((mRowsBean) {
                if (mRowsBean.RefTable == reftable &&
                    mRowsBean.IDD != null &&
                    mRowsBean.IDD != '') {
                  uploadFile +=
                      "&lt;File FileName=\"${mRowsBean.Name}\" LastModifiedTime=\"${Help.getCurrentTime(type: 1)}\"&gt;${mRowsBean.IDD}&lt;/File&gt;";
                }
              });
              uploadFile += "&lt;/Files&gt;";
            });
            uploadFile += "&lt;/Root&gt;";
            map["\$uplohad\$_cache_y12\$t1m"] = uploadFile;
          }
          map_json.addAll(map);
          loadUrl(METHOD_FLOWWIDGET, map_json);
        } else {
          FocusScope.of(context).requestFocus(FocusNode());
          flutterWebViewPlugin?.hide();
          Help.showMyDialog(
                  context,
                  ItemDialogSub(
                      widget.toString(),
                      title,
                      widget.item,
                      widget.item.action == 'load_reject' ||
                          widget.item.action == 'load_finish'))
              .then((v) {
            flutterWebViewPlugin?.show();
          });
        }
      } else if (type == '006') {
        mModelUpload = ModelUploadFile.fromJson(map_json);
        if (widget.item.Id != 0 &&
            !mRefTables.contains(mModelUpload.RefTable)) {
          loadUrl(METHOD_GETATTACHFILES,
              {"refID": widget.item.Id, "refTable": mModelUpload.RefTable});
        } else {
          goDie();
        }
        if (!mRefTables.contains(mModelUpload.RefTable)) {
          mRefTables.add(mModelUpload.RefTable);
        }
      } else if (type == '003') {
        Help.goWhere(
            context,
            widget.item.MenuNameEng == 'ProjInfoRegister'
                ? PgHtList()
                : PgXmList(widget.item.MenuNameEng));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void goDie() {
    if ((mModelJDInfo != null && mModelJDInfo.StepOrder != 1)) {
      Help.goWhere(context,
          PgFileList(widget.item.Id.toString(), mModelUpload.RefTable));
    } else {
      Help.goWhere(
          context,
          PgFileListEdit(widget.item.Id.toString(), mModelUpload.RefTable,
              widget.toString(), mModelWenjianUploads));
    }
  }

  @override
  void loadData() {
    widget.item.refTable_file =
        widget.item.FlowRefTable = widget.item.mModelMenuConfig.flow.refTable;
    try {
      if (widget.item.mModelMenuConfig.uploaders != null &&
          widget.item.mModelMenuConfig.uploaders.length > 0) {
        widget.item.refTable_file =
            widget.item.mModelMenuConfig.uploaders[0].refTable;
      }
    } catch (e) {
      print(e);
    }
    flutterWebViewPlugin.onChannel.listen((data) {
      print(data);
      map_json = json.decode(data);
      go2Where(map_json['type']);
    });
    flutterWebViewPlugin.onDestroy.listen((aa) {
      Navigator.pop(context);
    });
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        flutterWebViewPlugin?.show();
        if (widget.item.IsSave != null && widget.item.IsSave) {
          addButton(mRaisedButton_bc);
          flutterWebViewPlugin.resize(Rect.fromLTRB(
              0,
              MediaQueryData.fromWindow(window).padding.top +
                  AppBar().preferredSize.height,
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height -
                  (ScreenUtil.getScaleW(
                      context, 50 + MediaQuery.of(context).padding.bottom))));
          return;
        }
        if (null != widget.item.mModelMenuConfig.flow.processor &&
            "" != widget.item.mModelMenuConfig.flow.processor) {
          loadUrl(
              METHOD_FLOWWIDGET,
              {
                "_refID": widget.item.Id.toString(),
                "_refTable": widget.item.FlowRefTable,
                "_flowNodeID": 0,
                "_action": "load",
                "_flowMultiSignID": 0
              },
              isShow: false,
              biaoshi: "getApi");
        } else {
          addButton(mRaisedButton_bc);
          flutterWebViewPlugin.resize(Rect.fromLTRB(
              0,
              MediaQueryData.fromWindow(window).padding.top +
                  AppBar().preferredSize.height,
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height -
                  (ScreenUtil.getScaleW(
                      context, 50 + MediaQuery.of(context).padding.bottom))));
        }
      } else if (state.type == WebViewState.startLoad) {
        flutterWebViewPlugin?.hide();
      }
    });
  }
}
