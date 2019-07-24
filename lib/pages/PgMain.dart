import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_std/pages/PgHome.dart';
import 'package:flutter_std/pages/PgLogin.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/Code.dart';
import 'package:flutter_std/utils/HttpErrorEvent.dart';

import '../Help.dart';
import 'PgYinDao.dart';

class PgMain extends StatefulWidget {
  int type;

  PgMain(this.type);

  @override
  PgMainState createState() => new PgMainState();
}

class PgMainState extends BaseState<PgMain> {
  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        reLoad();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Help.mColor,
        ),
        routes: {
          PgHome.sName: (context) {
            return new GSYLocalizations(
              child: new PgHome(),
            );
          },
          PgLogin.sName: (context) {
            return new GSYLocalizations(
              child: new PgLogin(),
            );
          },
          PgYinDao.sName: (context) {
            return new GSYLocalizations(
              child: new PgYinDao(),
            );
          },
        },
        home: widget.type == 0
            ? PgYinDao()
            : widget.type == 1 ? PgLogin() : PgHome());
  }
}

class GSYLocalizations extends StatefulWidget {
  final Widget child;

  GSYLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<GSYLocalizations> createState() {
    return new _GSYLocalizations();
  }
}

class _GSYLocalizations extends State<GSYLocalizations> {
  StreamSubscription stream;

  @override
  void initState() {
    super.initState();
    stream = Code.eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  errorHandleFunction(int code, message) {
    print('有异常');
//    Fluttertoast.showToast(msg: "请求失败");
  }

  @override
  Widget build(BuildContext context) {
    return new Localizations.override(
      context: context,
      child: widget.child,
    );
  }
}
