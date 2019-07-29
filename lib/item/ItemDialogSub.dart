import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelFlowList.dart';
import 'package:flutter_std/model/ModelJDInfo.dart';
import 'package:flutter_std/model/ModelUser.dart';
import 'package:flutter_std/pages/PgXzry.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';

class ItemDialogSub extends StatefulWidget {
  String from;
  String title;
  RowsListBean item;
  bool isLast;
  bool data = false;

  ItemDialogSub(this.from, this.title, this.item, this.isLast);

  @override
  ItemDialogSubState createState() => new ItemDialogSubState();
}

class ItemDialogSubState extends BaseState<ItemDialogSub> {
  List data_bz = new List();
  List data_ry = new List();
  dynamic s_bz;
  dynamic s_ry;
  ModelJDInfo mModelJDInfo;
  TextEditingController mController = TextEditingController();
  bool isHq = false;
  String hqText = '请选择';
  String ids = "";

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 101:
        hqText = Help.getNames(data);
        ids = Help.getIDs(data);
        reLoad();
        break;
      case 889:
        widget.data = data;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Padding(
        padding: EdgeInsets.only(
            bottom: widget.data ? ScreenUtil.getScaleH(context, 210) : 0),
        child: Center(
          //保证控件居中效果
          child: new SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
//          height: MediaQuery.of(context).size.height * 0.5,
            child: new Container(
              height: ScreenUtil.getScaleW(context, 330),
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 15)),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(80, 202, 176, 1),
                          fontSize: 16,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 13)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '步骤',
                          style: Style.text_style_16_black,
                        ),
                        Padding(
                            padding: EdgeInsets.all(
                                ScreenUtil.getScaleW(context, 13))),
                        Expanded(
                          child: DropdownButton(
                            style: Style.text_style_16_black,
                            items: _getItems(data_bz),
                            value: s_bz,
                            onChanged: (itemValue) {
                              _onChangedBz(itemValue);
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                right: ScreenUtil.getScaleW(context, 40))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 13)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '人员',
                          style: Style.text_style_16_black,
                        ),
                        Padding(
                            padding: EdgeInsets.all(
                                ScreenUtil.getScaleW(context, 13))),
                        Expanded(
                          child: isHq
                              ? InkWell(
                                  onTap: () {
                                    Help.goWhere(
                                        context,
                                        PgXzry(
                                          widget.toString(),
                                          ids: ids,
                                        ));
                                  },
                                  child: Text(
                                    hqText,
                                    style: Style.text_style_16_black,
                                  ),
                                )
                              : DropdownButton(
                                  style: Style.text_style_16_black,
                                  items: _getItems(data_ry),
                                  value: s_ry,
                                  onChanged: (itemValue) {
                                    _onChangedRy(itemValue);
                                  },
                                ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                right: ScreenUtil.getScaleW(context, 40))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.all(ScreenUtil.getScaleW(context, 13)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          Visibility(
//                            visible: false,
//                            child: Text(
//                              '意见',
//                              style: Style.text_style_16_black,
//                            ),
//                          ),
//                          Padding(
//                              padding: EdgeInsets.all(
//                                  ScreenUtil.getScaleW(context, 13))),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              controller: mController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 5),
                                labelText: '请输入意见',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: _onSub,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '确定',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(80, 202, 176, 1),
                                  fontSize: 16,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Color(GSYColors.f2f2f2),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '取消',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(80, 202, 176, 1),
                                fontSize: 16,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _onSub() async {
    Navigator.pop(context);
    if (s_ry is String && s_ry.toString().contains("无可选择人员")) {
      return;
    }
    Map<String, dynamic> map = new Map();
    map['_refID'] = widget.item.Id;
    map['_refTable'] = widget.item.FlowRefTable;
    map['_flowNodeID'] = widget.item.FlowNodeID;
    map['_action'] = widget.item.action.split("_")[1];
    map['_flowMultiSignID'] = widget.item.FlowMultiSignID;
    map['_note'] = mController.text;
    if (mModelJDInfo != null && mModelJDInfo.NextSteps.length > 0) {
      map['_nextNodeID'] = s_bz.NodeID;
      if (isHq) {
        if (ids != '') {
          map['_nextEmpIDs'] = ids;
        } else {
          Help.Toast(context, "请选择会签人员");
          return;
        }
      } else {
        map['_nextEmpIDs'] = s_bz.Users.length > 0 ? s_ry.ID.toString() : "0";
      }
    } else {
      map['_nextNodeID'] = 0;
      map['_nextEmpIDs'] = "0";
    }
    Help.sendMsg(widget.from, 300, map);
  }

//返回城市列表，写法二
  List<DropdownMenuItem> _getItems(List list) {
    List<DropdownMenuItem> items = new List();
    list.forEach((item) {
      items.add(DropdownMenuItem(
        value: item,
        child: Text(() {
          if (item is String) {
            return item;
          } else if (item is NextStepsListBean) {
            return item.NodeName;
          } else if (item is UsersListBean) {
            return item.Name;
          }
        }()),
      ));
    });
    return items;
  }

  _onChangedBz(var value) {
    if (value is String) {
      s_bz = value;
    } else if (value is NextStepsListBean) {
      s_bz = value;
      selectRy(value);
    }
    reLoad();
  }

  _onChangedRy(var value) {
    s_ry = value;
    reLoad();
  }

  @override
  void loadData() {
    addLast();
    if (!widget.isLast) {
      if (widget.item.IsNew) {
        widget.item.FlowNodeID = 0;
      }
      loadUrl(METHOD_FLOWWIDGET, {
        "_refID": widget.item.Id.toString(),
        "_refTable": widget.item.FlowRefTable,
        "_flowNodeID": widget.item.FlowNodeID,
        "_action": widget.item.action,
        "_flowMultiSignID": widget.item.FlowMultiSignID
      });
    }
  }

  void addLast() {
    data_bz.add("流程结束");
    data_ry.add("不需要选择");
    s_bz = data_bz[0];
    s_ry = data_ry[0];
  }

  @override
  onSuccess(String methodName, res) {
    if (methodName == METHOD_FLOWWIDGET) {
      mModelJDInfo = ModelJDInfo.fromJson(json.decode(res.json));
      data_bz.clear();
      data_ry.clear();
      if (mModelJDInfo.NextSteps.length > 0) {
        data_bz.addAll(mModelJDInfo.NextSteps);
        s_bz = data_bz[0];
        selectRy(mModelJDInfo.NextSteps[0]);
      } else {
        addLast();
      }
      mController.text = mModelJDInfo.DefaultNote;
      reLoad();
    }
  }

  void selectRy(NextStepsListBean mNextStepsListBean) {
    if (mNextStepsListBean.NodeName.contains("会签")) {
      isHq = true;
      if (mNextStepsListBean.ChoosedUsers != null &&
          mNextStepsListBean.ChoosedUsers != '') {
        hqText = mNextStepsListBean.ChoosedUserNames;
        ids = mNextStepsListBean.ChoosedUsers;
      }
    } else {
      isHq = false;
      data_ry.clear();

      if (mNextStepsListBean.Users != null &&
          mNextStepsListBean.Users.length > 0) {
        data_ry.addAll(mNextStepsListBean.Users);
      } else {
        data_ry.add("无可选择人员");
      }
      int position = 0;
      if (mNextStepsListBean.DefaultChoosedUser != null) {
        for (int i = 0; i < data_ry.length; i++) {
          if (mNextStepsListBean.DefaultChoosedUser == data_ry[i].ID) {
            position = i;
            break;
          }
        }
      }

      s_ry = data_ry[position];
    }
  }
}
