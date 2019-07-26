import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelGzjd.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/FontString.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:lpinyin/lpinyin.dart';

class ItemGzjd extends StatefulWidget {
  RowsListBean item;
  int position;

  ItemGzjd(this.item, this.position);

  @override
  ItemGzjdState createState() => new ItemGzjdState();
}

class ItemGzjdState extends BaseState<ItemGzjd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: VerticalDivider(
                  width: 2,
                )),
                Visibility(
                  child: RaisedButton(
                    padding: EdgeInsets.all(ScreenUtil.getScaleW(context,15)),
                    onPressed: null,
                    disabledColor: Colors.green,
                    child: Text(
                      '发起',
                      style: Style.text_style_13_white,
                    ),
                  ),
                  visible: widget.position == 0,
                ),
                Expanded(
                    child: VerticalDivider(
                  width: 2,
                )),
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 60,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(color: Color(0xFFD6D6D6), width: 2),
                    color: FontString.data[
                        PinyinHelper.getFirstWordPinyin(widget.item.ExeEmpName)
                            .substring(0, 1)],
                  ),
                  child: Text(widget.item.ExeEmpName.substring(0, 1),
                      style: Style.text_style_13_white),
                ),
                Expanded(
                    child: VerticalDivider(
                  width: 2,
                )),
                RaisedButton(
                  padding: EdgeInsets.all(ScreenUtil.getScaleW(context,15)),
                  onPressed: null,
                  disabledColor: Colors.blue,
                  child: Text(
                    widget.item.NewExeActionDate.split(" ")[0],
                    style: Style.text_style_13_white,
                  ),
                ),
                Expanded(
                    child: VerticalDivider(
                  width: 2,
                )),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: ScreenUtil.getScaleW(context,150),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: ScreenUtil.getScaleW(context,1), color: Colors.grey),
                  color: Color(0xFFE0E0E0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(
                            ScreenUtil.getScaleW(context,5), ScreenUtil.getScaleW(context,5)),
                        blurRadius: ScreenUtil.getScaleW(context,5),
                        spreadRadius: ScreenUtil.getScaleW(context,2)),
                  ],
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil.getScaleW(context,5))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.item.ExeEmpName +
                                  " " +
                                  widget.item.ActionName,
                              style: Style.text_style_13_gray,
                            ),
                          ),
                          Text(
                            widget.item.FlowNodeName +
                                " " +
                                widget.item.NewExeActionDate.split(" ")[1],
                            style: Style.text_style_13_gray,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.item.ExeNote?? ''  ,
                        style: Style.text_style_13_gray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
