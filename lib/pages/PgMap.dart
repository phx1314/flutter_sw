//import 'package:amap_base/amap_base.dart';
import 'dart:io';
import 'dart:typed_data';

//import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:path_provider/path_provider.dart';

import '../Help.dart';

class PgMap extends StatefulWidget {
  @override
  PgMapState createState() => new PgMapState();
}

class PgMapState extends BaseState<PgMap> {
//  AMapController _controller;
//  final _amapLocation = AMapLocation();

  @override
  void initState() {
    super.initState();

//    _amapLocation.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地图'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () async {
//              final Uint8List bytes = await _controller.screenShot();
//              Directory dir = await getTemporaryDirectory();
//              String path = dir.path + "/地图截图.png";
//              var file = File(path);
//              bool exist = await file.exists();
//              print("path =${path}");
////              if (exist) {
////                file.delete();
////              }
//              File(path).writeAsBytesSync(bytes);
//              Help.sendMsg('PgFileListEdit', 1, file);
//              finish();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                '完成',
                style: Style.text_style_16_white,
              ),
            ),
          )
        ],
      ),
//      body: AMapView(
//        amapOptions: new AMapOptions(camera: CameraPosition(zoom: 15)),
//        onAMapViewCreated: (controller) {
//          controller.setMyLocationStyle(MyLocationStyle());
//          setState(() {
//            _controller = controller;
//          });
//        },
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.my_location),
//        onPressed: () async {
//          if (await Permissions().requestPermission()) {
//            _amapLocation
//                .getLocation(LocationClientOptions(
//              isOnceLocation: true,
//              locatingWithReGeocode: true,
//            ))
//                .then((v) {
//              _controller.changeLatLng(LatLng(v.latitude, v.longitude));
//            }).then((_) => setState(() {}));
//          } else {
//            Scaffold.of(context).showSnackBar(SnackBar(content: Text('权限不足')));
//          }
//        },
//      ),
    );
  }
}
