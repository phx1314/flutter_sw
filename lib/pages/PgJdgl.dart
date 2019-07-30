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

import 'PgFileList.dart';
import 'PgFileListEdit.dart';

//  https://github.com/tiagojencmartins/unicornspeeddial
class PgJdgl extends StatefulWidget {
  PgJdgl();

  @override
  PgJdglState createState() => new PgJdglState();
}

class PgJdglState extends BaseState<PgJdgl> {
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();
  Map<String, dynamic> map_json;
  bool isCurrentUrl = true;
  ModelUploadFile mModelUpload;
  List<DataBean> mModelWenjianUploads = new List();
  bool isShowSave = false;
  int id;

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        flutterWebViewPlugin
            .evalJavascript("${map_json['Method']}('${data.toString()}')");
        break;
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (TargetPlatform.iOS == defaultTargetPlatform)
      Future.delayed(Duration(seconds: 1), () {
        if (ModalRoute.of(context).isCurrent) {
          flutterWebViewPlugin?.show();
          print("显示a" + ModalRoute.of(context).toString());
        } else {
          flutterWebViewPlugin?.hide();
          print("隐藏a" + ModalRoute.of(context).toString());
        }
      });
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
        url:
            '${Help.BASEURL}/Bussiness/BussProjectmobile/progresslist?a=${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}',
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
            Visibility(
              visible: isShowSave,
              child: InkWell(
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
              ),
            )
          ],
          title: Text('项目进度管理'),
          centerTitle: true,
        ),
      ),
    );
  }

  @override
  onSuccess(String methodName, res) {
    if (methodName == METHOD_GETATTACHFILES) {
      mModelWenjianUploads.clear();
      ModelFjList mModelFjList = ModelFjList.fromJson(json.decode(res.json));
      mModelFjList.rows.forEach((f) {
        f.RefTable = mModelUpload.RefTable;
      });
      mModelWenjianUploads.addAll(mModelFjList.rows);
      goDie();
    } else if (methodName == METHOD_SAVESETTING) {
      flutterWebViewPlugin.reloadUrl(
          '${Help.BASEURL}/Bussiness/BussProjectmobile/progresslist?a=${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}');
    }
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  void go2Where(String type) {
    try {
      if (type == '008') {
        id = map_json['Id'];
        flutterWebViewPlugin.reloadUrl(
            '${Help.BASEURL}/bussiness/BussProjectmobile/Setting?Id=$id&a=${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}');
      } else if (type == '001') {
        loadUrl(METHOD_SAVESETTING, map_json);
      } else if (type == '007') {
        Help.goWhere(context,
            PgFileList(map_json['RefID'].toString(), map_json['RefTable']));
      } else if (type == '006') {
        mModelUpload = ModelUploadFile.fromJson(map_json);
        loadUrl(METHOD_GETATTACHFILES,
            {"refID": id, "refTable": mModelUpload.RefTable});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void goDie() {
    Help.goWhere(
        context,
        PgFileListEdit(id.toString(), mModelUpload.RefTable, widget.toString(),
            mModelWenjianUploads));
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
      print(url);
      isCurrentUrl = url ==
          '${Help.BASEURL}/Bussiness/BussProjectmobile/progresslist?a=${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}';
      isShowSave = url.startsWith(
          '${Help.BASEURL}/bussiness/BussProjectmobile/Setting?Id=');
      reLoad();
    });
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        flutterWebViewPlugin?.show();
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          isCurrentUrl = state.url ==
              '${Help.BASEURL}/Bussiness/BussProjectmobile/progresslist?a=${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}';
          isShowSave = state.url.startsWith(
              '${Help.BASEURL}/bussiness/BussProjectmobile/Setting?Id=');
          reLoad();
        }
      } else if (state.type == WebViewState.startLoad) {
        flutterWebViewPlugin?.hide();
      }
    });
  }
}
