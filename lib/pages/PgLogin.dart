import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelUser.dart';
import 'package:flutter_std/pages/PgHome.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:udid/udid.dart';

import 'PgChangeIP.dart';
import 'PgSjbd.dart';
import 'PgSound.dart';

class PgLogin extends StatefulWidget {
  static final String sName = "PgLogin";

  @override
  State createState() => new PgLoginState();
}

class PgLoginState extends BaseState<PgLogin> {
  bool obscureText = true;

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();
  String udid;

  @override
  void initView() async {
    udid = await Udid.udid;
    reLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 40))),
          InkWell(
            onLongPress: () {
              Help.goWhere(context, PgChangeIP());
            },
            child: Image.asset(
              'static/images/logo2.png',
              height: ScreenUtil.getScaleW(context, 75),
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 5))),
          Text('掌上金曲',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil.getScaleW(context, 30),
                ScreenUtil.getScaleW(context, 40),
                ScreenUtil.getScaleW(context, 80),
                0),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.all(ScreenUtil.getScaleW(context, 5)),
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.blue,
                  size: ScreenUtil.getScaleW(context, 27),
                ),
                labelText: '请输入用户名',
              ),
              autofocus: false,
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil.getScaleW(context, 30),
                  ScreenUtil.getScaleW(context, 40),
                  ScreenUtil.getScaleW(context, 30),
                  0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                        controller: passController,
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
                        obscureText: obscureText),
                  ),
                  IconButton(
                      icon: Icon(obscureText
                          ? Icons.remove_red_eye
                          : Icons.panorama_fish_eye),
                      onPressed: () {
                        obscureText = !obscureText;
                        reLoad();
                      })
                ],
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil.getScaleW(context, 30),
                ScreenUtil.getScaleW(context, 50),
                ScreenUtil.getScaleW(context, 30),
                0),
            child: RaisedButton(
              shape: const RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              elevation: 5,
              padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
              color: Colors.lightBlue,
              onPressed: () {
                if (phoneController.text.isEmpty) {
                  Fluttertoast.showToast(msg: '请输入用户名');
                  return;
                }
                if (passController.text.isEmpty) {
                  Fluttertoast.showToast(msg: '请输入密码');
                  return;
                }
                loadUrl(METHOD_LOGIN, {
                  "userName": phoneController.text,
                  "passWord": passController.text
                });
              },
              child: Text('登录',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  )),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, ScreenUtil.getScaleW(context, 35), 0, 0),
            child: Text('Powerder by JinQu SoftWare',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                )),
          )
        ],
      ),
    );
  }

  setPushTag(JPush mJPush) {
//    Help.pushReplacementNamed(context, PgHome.sName);
    mJPush
        .setAlias(
            JPush_Alias_BeginWith + Help.mModelUser.UserInfo.EmpID.toString())
        .then((v) {
      print(v.toString());
      List<String> tags = List<String>();
      tags.add(JPush_Alias_BeginWith);
      mJPush.setTags(tags).then((v) {
        print(v.toString());
        Help.pushReplacementNamed(context, PgHome.sName);
      });
    });
  }

  @override
  onSuccess(String methodName, res) async {
    if (methodName == METHOD_LOGIN) {
      Help.mModelUser = ModelUser.fromJson(res.data);
      Help.mModelUser.name = phoneController.text;
      Help.mModelUser.password = passController.text;
      Help.cookie = "UID=" +
          Help.mModelUser.UserInfo.EmpID.toString() +
          "; " +
          "ASP.NET_SessionId=" +
          Help.mModelUser.SessionID +
          "; " +
          "AgentID=; expires=Fri, 20-May-1983 16:00:00 GMT; path=/";
//      if (Help.mModelUser.UserInfo.EmpName != '戴飞') {
//        if (Help.mModelUser.UserInfo.EmpMEID == null ||
//            Help.mModelUser.UserInfo.EmpMEID == '') {
//          loadUrl(
//              "Core/user/UpdateEmpMEID?a=" +
//                  Help.mModelUser.name +
//                  "&p=" +
//                  md5
//                      .convert(utf8.encode(Help.mModelUser.password))
//                      .toString() +
//                  "&EmpMEID=" +
//                  udid,
//              null);
//        } else {
//          if (Help.mModelUser.UserInfo.EmpMEID != udid) {
//            Help.goWhere(context, PgSjbd());
//            return;
//          }
//        }
//      }
      await Help.save("mModelUser", json.encode(Help.mModelUser.toJson()));
      setPushTag(JPush());
    }
  }
}
