import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class ItemSearchTop extends StatefulWidget {
  var text;

  ItemSearchTop(this.text);

  @override
  ItemSearchTopState createState() => new ItemSearchTopState();
}

class ItemSearchTopState extends BaseState<ItemSearchTop> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Help.sendMsg('PgSearch', 0, widget.text);
      },
      child: Container(
          padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 5)),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
//                  offset: Offset(ScreenUtil.getScaleW(context, 1),
//                      ScreenUtil.getScaleW(context, 1)),
//                  blurRadius: ScreenUtil.getScaleW(context, 1),
//                  spreadRadius: ScreenUtil.getScaleW(context, 1)
              ),
            ],
            color: Color(0xFFBDBDBD),
            borderRadius: BorderRadius.all(
                Radius.circular(ScreenUtil.getScaleW(context, 8))),
          ),
          child: Text(widget.text, style: Style.text_style_14_white)),
    );
  }
}
