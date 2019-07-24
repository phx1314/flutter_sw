import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/pages/PgTxl.dart';
import 'package:flutter_std/pages/PgXxson.dart';
import 'package:flutter_std/utils/BaseState.dart';

import 'PgXtxx.dart';

class PgXx extends StatefulWidget {
  @override
  PgXxState createState() => PgXxState();
}

class PgXxState extends BaseState<PgXx> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(
                text: "消息",
              ),
              Tab(
                text: "通讯录",
              )
            ],
            isScrollable: true,
//            labelColor: Colors.white,
//            unselectedLabelColor: Colors.white,
            unselectedLabelStyle: new TextStyle(fontSize: 16.0),
            labelStyle:
                new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
          leading: Builder(
            builder: (context) => IconButton(
                  icon: Icon(Icons.crop_free,
                      size: ScreenUtil.getScaleW(context, 25)),
                  onPressed: () {
                    Help.scan(context);
                  },
                ),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [PgXtxx(), PgTxl()],
        ),
      ),
    );
  }
}
