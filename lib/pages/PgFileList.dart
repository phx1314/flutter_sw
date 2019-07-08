import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemFile.dart';
import 'package:flutter_std/model/ModelFjList.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/PullListView.dart';

class PgFileList extends StatefulWidget {
  String id;
  String refTable;

  PgFileList(this.id, this.refTable);

  @override
  PgFileListState createState() => new PgFileListState();
}

class PgFileListState extends BaseState<PgFileList> {
  List<Widget> mWidgets = new List();
  PullListView mPullListView;

  @override
  void initView() {
    mPullListView = PullListView(
      methodName:  METHOD_GETATTACHFILES,
      other: {"refID": widget.id, "refTable": widget.refTable},
      loadMoreEnable: false,
      mCallback: (methodName, res) {
        ModelFjList mModelFjList = ModelFjList.fromJson(res.data);
        List data = new List();
        mModelFjList.rows.forEach((f) {
          data.add(new ItemFile(f, widget.refTable));
        });
        return data;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('附件列表'),
        centerTitle: true,
      ),
      body: mPullListView,
    );
  }
}
