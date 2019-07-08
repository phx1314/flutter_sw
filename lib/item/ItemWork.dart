import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/item/ItemWorkSon.dart';
import 'package:flutter_std/model/ModelWork.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class ItemWork extends StatelessWidget {
  ModelWorkBean item;

  @override
  Widget build(BuildContext context) {
    List<Widget> mWidgets = new List();
    item.children.forEach((f) {
      mWidgets.add(ItemWorkSon(f));
    });
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: ScreenUtil.getScaleW(context,10),
            color: Color(GSYColors.f2f2f2),
          ),
          Container(
            padding: EdgeInsets.all(ScreenUtil.getScaleW(context,12)),
            child: Text(
              item.text,
              style: Style.text_style_16_black,
            ),
          ),
          Divider(height: ScreenUtil.getScaleW(context,1)),
          Wrap(
            spacing: ScreenUtil.getScaleW(context,4), // gap between adjacent chips
            runSpacing: ScreenUtil.getScaleW(context,2), // gap between lines
            children: mWidgets,
          )
        ],
      ),
    );
  }

  ItemWork(this.item);
}
