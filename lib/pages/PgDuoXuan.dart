import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelDx.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class PgDuoXuan extends StatefulWidget {
  SearchListBean item;

  PgDuoXuan(this.item);

  @override
  PgDuoXuanState createState() => new PgDuoXuanState();
}

class PgDuoXuanState extends BaseState<PgDuoXuan> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('请选择'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              widget.item.value = "";
              widget.item.ids = "";
              widget.item.mModelDxs.forEach((f) {
                print(f.string);
                if (f?.isChecked != null && f?.isChecked) {
                  widget.item.value += f.string + ",";
                  widget.item.ids += f.id.toString() + ",";
                }
              });
              if (widget.item.value.length > 0) {
                widget.item.value = widget.item.value
                    .substring(0, widget.item.value.length - 1);
                widget.item.ids =
                    widget.item.ids.substring(0, widget.item.ids.length - 1);
              }
              reLoad();
              finish();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                '确定',
                style: Style.text_style_16_white,
              ),
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: widget.item.mModelDxs.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (widget.item.mModelDxs[index].BaseOrder.startsWith('142_') &&
                    widget.item.mModelDxs[index].BaseOrder.split('_').length <=
                        2) {
                  return;
                }
                widget.item.mModelDxs[index].isChecked =
                    !(widget.item.mModelDxs[index].isChecked);
                reLoad();
              },
              child: ListTile(
                title: Text(
                  widget.item.mModelDxs[index].string,
                  style: Style.text_style_14_black,
                ),
                trailing: (widget.item.mModelDxs[index].isChecked)
                    ? Icon(Icons.done, color: Colors.blue)
                    : null,
              ),
            ),
        separatorBuilder: (context, index) => Divider(
              height: 1,
            ),
      ),
    );
  }
}
