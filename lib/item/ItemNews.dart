import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/pages/PgWebDetail.dart';

class ItemNews extends StatelessWidget {
  var item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Help.goWhere(
            context, PgWebDetail(item.Id, "OaNew", "oa/oanewmobile/Query"));
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil.getScaleW(context, 7)),
        height: ScreenUtil.getScaleW(context, 80),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.NewsTitle,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    )),
                Expanded(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(item.NewsTypeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )),
                      Expanded(
                          child: Text(item.NewsDate.toString(),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              )))
                    ],
                  ),
                )
              ],
            )),
            Visibility(
              child: Container(
                  padding:
                      EdgeInsets.only(left: ScreenUtil.getScaleW(context, 7)),
//                  decoration: BoxDecoration(
//                      image: DecorationImage(
//                          image: ExactAssetImage("images/default_avatar.png"),fit: BoxFit.fill)
//                  ),
                  child: item.NewsImage == null
                      ? Container()
                      : CachedNetworkImage(
                          imageUrl: Help.IMAGE_STAR + item.NewsImage,
                          cacheManager: Help.mImageCacheManager,
//                      Config.image_star + item.NewsImage,
                          width: ScreenUtil.getScaleW(context, 165),
                          height: double.infinity,
                          fit: BoxFit.cover)),
              visible: item.NewsImage != null,
            )
          ],
        ),
      ),
    );
  }

  ItemNews(this.item);
}
