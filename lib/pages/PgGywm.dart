import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelVersion.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:package_info/package_info.dart';
import 'package:udid/udid.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Help.dart';

/**
 * webview版本
 * Created by guoshuyu
 * on 2018/7/27.
 */
class PgGywm extends StatefulWidget {
  @override
  PgGywmState createState() => new PgGywmState();
}

class PgGywmState extends BaseState<PgGywm> {
  String udid;
  String version;

  @override
  void initView() async {
    udid = await Udid.udid;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = '掌上金曲  v${packageInfo.version}';
    reLoad();
  }

  @override
  void onSuccess(String methodName, res) {
    if (methodName == METHOD_UPDATE) {
      ModelVersion mModelVersion = ModelVersion.fromJson(res.data);
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        if (packageInfo.version != mModelVersion.data.buildVersion) {
          Help.showAlertDialog(context, '发现新版本，是否更新', () {
            launch(mModelVersion.data.buildShortcutUrl);
          });
        }else{
          Help.Toast(context, '已经是最新版本');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于我们'),
        centerTitle: true,
      ),
      body: Container(
        color: Color(GSYColors.f2f2f2),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 30))),
            Image.asset(
              'static/images/logo2.png',
              height: ScreenUtil.getScaleW(context, 75),
              fit: BoxFit.fitHeight,
            ),
            Padding(padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10))),
            Text(version ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                )),
            Padding(padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 30))),
            Container(
              height: ScreenUtil.getScaleH(context, 45),
              color: Colors.white,
              padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    '功能介绍',
                    style: Style.text_style_16_black,
                  )),
                  Icon(Icons.chevron_right, color: Colors.grey)
                ],
              ),
            ),
            Container(
              height: ScreenUtil.getScaleH(context, 5),
              color: Color(GSYColors.f2f2f2),
            ),
            InkWell(
              onTap: () {
                loadUrl(METHOD_UPDATE, {"_api_key": apikey, "appKey":  defaultTargetPlatform == TargetPlatform.android?appKey:appKeyIos} );
              },
              child: Container(
                height: ScreenUtil.getScaleH(context, 45),
                color: Colors.white,
                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '版本更新',
                      style: Style.text_style_16_black,
                    )),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
            ),
            Container(
              height: ScreenUtil.getScaleH(context, 5),
              color: Color(GSYColors.f2f2f2),
            ),
            InkWell(
              onTap: () {
                print("ggg");
              },
              child: Container(
                height: ScreenUtil.getScaleH(context, 45),
                color: Colors.white,
                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '设备号',
                      style: Style.text_style_16_black,
                    )),
                    Text(
                      udid ?? '',
                      style: Style.text_style_13_gray,
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(bottom: ScreenUtil.getScaleW(context, 10)),
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                color: Color(GSYColors.f2f2f2),
                child: Text('Powerder by JinQu SoftWare',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
