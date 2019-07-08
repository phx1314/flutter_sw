import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/pages/PgDanXuan.dart';
import 'package:flutter_std/pages/PgDuoXuan.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class ItemSearch extends StatefulWidget {
  SearchListBean item;

  ItemSearch(this.item);

  @override
  ItemSearchState createState() => new ItemSearchState();
}

class ItemSearchState extends BaseState<ItemSearch> {
  @override
  void disMsg(int what, data) {
    switch (what) {
      case 1:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goWhere(),
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
        height: ScreenUtil.getScaleH(context, 50),
        child: Row(
          children: [
            Text(
              widget.item.text,
              style: Style.text_style_14_black,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.item.value ?? '',
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Style.text_style_14_black,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  goWhere() {
    if (widget.item.type.startsWith("time_")) {
      DatePicker.showDatePicker(context,
          onConfirm: (int year, int month, int date) {
        widget.item.value =
            '$year-${month > 9 ? month : ('0' + month.toString())}-${date > 9 ? date : ('0' + date.toString())}';
        reLoad();
      });
    } else if (widget.item.type == "basedata") {
      if (widget.item.multiselect == "0") {
        //单选
        Help.goWhere(context, PgDanXuan(widget.item));
      } else {
        Help.goWhere(context, PgDuoXuan(widget.item));
      }
    }
  }
}
