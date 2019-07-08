import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/pages/PgAccount.dart';
import 'package:flutter_std/pages/PgGywm.dart';
import 'package:flutter_std/pages/PgLogin.dart';
import 'package:flutter_std/pages/PgXxTz.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:package_info/package_info.dart';

class PgSet extends StatefulWidget {
  PgSet();

  @override
  State createState() => new PgSetState();
}

class PgSetState extends BaseState<PgSet> {
  int size = 0;
  String version;

  @override
  void initView() {
    getCache();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = 'v${packageInfo.version}';
      reLoad();
    });
  }

  void getCache() async {
    try {
      size = 0;
      String path = await Help.mImageCacheManager.getFilePath();
      int aa = await Directory(path).list().length;
      print(aa);
      Directory(path).list().forEach((f) async {
        if (f is File) {
          size += await f.length();
          reLoad();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void clearCache() async {
    try {
      String path = await Help.mImageCacheManager.getFilePath();
      print(path);
      Directory(path).list().forEach((f) async {
        if (f is File) {
          size -= await f.length();
          await f.delete();
          reLoad();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        centerTitle: true,
      ),
      body: Container(
        color: Color(GSYColors.f2f2f2),
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil.getScaleH(context, 10),
              color: Color(GSYColors.f2f2f2),
            ),
            InkWell(
              onTap: () {
                Help.goWhere(context, PgAccount());
              },
              child: Container(
                color: Color(GSYColors.white),
                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                height: ScreenUtil.getScaleH(context, 45),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '账户与安全',
                      style: Style.text_style_16_black,
                    )),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
            ),
            Container(
              height: ScreenUtil.getScaleH(context, 10),
              color: Color(GSYColors.f2f2f2),
            ),
            InkWell(
              onTap: () {
//                clearCache();
                Help.mImageCacheManager.emptyCache();
                size = 0;
                reLoad();
              },
              child: Container(
                color: Color(GSYColors.white),
                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                height: ScreenUtil.getScaleH(context, 45),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '清空缓存',
                      style: Style.text_style_16_black,
                    )),
                    Text(
                      Help.getRollupSize(size),
                      style: Style.text_style_13_gray,
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
            ),
//            Divider(height: 1),
//            InkWell(
//              onTap: () {
//                Help.goWhere(context, PgXxTz());
//              },
//              child: Container(
//                color: Color(GSYColors.white),
//                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
//                height: ScreenUtil.getScaleH(context, 45),
//                child: Row(
//                  children: [
//                    Expanded(
//                        child: Text(
//                      '消息通知',
//                      style: Style.text_style_16_black,
//                    )),
//                    Icon(Icons.chevron_right, color: Colors.grey)
//                  ],
//                ),
//              ),
//            ),
            Divider(height: 1),
            InkWell(
              onTap: () {
                showDiaolg(context);
              },
              child: Container(
                color: Color(GSYColors.white),
                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                height: ScreenUtil.getScaleH(context, 45),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '主题设置',
                      style: Style.text_style_16_black,
                    )),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
            ),
            Container(
              height: ScreenUtil.getScaleH(context, 10),
              color: Color(GSYColors.f2f2f2),
            ),
            InkWell(
              onTap: () {
                Help.goWhere(context, PgGywm());

//              Config.mEventBus.fire(["HomePage",0,"heheda" ]);
              },
              child: Container(
                color: Color(GSYColors.white),
                padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 10)),
                height: ScreenUtil.getScaleH(context, 45),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '关于我们',
                      style: Style.text_style_16_black,
                    )),
                    Text(
                      version ?? '',
                      style: Style.text_style_13_gray,
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey)
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
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
                onPressed: () {
                  Help.logOut(context);
                },
                color: Colors.red,
                child: Text(
                  '退出登录',
                  style: Style.text_style_16_white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDiaolg(BuildContext context) {
    List<Widget> mWidgets = new List();
    for (int i = 0; i < colors.length; i++) {
      mWidgets.add(InkWell(
        onTap: () {
          Help.mColor = colors[i];
          Help.save('mColor', i.toString());
          Help.sendMsg('PgMain', 0, '');
          finish();
        },
        child: CircleAvatar(
          backgroundColor: colors[i],
        ),
      ));
    }
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Container(
                alignment: Alignment.center,
                height: ScreenUtil.getScaleW(context, 235),
                width: MediaQuery.of(context).size.width * 0.9,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: ScreenUtil.getScaleH(context, 10),
                  crossAxisSpacing: ScreenUtil.getScaleH(context, 15),
                  children: mWidgets,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil.getScaleW(context, 12))),
              ),
            ));
  }


}
