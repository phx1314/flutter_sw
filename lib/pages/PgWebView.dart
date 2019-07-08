import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PgWebView extends StatefulWidget {
  final String url;

  PgWebView(this.url );

  @override
  PgWebViewState createState() => new PgWebViewState();
}

class PgWebViewState extends BaseState<PgWebView> {
  bool isFinishEd = false;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('详情'),
              Visibility(
                child: Container(
                  margin:
                  EdgeInsets.only(left: ScreenUtil.getScaleW(context, 10)),
                  child: CupertinoActivityIndicator(),
                ),
                visible: !isFinishEd,
              )
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: WebView(
          onPageFinished: (f) {
            isFinishEd = true;
            reLoad();
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
            widget.url,
    ));
  }
}