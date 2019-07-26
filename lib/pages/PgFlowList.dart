import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemBase.dart';
import 'package:flutter_std/item/ItemFlow.dart';
import 'package:flutter_std/item/ItemXmxxdj.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelMenuConfig.dart';
import 'package:flutter_std/model/ModelUser.dart';
import 'package:flutter_std/model/ModelWork.dart';
import 'package:flutter_std/pages/PgSearch.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_std/utils/PullListView.dart';

import 'PgHtsk.dart';
import 'PgXzryOne.dart';

class PgFlowList extends StatefulWidget {
  ModelWorkBean item;

  PgFlowList(this.item);

  @override
  State createState() => new PgFlowListState();
}

class PgFlowListState extends BaseState<PgFlowList> {
  PullListView mPullListView;
  String search;
  bool isShow = false;
  List<String> data = ["深化流转单", "成本估算", "成本统计", "合同信息"];
  Map<String, String> map = {
    '深化流转单': 'BussProjCirculation',
    '成本估算': 'BussBiddingEstimateCost',
    '成本统计': 'BussBiddingCost',
    '合同信息': 'BussContract'
  };
  ModelFlowList mModelFlowList;

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        mPullListView.reLoad();
        break;
      case 102:
        BaseEmployeeListBean model = data;
        String ids = '';
        mModelFlowList.rows.forEach((f) {
          if (f.isChecked) {
            ids += f.Id.toString() + ",";
          }
        });
        loadUrl(
            widget.item.MenuNameEng == 'CluePoolInfo'
                ? METHOD_BUSSCLUEBATCHDISTRIBUTION
                : METHOD_BATCHDISTRIBUTION,
            {
              'EmpId': model.EmpID,
              'EmpName': model.EmpName,
              "Ids": ids.substring(0, ids.length - 1),
            });

        break;
      case 888:
//        Map<String, dynamic> map = {"queryInfo": data.toString()};
//        Map<String, dynamic> dd =
//            widget.item.mModelMenuConfig.grid.queryParams[0];
//        dd.remove("queryInfo");
//        map.addAll(dd);
//        mPullListView.other = map;
//        mPullListView.reLoad();
        mPullListView.other.addAll({"queryInfo": data.toString()});
        mPullListView.reLoad();
        break;
      case 889:
        Map<String, dynamic> map =
            widget.item.mModelMenuConfig.grid.queryParams[0];
        map.addAll(data);
        mPullListView.other = map;
        mPullListView.reLoad();
        break;
    }
  }

  @override
  void initView() {
    try {
      search = json.encode(widget.item.mModelMenuConfig.search);
    } catch (e) {
      print(e);
    }

    mPullListView = PullListView(
      haline: true,
      methodName: widget.item.mModelMenuConfig.grid.url[0],
      other: widget.item.mModelMenuConfig.grid.queryParams[0],
      mCallback: (methodName, res) {
        mModelFlowList = ModelFlowList.fromJson(res.data);
        List data = new List();
        mModelFlowList.rows.forEach((f) {
          f.MenuNameEng = widget.item.MenuNameEng;
          f.text = widget.item.text;
          f.MenuMobileConfig = widget.item.MenuMobileConfig;
          f.mModelMenuConfig = ModelMenuConfig.fromJson(json.decode(
              Help.getRightdata(widget.item.MenuMobileConfig, f.toJson())));
          if (widget.item.mModelMenuConfig.grid.listPage == "FlowList") {
            data.add(ItemFlow(f, ''));
          } else if (widget.item.mModelMenuConfig.grid.listPage ==
              "ProjectList") {
            data.add(ItemXmxxdj(f));
          } else if (widget.item.mModelMenuConfig.grid.listPage == "BaseList") {
            data.add(ItemBase(f));
          }
        });
        return data;
      },
    );
  }

  @override
  void onSuccess(String methodName, res) {
    if (methodName == METHOD_BUSSCLUEBATCHRECEIVE ||
        methodName == METHOD_BUSSINESSCUSTOMERBATCHRECEIVE ||
        methodName == METHOD_BUSSCLUECONVERSIONCUSTOMER ||
        methodName == METHOD_BUSSCLUEBATCHDISTRIBUTION ||
        methodName == METHOD_BATCHDISTRIBUTION) {
      Help.Toast(context, '操作成功');
      mPullListView.reLoad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (isShow) {
            isShow = !isShow;
            reLoad();
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: InkWell(
                  onTap: () {
                    if (widget.item.MenuNameEng == 'MyFlowList') {
                      isShow = !isShow;
                      reLoad();
                    }
                  },
                  child: Container(
                    height: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.item.text),
                        Visibility(
                          visible: widget.item.MenuNameEng == 'MyFlowList',
                          child: Icon(
                            isShow
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                        )
                      ],
                    ),
                  )),
              centerTitle: true,
              actions: <Widget>[
                Visibility(
                  visible: search != null,
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: ScreenUtil.getScaleW(context, 25),
                    ),
                    onPressed: () {
                      widget.item.mModelMenuConfig.search =
                          (json.decode(search) as List)
                              .map((i) => SearchListBean.fromJson(i))
                              .toList();
                      Help.goWhere(
                          context,
                          PgSearch(widget.toString(),
                              widget.item.mModelMenuConfig.search));
                    },
                  ),
                ),
              ],
            ),
            body: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Column(children: <Widget>[
                    Visibility(
                        visible: widget.item.MenuNameEng == 'CluePoolInfo' ||
                            widget.item.MenuNameEng == 'BussinessCustomerPool',
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                padding: EdgeInsets.all(10),
                                color: Colors.lightBlue,
                                onPressed: () {
                                  List<int> ids = List();
                                  mModelFlowList.rows.forEach((f) {
                                    if (f.isChecked) {
                                      ids.add(f.Id);
                                    }
                                  });
                                  if (ids.length > 0) {
                                    Help.showAlertDialog(context, '确认要领取吗', () {
                                      loadUrl(
                                          widget.item.MenuNameEng ==
                                                  'CluePoolInfo'
                                              ? METHOD_BUSSCLUEBATCHRECEIVE
                                              : METHOD_BUSSINESSCUSTOMERBATCHRECEIVE,
                                          {
                                            "id": ids,
                                          },
                                          isFormData: false);
                                    });
                                  } else {
                                    Help.Toast(context, '请选择');
                                  }
                                },
                                child: Text(
                                  '批量领取',
                                  style: Style.text_style_13_white,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            Expanded(
                              child: RaisedButton(
                                padding: EdgeInsets.all(10),
                                color: Colors.lightBlue,
                                onPressed: () {
                                  List<int> ids = List();
                                  mModelFlowList.rows.forEach((f) {
                                    if (f.isChecked) {
                                      ids.add(f.Id);
                                    }
                                  });
                                  if (ids.length > 0) {
                                    Help.goWhere(
                                        context, PgXzryOne(widget.toString()));
                                  } else {
                                    Help.Toast(context, '请选择');
                                  }
                                },
                                child: Text(
                                  '批量分配',
                                  style: Style.text_style_13_white,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(
                                    widget.item.MenuNameEng == 'CluePoolInfo'
                                        ? 5
                                        : 0)),
                            widget.item.MenuNameEng == 'CluePoolInfo'
                                ? Expanded(
                                    child: RaisedButton(
                                      padding: EdgeInsets.all(10),
                                      color: Colors.lightBlue,
                                      onPressed: () {
                                        List<int> ids = List();
                                        mModelFlowList.rows.forEach((f) {
                                          if (f.isChecked) {
                                            ids.add(f.Id);
                                          }
                                        });
                                        if (ids.length > 0) {
                                          Help.showAlertDialog(
                                              context, '确认要转化客户吗', () {
                                            loadUrl(
                                                METHOD_BUSSCLUECONVERSIONCUSTOMER,
                                                {
                                                  "id": ids,
                                                },
                                                isFormData: false);
                                          });
                                        } else {
                                          Help.Toast(context, '请选择');
                                        }
                                      },
                                      child: Text(
                                        '转换客户',
                                        style: Style.text_style_13_white,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ]),
                        )),
                    Expanded(child: mPullListView),
                  ]),
                  Visibility(
                      visible: isShow,
                      child: Container(
                        width: double.infinity,
                        color: Color(0x66000000),
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              height: ScreenUtil.getScaleW(context, 200),
                              child: ListView.separated(
                                itemCount: data.length,
                                separatorBuilder: (context, index) => Divider(
                                      height: 1,
                                    ),
                                // 添加分割线
                                itemBuilder: (context, index) {
                                  return Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        widget.item = new ModelWorkBean();
                                        widget.item.MenuNameEng = 'MyFlowList';
                                        widget.item.text = data[index];
                                        widget.item.MenuMobileConfig =
                                            Help.mMap_bd[map[data[index]]];
                                        widget.item.mModelMenuConfig =
                                            ModelMenuConfig.fromJson(
                                                json.decode(widget
                                                    .item.MenuMobileConfig));
                                        isShow = !isShow;
                                        mPullListView.other = widget
                                            .item
                                            .mModelMenuConfig
                                            .grid
                                            .queryParams[0];
                                        mPullListView.methodName = widget
                                            .item.mModelMenuConfig.grid.url[0];
                                        mPullListView.reLoad();
                                        reLoad();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height:
                                            ScreenUtil.getScaleW(context, 45),
                                        child: Text(
                                          data[index],
                                          style: Style.text_style_16_black,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      isShow = false;
                                      reLoad();
                                    },
                                    child: Container())),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            floatingActionButton:  widget.item.mModelMenuConfig.grid.addUrl !=
                            null &&
                        widget.item.mModelMenuConfig.grid.addUrl.length > 0  &&
                    widget.item.MenuNameEng != "CluePoolInfo" &&
                        widget.item.MenuNameEng != "BussinessCustomerPool"
                ? FloatingActionButton(
                    onPressed: () {
                      if (widget.item.MenuNameEng == "contract_feerecv" ||
                          widget.item.MenuNameEng == "contract_invoice") {
                        Help.goWhere(
                            context,
                            PgHtsk(
                                widget.item.mModelMenuConfig.grid.saveUrl[0],
                                0,
                                "${Help.BASEURL}/${widget.item.mModelMenuConfig.grid.addUrl[0]}" +
                                    (widget.item.mModelMenuConfig.grid.addUrl[0]
                                            .contains('?')
                                        ? '&a='
                                        : '?a=') +
                                    "${Uri.encodeComponent(Help.mModelUser.name)}&p=${md5.convert(utf8.encode(Help.mModelUser.password)).toString()}",
                                widget.item.MenuNameEng));
                      } else {
                        RowsListBean mRowsListBean = new RowsListBean();
                        mRowsListBean.mModelMenuConfig =
                            widget.item.mModelMenuConfig;
                        mRowsListBean.MenuNameEng = widget.item.MenuNameEng;
                        mRowsListBean.text = widget.item.text;
                        Help.go2PubView(context, mRowsListBean, "");
                      }
                    },
                    child: Icon(Icons.add,
                        size: ScreenUtil.getScaleW(context, 40)),
                  )
                : null));
  }
}
