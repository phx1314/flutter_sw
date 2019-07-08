import 'dart:async';
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_sound/flutter_sound.dart';

import '../Help.dart';

class PgSound extends StatefulWidget {
  @override
  PgSoundState createState() => new PgSoundState();
}

class PgSoundState extends BaseState<PgSound> {
  FlutterSound flutterSound;
  bool isLY = false;
  int count = 60;
  String path;

  @override
  void initState() {
    super.initState();
    flutterSound = new FlutterSound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于我们'),
        centerTitle: true,
        actions: <Widget>[
          isLY
              ? InkWell(
                  onTap: () {
                    stop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      '保存',
                      style: Style.text_style_16_white,
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Center(
            child: Text(
              '00:00:$count',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                  decoration: TextDecoration.none),
            ),
          )),
          Divider(
            height: 1,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isLY
                  ? Container()
                  : RaisedButton(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      elevation: 5,
                      padding:
                          EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
                      color: Colors.red,
                      onPressed: () async {
                        isLY = true;
                        path = await flutterSound.startRecorder(null);
                        path = path.startsWith('file://')
                            ? path.split('file://')[1]
                            : path;
                        print('startRecorder: $path');
                        flutterSound.onRecorderStateChanged.listen((e) {
                          if (e != null &&
                              e.currentPosition != null &&
                              mounted) {
                            DateTime date =
                                new DateTime.fromMillisecondsSinceEpoch(
                                    e.currentPosition.toInt());
                            count = 60 - date.second;
                            if (date.minute > 0) {
                              count = 0;
                              stop();
                            }
                            reLoad();
                          }
                        });
                      },
                      child: SizedBox(
                        width: ScreenUtil.getScaleW(context, 65),
                        child: Image.asset(
                          'static/images/asus_recorder_btn_voice.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                '录音',
                style: Style.text_style_16_black,
              )
            ],
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    try {
      if (isLY) flutterSound.stopRecorder();
    } catch (e) {}

    super.dispose();
  }

  void stop() {
    try {
      var file = File(path);
      Help.sendMsg('PgFileListEdit', 1, file);
      isLY = false;
      flutterSound.stopRecorder();
      finish();
    } catch (e) {}
  }
}
