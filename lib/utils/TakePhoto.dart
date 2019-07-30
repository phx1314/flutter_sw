import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class TakePhoto extends StatefulWidget {
  MethodCallBack mMethodCallBack;

  TakePhoto(this.mMethodCallBack);

  @override
  TakePhotoState createState() => new TakePhotoState();
}

typedef MethodCallBack = void Function(File file);

class TakePhotoState extends BaseState<TakePhoto> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                  child: InkWell(
                    onTap: () => finish(),
                  )),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: _takePhoto,
                          child: Container(
                            padding: EdgeInsets.all(
                                ScreenUtil.getScaleW(context, 15)),
                            width: double.infinity,
                            child: Text(
                              '拍照',
                              style: Style.text_style_16_black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                    Divider(
                      height: 1,
                    ),
                    Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: _openGallery,
                          child: Container(
                            padding: EdgeInsets.all(
                                ScreenUtil.getScaleW(context, 15)),
                            width: double.infinity,
                            child: Text(
                              '从手机相册选择',
                              style: Style.text_style_16_black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                    Container(
                      color: Color(0x66000000),
                      height: ScreenUtil.getScaleW(context, 15),
                    ),
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () => finish(),
                        child: Container(
                          padding:
                          EdgeInsets.all(ScreenUtil.getScaleW(context, 15)),
                          width: double.infinity,
                          child: Text(
                            '取消',
                            textAlign: TextAlign.center,
                            style: Style.text_style_16_black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

/*拍照*/
  _takePhoto() async {
    finish();
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 600, maxHeight: 800);
//    _size2Small(imageFile);
    _cropImage(imageFile);
  }

  /*相册*/
  _openGallery() async {
    finish();
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 600, maxHeight: 800);
//    _size2Small(imageFile);
    _cropImage(imageFile);
  }

  Future<Null> _cropImage(File imageFile) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        imageFile.absolute.path,
        quality: 88,
        rotate: -90,
      );
    }
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );

    widget.mMethodCallBack(croppedFile);
  }

  _size2Small(imageFile) async {
    Help.showLoadingDialog(context);
    var directory = await getTemporaryDirectory();
    String path = await Luban.compressImage(CompressObject(
        imageFile: imageFile,
        path: directory.path,
        mode: CompressMode.LARGE2SMALL,
        step: 10));
    finish();
    finish();
    widget.mMethodCallBack(new File(path));
  }
}
