import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFjList.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_std/utils/HttpManager.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PgFileDetail extends StatefulWidget {
  DataBean item;
  String refTable;

  PgFileDetail(this.item, this.refTable);

  @override
  PgFileDetailState createState() => new PgFileDetailState();
}

class PgFileDetailState extends BaseState<PgFileDetail> {
  double progress = 0;
  String path;

  @override
  void initView() async {
    path = await _findLocalPath();
    path = path + '/' + widget.item.Name;
//    File txt = File(path);
//    bool isDownLoad = await txt.exists();
//    if (isDownLoad) {
//      progress = 1;
//      reLoad();
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('附件详情'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Color(GSYColors.f2f2f2),
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Text(
                  '文件名',
                  style: Style.text_style_16_black,
                ),
                Expanded(
                  child: Text(
                    widget.item.Name,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Style.text_style_13_gray,
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  '上传人',
                  style: Style.text_style_16_black,
                )),
                Text(
                  widget.item.EmpName,
                  style: Style.text_style_13_gray,
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  '文件大小',
                  style: Style.text_style_16_black,
                )),
                Text(
                  Help.getRollupSize(widget.item.Size),
                  style: Style.text_style_13_gray,
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  '上传时间',
                  style: Style.text_style_16_black,
                )),
                Text(
                  widget.item.UploadDate.contains('Date(')
                      ? Help.matchDate(widget.item.UploadDate)
                      : widget.item.UploadDate,
                  style: Style.text_style_13_gray,
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  '修改时间',
                  style: Style.text_style_16_black,
                )),
                Text(
                  widget.item.LastModifyDate.contains('Date(')
                      ? Help.matchDate(widget.item.LastModifyDate)
                      : widget.item.LastModifyDate,
                  style: Style.text_style_13_gray,
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            height: ScreenUtil.getScaleW(context, 25),
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey,
              value: progress,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              shape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              elevation: 5,
              padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
              onPressed: () {
                if (progress <= 0) {
                  download(
                      widget.item.ID != null
                          ? "${Help.BASEURL}/core/ProcessFile/Download?id=${widget.item.ID}&type=${widget.item.Type}"
                          : "${Help.BASEURL}/core/ProcessFile/Download?id=${widget.item.ID}&name=${widget.item.IDD}&realName=${widget.item.Name}",
                      widget.item.Name);
                } else if (progress == 1) {
                  OpenFile.open(path);
                }
              },
              color: Colors.blue,
              child: Text(
                progress <= 0 ? '下载' : progress < 1 ? '下载中...' : '打开',
                style: Style.text_style_16_white,
              ),
            ),
          )
        ],
      ),
    );
  }

  void download(String url, String fileName) async {
    path = await _findLocalPath();
    path = path + '/' + fileName;
    HttpManager.downLoad(context, url, path, false, (count, total) {
      this.progress = count / total;
      print(progress);
      reLoad();
    });
  }

  Future<String> _findLocalPath() async {
    final directory = defaultTargetPlatform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
