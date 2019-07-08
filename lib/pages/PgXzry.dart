import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/item/ItemTxl.dart';
import 'package:flutter_std/model/ModelUser.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:lpinyin/lpinyin.dart';

import '../Help.dart';
import 'PgAzList.dart';

class PgXzry extends StatefulWidget {
  String ids;
  String from;

  PgXzry(this.from, {this.ids});

  @override
  PgXzryState createState() => new PgXzryState();
}

class PgXzryState extends BaseState<PgXzry> {
  List<BaseEmployeeListBean> mBaseEmployeeListBeans;
  List<BaseEmployeeListBean> mCheckeds = new List();
  TextEditingController mTextEditingController = new TextEditingController();

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 0:
        mCheckeds.clear();
        mBaseEmployeeListBeans.clear();
        Help.mModelUser.BaseEmployee.forEach((f) {
          if (f.EmpID == data.EmpID) {
            f.isChecked = data.isChecked;
          }
          if (f.isChecked) {
            mCheckeds.add(f);
          }

          if (f.EmpName.indexOf(mTextEditingController.text) != -1 ||
              PinyinHelper.getFirstWordPinyin(
                      f.EmpName.substring(0, 1).toUpperCase())
                  .contains(mTextEditingController.text) ||
              PinyinHelper.getFirstWordPinyin(f.EmpName.substring(0, 1))
                  .contains(mTextEditingController.text)) {
            mBaseEmployeeListBeans.add(f);
          }
        });
        reLoad();
        break;
    }
  }

  @override
  void initView() {
    Help.mModelUser.BaseEmployee.forEach((f) {
      f.isChecked =
          widget.ids != null && widget.ids.contains(f.EmpID.toString());
      if (f.isChecked) {
        mCheckeds.add(f);
      }
    });
    mBaseEmployeeListBeans =
        (json.decode(json.encode(Help.mModelUser.BaseEmployee)) as List)
            .map((i) => BaseEmployeeListBean.fromJson(i))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: new AppBar(
              title: new Text('选择人员'),
              centerTitle: true,
              actions: <Widget>[
                InkWell(
                  onTap: () => goBack(),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      '确认',
                      style: Style.text_style_16_white,
                    ),
                  ),
                )
              ],
              bottom: TabBar(
                onTap: (index) {},
                tabs: <Widget>[
                  Tab(text: "按A-Z"),
                  Tab(text: "按部门"),
                  Tab(text: "已选择(${mCheckeds.length})")
                ],
                isScrollable: false,
//                labelColor: Colors.white,
//                unselectedLabelColor: Colors.white,
                unselectedLabelStyle: new TextStyle(fontSize: 16.0),
                labelStyle:
                    new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              )),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: Style.text_style_16_black,
                  controller: mTextEditingController,
                  onChanged: (text) {
                    mBaseEmployeeListBeans.clear();
                    Help.mModelUser.BaseEmployee.forEach((f) {
                      if (f.EmpName.indexOf(text) != -1 ||
                          PinyinHelper.getFirstWordPinyin(
                                  f.EmpName.substring(0, 1).toUpperCase())
                              .contains(text) ||
                          PinyinHelper.getFirstWordPinyin(
                                  f.EmpName.substring(0, 1))
                              .contains(text)) {
                        mBaseEmployeeListBeans.add(f);
                      }
                    });
                    reLoad();
                  },
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      size: ScreenUtil.getScaleW(context,20),
                    ),
                    contentPadding: EdgeInsets.all(ScreenUtil.getScaleW(context,5)),
                    hintText: '请输入',
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    PgAzList(Help.getModelAz(mBaseEmployeeListBeans, '0'), 2),
                    PgAzList(Help.getModelAz(mBaseEmployeeListBeans, '1'), 2),
                    ListView.separated(
                      itemCount: mCheckeds.length,
                      separatorBuilder: (context, index) => Container(
                            height: 1,
                            color: Color(GSYColors.f2f2f2),
                          ),
                      itemBuilder: (context, index) {
                        return ItemTxl(mCheckeds[index], 2);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  goBack() {
    Help.sendMsg(widget.from, 101, mCheckeds);
    finish();
  }
}
