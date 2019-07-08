import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BannerView.dart';

class MyBanner extends StatelessWidget {
  var height;
  var autoplay;
  var methodName;
  List<Widget> data = new List();

  MyBanner(this.height, this.methodName, this.data, {this.autoplay = true});

  @override
  Widget build(BuildContext context) {
    print("banner");
    return Visibility(
      child: Container(
        height: height,
        child: BannerView(
          data: data,
        ),
      ),
      visible: data.length > 0,
    );
//    Container(
//      height: data.length > 0 ? height : 0,
//      child: Swiper(
//        itemBuilder: (context, index) => data[index],
//        itemCount: data.length,
////        viewportFraction: 0.8,
////        scale: 0.9,
//        autoplay: autoplay,
////          pagination: SwiperPagination(builder: DotSwiperPaginationBuilder(
////            color: Colors.black54,
////            activeColor: Colors.white,
////          )),
//        pagination: SwiperPagination(),
////          control: SwiperControl()
//      ),
//    );
  }
}
