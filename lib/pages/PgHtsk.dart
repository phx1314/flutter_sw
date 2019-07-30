import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFjList.dart';
import 'package:flutter_std/model/ModelUploadFile.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'PgFileList.dart';
import 'PgFileListEdit.dart';

//  https://github.com/tiagojencmartins/unicornspeeddial
class PgHtsk extends StatefulWidget {
  String url;
  String MenuNameEng;
  String saveUrl;
  int Id;

  PgHtsk(this.saveUrl, this.Id, this.url, this.MenuNameEng);

  @override
  PgHtskState createState() => new PgHtskState();
}

class PgHtskState extends BaseState<PgHtsk> {
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();
  Map<String, dynamic> map_json;
  bool isCurrentUrl = true;
  ModelUploadFile mModelUpload;
  List<String> mRefTables = List();
  List<DataBean> mModelWenjianUploads = new List();
  String saveData = '';

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        flutterWebViewPlugin.evalJavascript(
            "${map_json['Method']}('${data.toString().replaceAll('\'', '')}')");
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
                      ScreenUtil.getScaleW(context, 220)
                  : MediaQuery.of(context).size.height));
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
    return WillPopScope(
      onWillPop: () {
        if (isCurrentUrl) {
          return Future.value(true);
        } else {
          flutterWebViewPlugin.goBack();
        }
      },
      child: WebviewScaffold(
        withJavascript: true,
        clearCache: true,
        clearCookies: true,
        url: widget.url,
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
              ],
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              if (isCurrentUrl) {
                finish();
              } else {
                flutterWebViewPlugin.goBack();
              }
            },
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                flutterWebViewPlugin.evalJavascript("validateFormBegin()");
              },
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  '保存',
                ),
              ),
            )
          ],
          title:
              Text(widget.MenuNameEng == "contract_feerecv" ? '合同收款' : '合同开票'),
          centerTitle: true,
        ),
      ),
    );
  }

  @override
  onSuccess(String methodName, res) {
    if (methodName == METHOD_GETATTACHFILES) {
      ModelFjList mModelFjList = ModelFjList.fromJson(json.decode(res.json));
      mModelFjList.rows.forEach((f) {
        f.RefTable = mModelUpload.RefTable;
      });
      mModelWenjianUploads.addAll(mModelFjList.rows);
      goDie();
    } else {
      Fluttertoast.showToast(msg: ":处理成功");
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

  void go2Where(String type) {
    try {
      if (type == '001') {
        if (!isCurrentUrl) {
          saveData = json.encode(map_json);
          flutterWebViewPlugin.goBack();
          return;
        }
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
        loadUrl(widget.saveUrl, map_json);
      } else if (type == '007') {
      } else if (type == '006') {
        mModelUpload = ModelUploadFile.fromJson(map_json);
        if (!mRefTables.contains(mModelUpload.RefTable)) {
          loadUrl(METHOD_GETATTACHFILES,
              {"refID": widget.Id, "refTable": mModelUpload.RefTable});
        } else {
          goDie();
        }
        if (!mRefTables.contains(mModelUpload.RefTable)) {
          mRefTables.add(mModelUpload.RefTable);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void goDie() {
    Help.goWhere(
        context,
        PgFileListEdit(widget.Id.toString(), mModelUpload.RefTable,
            widget.toString(), mModelWenjianUploads));
  }

  @override
  void loadData() {
    flutterWebViewPlugin.onChannel.listen((data) {
      print(data);
      map_json = json.decode(data);
      go2Where(map_json['type']);
    });
    flutterWebViewPlugin.onDestroy.listen((aa) {
      Navigator.pop(context);
    });
    flutterWebViewPlugin.onUrlChanged.listen((url) {
      isCurrentUrl = url == widget.url;
      if (isCurrentUrl && saveData != '') {
        Map<String, dynamic> map = json.decode(saveData);
        if (map['Id'] != '0') {
          flutterWebViewPlugin.evalJavascript("editEnd('$saveData')");
        } else {
          flutterWebViewPlugin.evalJavascript("addEnd('$saveData')");
        }

        saveData = '';
      }
    });
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        flutterWebViewPlugin?.show();
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          isCurrentUrl = state.url == widget.url;
          reLoad();
        }
      } else if (state.type == WebViewState.startLoad) {
        flutterWebViewPlugin?.hide();
      }
    });
  }
}
