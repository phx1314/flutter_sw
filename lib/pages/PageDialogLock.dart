import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_std/model/ModelRz.dart';

class PageDialogLock extends StatefulWidget {
  PageDialogLock();

  @override
  PageDialogLockState createState() => new PageDialogLockState();
}

class PageDialogLockState extends BaseState<PageDialogLock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //保证控件居中效果
        child: new Container(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 25)),
            child: TextField(
//                textInputAction: TextInputAction.go,
              onSubmitted: (s) {
                if (s == Help.mModelUser.password) {
                  finish();
                } else {
                  Help.Toast(context, '密码错误');
                }
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.all(ScreenUtil.getScaleW(context, 5)),
                icon: Icon(
                  Icons.lock,
                  color: Colors.blue,
                  size: ScreenUtil.getScaleW(context, 27),
                ),
                labelText: '请输入密码',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
