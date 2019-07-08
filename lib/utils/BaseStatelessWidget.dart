import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/model/ModelCount.dart';
import 'package:flutter_std/utils/HttpManager.dart';
import 'package:flutter_std/utils/HttpResponseListener.dart';

abstract class BaseStatelessWidget extends StatelessWidget
    implements HttpResponseListener {
  @override
  onFailure(String methodName, res) {
    return null;
  }

  @override
  onSuccess(String methodName, res) {
    return null;
  }

  loadUrl(BuildContext context, String url, Map<String, dynamic> other,
      {isFormData = true, isShow = true, biaoshi}) async {
    await HttpManager.netFetch(context, url, other, this,
        isFormData: isFormData, isShow: isShow, methodName: biaoshi ?? url);
  }
}
