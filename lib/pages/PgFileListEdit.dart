import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemFile.dart';
import 'package:flutter_std/model/ModelFjList.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/TakePhoto.dart';
import 'PgMap.dart';
import 'PgSound.dart';

class PgFileListEdit extends StatefulWidget {
  String id;
  String refTable;
  String form;
  List mModelWenjianUploads = new List();

  PgFileListEdit(this.id, this.refTable, this.form, this.mModelWenjianUploads);

  @override
  PgFileListEditState createState() => new PgFileListEditState();
}

class PgFileListEditState extends BaseState<PgFileListEdit> {
  List<Widget> mWidgets = new List();
  File file;
  List<DataBean> data = new List();

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        DataBean mRowsListBean = data;
        loadUrl(METHOD_DELETE, {"idSet": mRowsListBean.ID, "mode": "0"});
        widget.mModelWenjianUploads.remove(mRowsListBean);
        reFreashData();
        reLoad();
        break;
      case 1:
        file = data;
        upLoadFile();
        break;
    }
  }

  void upLoadFile() {
    if (file != null) {
      loadUrl(
          METHOD_UPLOAD,
          {
            "file": UploadFileInfo(file, 'img'),
            "name": file.path.split('/').last,
            "chunk": "0",
            "chunks": "1",
            "refID": widget.id ?? '0',
            "refTable": widget.refTable,
            "fileID": "UploadFile1",
            "parentID": "0",
            "mode": "0",
            "lastModifiedTime": Help.getCurrentTime(type: 1)
          },
          isFormData: true);
    }
  }

  reFreashData() {
    data.clear();
    widget.mModelWenjianUploads.forEach((f) {
      if (f.RefTable == widget.refTable || f.RefTable == null) {
        data.add(f);
      }
    });
  }

  @override
  void initView() {
    reFreashData();
    FILE_DATA.forEach((f) {
      if (f == '视频文件') {
        mWidgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "static/images/shipin.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            Padding(padding: EdgeInsets.all(5)),
            Text(f)
          ],
        ));
      } else if (f == '音频文件') {
        mWidgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "static/images/yinpin.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            Padding(padding: EdgeInsets.all(5)),
            Text(f)
          ],
        ));
      } else if (f == '当前位置') {
        mWidgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "static/images/dingwei_h.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            Padding(padding: EdgeInsets.all(5)),
            Text(f)
          ],
        ));
      } else if (f == '图片拍照') {
        mWidgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "static/images/weizhi.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            Padding(padding: EdgeInsets.all(5)),
            Text(f)
          ],
        ));
      }
    });
  }


  @override
  void onSuccess(String methodName, res) async {
    if (methodName == METHOD_UPLOAD) {
      DataBean mModelWenjianUpload = DataBean.fromJson(res.data);
//      mModelWenjianUpload.Name =  encode(mModelWenjianUpload.Name);

      if (mModelWenjianUpload.Name != null) {
        mModelWenjianUpload.IDD = mModelWenjianUpload.Name;
      } else {
        mModelWenjianUpload.ID = mModelWenjianUpload.AttachID;
        mModelWenjianUpload.Type = "attach";
      }
      mModelWenjianUpload.Name = file.path.split('/').last;
      mModelWenjianUpload.LastModifyDate =
          mModelWenjianUpload.UploadDate = Help.getCurrentTime(type: 1);
      int length = await file.length();
      mModelWenjianUpload.Size = length;
      widget.mModelWenjianUploads.add(mModelWenjianUpload);
      reFreashData();
      reLoad();
      Help.Toast(context, "文件上传成功");
    } else if (methodName == METHOD_DELETE) {
      Help.Toast(context, '删除成功');
      Help.sendMsg(widget.form, 103, '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('附件列表'),
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
                  FILE_DATA,
                  (f) {
                    if (f == '视频文件') {
                    } else if (f == '音频文件') {
                      Help.goWhere(context, PgSound());
                    } else if (f == '当前位置') {
                      Help.goWhere(context, PgMap());
                    } else if (f == '图片拍照') {
                      Help.showMyDialog(context, TakePhoto((file) {
                        this.file = file;
                        upLoadFile();
                      }));
                    }
                  },
                  left: 1,
                  child: mWidgets,
                );
              },
            ),
          ]),
      body: ListView.separated(
        itemCount: data.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () {},
              child: new ItemFile(
                data[index],
                widget.refTable,
                enabled: true,
              ),
            ),
        separatorBuilder: (context, index) => Divider(
              height: 1,
            ),
      ),
    );
  }
}
