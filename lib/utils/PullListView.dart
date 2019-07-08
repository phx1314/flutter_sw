import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PullListView extends StatefulWidget {
  var page;
  var haline;
  var rows;
  var rows_v;
  var page_v;
  var methodName;
  var biaoShi;
  var head;
  var isFirstLoad;
  Callback mCallback;
  bool loadMoreEnable;
  bool isLoading = false;
  Map<String, dynamic> other;
  List data = new List();
  PullListViewState mPullListViewState = new PullListViewState();

  reLoad() {
    mPullListViewState.refreash();
  }

  setState() {
    mPullListViewState.setState(() {});
  }

  PullListView(
      {Key key,
      @required this.methodName,
      @required this.mCallback,
      this.isFirstLoad = true,
      this.head,
      this.biaoShi,
      this.page = 'page',
      this.other,
      this.rows = 'rows',
      this.haline = true,
      this.loadMoreEnable = true,
      this.rows_v = 20,
      this.page_v = 1})
      : super(key: key);

  @override
  PullListViewState createState() => mPullListViewState;
}

typedef Callback = List Function(String methodName, dynamic res);

class PullListViewState extends BaseState<PullListView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    print("PullListViewinitState");
    if (widget.isFirstLoad) {
      widget.other ??= Map();
      widget.other
          .addAll({widget.page: widget.page_v, widget.rows: widget.rows_v});
      refreash();
      widget.isFirstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.data.length <= 0) {
      return Center(
        child: Visibility(
          child: CupertinoActivityIndicator(),
          visible: widget.isLoading,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(bottom: ScreenUtil.getScaleW(context, 7)),
        child: Refresh(
          child: ListView.separated(
            itemCount: widget.head != null
                ? widget.data.length + 1
                : widget.data.length,
            separatorBuilder: (context, index) => Visibility(
                  child: Container(
                    height: 1,
                    color: Color(GSYColors.f2f2f2),
                  ),
                  visible: widget.haline,
                ),
            // 添加分割线
            itemBuilder: (context, index) {
              try {
                if (widget.head == null) {
                  return widget.data[index];
                } else {
                  if (index == 0) {
                    return widget.head;
                  } else {
                    return widget.data[index - 1];
                  }
                }
              } catch (e) {
                return Container();
              }
            },
          ),
          onHeaderRefresh: _onHeaderRefresh,
          onFooterRefresh: widget.loadMoreEnable ? _onFooterRefresh : null,
        ),
      );
    }
  }

  refreash({bool isShow = true}) {
    if (widget.other == null || widget.other.length <= 0) return;
    if (!widget.other.containsKey(widget.page))
      widget.other.addAll({widget.page: 1, widget.rows: widget.rows_v});
    widget.page_v = 1;
    widget.other[widget.page] = widget.page_v;
    widget.data.clear();
    widget.isLoading = true;
    if (isShow) reLoad();
    widget.biaoShi != null
        ? loadUrl(widget.methodName, widget.other,
            isShow: false, biaoshi: widget.biaoShi)
        : loadUrl(widget.methodName, widget.other, isShow: false);
  }

  Future<Null> _onHeaderRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print("上拉刷新加载");
      refreash(isShow: false);
    });
  }

  Future<Null> _onFooterRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print("加载更多");
      widget.biaoShi != null
          ? loadUrl(
              widget.methodName,
              widget.other,
              isShow: false,
              biaoshi: widget.biaoShi,
            )
          : loadUrl(widget.methodName, widget.other, isShow: false);
      widget.isLoading = true;
    });
  }

  @override
  onSuccess(String methodName, res) {
    if (widget.mCallback(widget.methodName, res).length > 0) {
      widget.page_v++;
      widget.other[widget.page] = widget.page_v;
      widget.data.addAll(widget.mCallback(widget.methodName, res));
    } else {
      if (widget.data.length > 0) {
        Fluttertoast.showToast(msg: "暂无更多数据");
      }
    }
    widget.isLoading = false;
    reLoad();
  }

  @override
  bool get wantKeepAlive => true;
}
