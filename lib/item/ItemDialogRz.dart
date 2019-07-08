import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_std/model/ModelRz.dart';

class ItemDialogRz extends StatefulWidget {
  RowsListBean item;
  int type;

  ItemDialogRz(this.item, this.type);

  @override
  ItemDialogRzState createState() => new ItemDialogRzState();
}

class ItemDialogRzState extends BaseState<ItemDialogRz> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                  child: InkWell(
                onTap: () => finish(),
              )),
              Visibility(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            ClipboardData data = new ClipboardData(
                                text: widget.item.BaseLogRefHTML);
                            Clipboard.setData(data);
                            finish();
                          },
                          child: Container(
                            padding: EdgeInsets.all(ScreenUtil.getScaleW(context,15)),
                            width: double.infinity,
                            child: Text(
                              '复制内容',
                              style: Style.text_style_16_black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      widget.type == 0
                          ? Divider()
                          : Divider(
                              height: 1,
                            ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            ClipboardData data =
                                new ClipboardData(text: widget.item.BaseLogIP);
                            Clipboard.setData(data);
                            finish();
                          },
                          child: Container(
                            padding: EdgeInsets.all(ScreenUtil.getScaleW(context,15)),
                            width: double.infinity,
                            child: Text(
                              '复制IP',
                              style: Style.text_style_16_black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0x66000000),
                        height: ScreenUtil.getScaleW(context,7),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () => finish(),
                          child: Container(
                            padding: EdgeInsets.all(ScreenUtil.getScaleW(context,15)),
                            width: double.infinity,
                            child: Text(
                              '取消',
                              textAlign: TextAlign.center,
                              style: Style.text_style_16_black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                visible: widget.type != 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
