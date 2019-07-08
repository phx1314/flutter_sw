import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelEmail.dart';
import 'package:flutter_std/pages/PgEmailDetail.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/FontString.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:lpinyin/lpinyin.dart';

class ItemEmail extends StatefulWidget {
  RowsListBean item;
  int type;

  ItemEmail(this.item, this.type);

  @override
  ItemEmailState createState() => new ItemEmailState();
}

class ItemEmailState extends BaseState<ItemEmail> {
  @override
  void onSuccess(String methodName, res) {
    if (methodName == METHOD_UpdateReadByIds) {
      Help.sendMsg('PgWode', 0, '');
      widget.item.MailFlag = 'fa fa-envelope-o';
      reLoad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Help.goWhere(
            context, PgEmailDetail(widget.item.Id.toString(), widget.type));
      },
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: ScreenUtil.getScaleW(context, 60),
                width: ScreenUtil.getScaleW(context, 60),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(color: Color(0xFFD6D6D6), width: 1),
                  color: FontString.data[
                      PinyinHelper.getFirstWordPinyin(widget.item.MailEmpName)
                          .substring(0, 1)],
                ),
                child: Text(widget.item.MailEmpName.substring(0, 1),
                    style: Style.text_style_18_white),
              ),
              Padding(padding: EdgeInsets.all(8)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Visibility(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 3.0),
                            child: Icon(
                              Icons.lens,
                              color: Colors.blue,
                              size: ScreenUtil.getScaleW(context, 10),
                            ),
                          ),
                          visible: widget.item.MailFlag=='fa fa-envelope',
                        ),
                        Expanded(
                          child: Text(
                            widget.item.MailEmpName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Style.text_style_16_black,
                          ),
                        ),
                        Text(
                          widget.item.MailDate.contains('T')
                              ? widget.item.MailDate.split('T')[0]
                              : widget.item.MailDate,
                          style: Style.text_style_13_gray,
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(6)),
                    Text(
                      widget.item.MailTitle,
                      style: Style.text_style_14_black,
                    ),
                    Padding(padding: EdgeInsets.all(6)),
                    HtmlTextView(
                      data: widget.item.MailNote,
//                      softWrap: true,
//                      style: Style.text_style_14_black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: '已读',
            color: Colors.green,
            icon: Icons.drafts,
            onTap: () {
              loadUrl(
                  METHOD_UpdateReadByIds +
                      widget.item.Id.toString() +
                      "_" +
                      Help.mModelUser.UserInfo.EmpID.toString(),
                  null,
                  isShow: false,
                  biaoshi: METHOD_UpdateReadByIds);
            },
          ),
          new IconSlideAction(
            caption: '删除',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              Help.sendMsg('PgEmailList', 110, widget.item);
            },
          ),
        ],
      ),
    );
  }
}
