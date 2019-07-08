import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelDx.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class PgDanXuan extends StatefulWidget {
  SearchListBean item;


  PgDanXuan(this.item );

  @override
  PgDanXuanState createState() => new PgDanXuanState();
}

class PgDanXuanState extends BaseState<PgDanXuan> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('请选择'), centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: widget.item.mModelDxs.length,
        itemBuilder: (context, index) =>
            InkWell(
              onTap: () {
                widget.item.value = widget.item.mModelDxs[index].string;
                widget.item.ids = widget.item.mModelDxs[index].id.toString();
                reLoad();
                finish();
              },
              child: ListTile(
                title: Text(
                  widget.item.mModelDxs[index].string,
                  style: Style.text_style_14_black,
                ),
                trailing: Icon(Icons.chevron_right, color: Colors.grey),
              ),
            ),
        separatorBuilder: (context, index) =>
            Divider(
              height: 1,
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
