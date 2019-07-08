import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemDialogRz.dart';
import 'package:flutter_std/model/ModelRz.dart';
import 'package:flutter_std/utils/FontString.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:lpinyin/lpinyin.dart';

class ItemRz extends StatelessWidget {
  RowsListBean item;
  int type;

  ItemRz(this.item, this.type);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Help.showMyDialog(context, ItemDialogRz(item, type));
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.getScaleW(context,10)),
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height:ScreenUtil.getScaleW(context,60)  ,
              width: ScreenUtil.getScaleW(context,60),
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(color: Color(0xFFD6D6D6), width: 1),
                color: FontString.data[
                    PinyinHelper.getFirstWordPinyin(item.EmpName)
                        .substring(0, 1)],
              ),
              child: Text(item.EmpName.substring(0, 1),
                  style: Style.text_style_18_white),
            ),
            Padding(padding: EdgeInsets.all(8)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.EmpName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14,
                        decoration: TextDecoration.none),
                  ),
                  Padding(padding: EdgeInsets.all(6)),
                  Text(
                    item.BaseLogDate,
                    style: Style.text_style_14_gray,
                  ),
                  Padding(padding: EdgeInsets.all(6)),
                  Text(
                    item.BaseLogRefHTML,
                    softWrap: true,
                    style: Style.text_style_14_black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
