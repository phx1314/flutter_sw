import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemSus.dart';
import 'package:flutter_std/model/ModelUser.dart';
import 'package:flutter_std/pages/PgGrzl.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/FontString.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:lpinyin/lpinyin.dart';

class ItemTxl extends StatefulWidget {
  BaseEmployeeListBean model;
  int type;

  ItemTxl(this.model, this.type);

  @override
  ItemTxlState createState() => new ItemTxlState();
}

class ItemTxlState extends BaseState<ItemTxl> {
  @override
  Widget build(BuildContext context) {
    String susTag = widget.model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: widget.model.isShowSuspension != true,
          child: ItemSus(susTag),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 80,
          child: ListTile(
            leading: Container(
              alignment: Alignment.center,
              height: 60,
              width: 60,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(color: Color(0xFFD6D6D6), width: 1),
                color: FontString.data[
                    PinyinHelper.getFirstWordPinyin(widget.model.EmpName)
                        .substring(0, 1)],
              ),
              child: Text(widget.model.EmpName.substring(0, 1),
                  style: Style.text_style_18_white),
            ),
            title: Text(
              widget.model.EmpName,
              style: Style.text_style_16_black,
            ),
            subtitle:
                Text(widget.model.EmpDepName, style: Style.text_style_13_gray),
            trailing: widget.type == 2
                ? Visibility(
                    child: Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(Icons.done, color: Colors.blue),
                    ),
                    visible: widget.model.isChecked,
                  )
                : null,
            onTap: () {
              if (widget.type == 0) {
                Help.goWhere(context, PgGrzl(widget.model.EmpID));
              } else if (widget.type == 1) {
                Help.sendMsg('PgXzryOne', 0, widget.model);
              } else if (widget.type == 2) {
                widget.model.isChecked = !widget.model.isChecked;
                Help.sendMsg('PgXzry', 0, widget.model);
              }
            },
          ),
        ),
      ],
    );
  }
}
