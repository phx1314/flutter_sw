import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class PgPubEdit extends StatefulWidget {
  String hint;
  String from;
  String text;
  int what;
  int max;
  TextInputType mTextInputType;

  PgPubEdit(this.hint, this.from, this.text, this.what, this.max,this.mTextInputType);

  @override
  PgPubEditState createState() => new PgPubEditState();
}

class PgPubEditState extends BaseState<PgPubEdit> {
  TextEditingController mController;

  @override
  void initView() {
    mController = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('请输入'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              Help.sendMsg(widget.from, widget.what, mController.text);
              finish();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                '完成',
                style: Style.text_style_16_white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenUtil.getScaleW(context,10)),
        child: TextField(
          controller: mController,
          maxLength: widget.max,
          keyboardType:widget.mTextInputType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(ScreenUtil.getScaleW(context,5)),
            labelText: widget.hint,
          ),
          autofocus: false,
        ),
      ),
    );
  }
}
