import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelUserDetail.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:flutter_std/utils/PgPubEdit.dart';
import 'package:flutter_std/utils/TakePhoto.dart';
import 'package:url_launcher/url_launcher.dart';

class PgGrzl extends StatefulWidget {
  int id;

  PgGrzl(this.id);

  @override
  PgGrzlState createState() => new PgGrzlState();
}

class PgGrzlState extends BaseState<PgGrzl> {
  ModelUserDetail mModelUserDetail;

  @override
  void loadData() {
    loadUrl(METHOD_EDITINFO, {'id': widget.id});
  }

  @override
  void disMsg(int what, data) {
    switch (what) {
      case 101:
        loadUrl(METHOD_UPDATE_USERINFO, {
          'EmpTel': data.toString(),
          'EmpNote': mModelUserDetail.model.EmpNote,
          'EmpTitle': mModelUserDetail.model.EmpTitle
        });
        break;
      case 102:
        loadUrl(METHOD_UPDATE_USERINFO, {
          'EmpTel': mModelUserDetail.model.EmpTel,
          'EmpNote': data.toString(),
          'EmpTitle': mModelUserDetail.model.EmpTitle
        });
        break;
    }
  }

  @override
  onSuccess(String m, r) async {
    if (m == METHOD_EDITINFO) {
      mModelUserDetail = ModelUserDetail.fromJson(r.data);
      if (mModelUserDetail.model.EmpID == Help.mModelUser.UserInfo.EmpID) {
        Help.mModelUser.UserInfo.EmpHead = mModelUserDetail.model.EmpHead;
        Help.mModelUser.UserInfo.EmpTel = mModelUserDetail.model.EmpTel;
        Help.mModelUser.UserInfo.EmpNote = mModelUserDetail.model.EmpNote;
        await Help.save("mModelUser", json.encode(Help.mModelUser.toJson()));
      }
      reLoad();
    } else if (m == METHOD_ChangeAvatar1 || m == METHOD_EDITINFO) {
      loadUrl(METHOD_EDITINFO, {'id': widget.id});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('个人资料'),
            //标题居中
            centerTitle: true,
            expandedHeight: ScreenUtil.getScaleH(context, 275),
            //不随着滑动隐藏标题
            floating: false,
            //固定在顶部
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned.fill(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      "static/images/bj_grzx.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(
                              ScreenUtil.getScaleW(context, 10))),
                      InkWell(
                        onTap: getImage,
                        child: CircleAvatar(
                          radius: ScreenUtil.getScaleW(context, 40),
                          backgroundColor: Color.fromRGBO(158, 217, 235, 1),
                          backgroundImage: mModelUserDetail != null
                              ? CachedNetworkImageProvider(
                              Help.ImageUrl +
                                      (mModelUserDetail.model.EmpHead.isEmpty
                                          ? '0'
                                          : mModelUserDetail.model.EmpHead),
                                  cacheManager: Help.mImageCacheManager)
                              : null,
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.all(ScreenUtil.getScaleW(context, 5))),
                      Text(
                        mModelUserDetail != null
                            ? mModelUserDetail.model.EmpName
                            : '',
                        style: Style.text_style_16_white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            Container(
              padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    '所属部门',
                    style: Style.text_style_16_black,
                  )),
                  Text(
                    mModelUserDetail != null
                        ? mModelUserDetail.model.EmpDepName
                        : '',
                    style: Style.text_style_13_gray,
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey)
                ],
              ),
            ),
            Divider(height: 1),
            Container(
              padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    '职务职称',
                    style: Style.text_style_16_black,
                  )),
                  Text(
                    mModelUserDetail != null
                        ? mModelUserDetail.model.EmpTitle
                        : '',
                    style: Style.text_style_13_gray,
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey)
                ],
              ),
            ),
            Divider(height: 1),
            Material(
              color: Colors.white,
              child: InkWell(
//                onTap: callPhone,
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        '联系电话',
                        style: Style.text_style_16_black,
                      )),
                      Text(
                        mModelUserDetail != null
                            ? mModelUserDetail.model.EmpTel
                            : '',
                        style: Style.text_style_13_gray,
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey)
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 1),
            Material(
              color: Colors.white,
              child: InkWell(
//                onTap: () {
//                  Help.goWhere(
//                      context,
//                      PgPubEdit(
//                          '请输入个性签名',
//                          widget.toString(),
//                          mModelUserDetail.model.EmpNote,
//                          102,
//                          500,
//                          TextInputType.text));
//                },
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 12)),
                  child: Row(
                    children: [
                      Text(
                        '个性签名  ',
                        style: Style.text_style_16_black,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            mModelUserDetail != null
                                ? mModelUserDetail.model.EmpNote
                                : '',
                            style: Style.text_style_13_gray,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey)
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 1),
          ]))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  getImage() async {
    if (Help.mModelUser.UserInfo.EmpID == widget.id) {
      Help.showMyDialog(context, TakePhoto((img) {
        if (img != null) {
          print(Help.getRollupSize(img.lengthSync()));
          loadUrl(METHOD_ChangeAvatar1, {"file": UploadFileInfo(img, 'img')},isFormData: true);
        }
      }));
    }
  }

  void callPhone() {
    if (mModelUserDetail.model.EmpID != Help.mModelUser.UserInfo.EmpID) {
      launch("tel:${mModelUserDetail.model.EmpTel}");
      return;
    }
    if (mModelUserDetail.model.EmpTel != null &&
        mModelUserDetail.model.EmpTel.isNotEmpty) {
      return;
    }
    Help.goWhere(
        context,
        PgPubEdit('请输入手机号', widget.toString(), mModelUserDetail.model.EmpTel,
            101, 11, TextInputType.phone));
  }
}
