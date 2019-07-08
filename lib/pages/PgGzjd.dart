import 'package:flutter/material.dart';
import 'package:flutter_std/Help.dart';
import 'package:flutter_std/item/ItemGzjd.dart';
import 'package:flutter_std/model/ModelGzjd.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/PullListView.dart';

class PgGzjd extends StatefulWidget {
  String id;

  PgGzjd(this.id);

  @override
  PgGzjdState createState() => new PgGzjdState();
}

class PgGzjdState extends BaseState<PgGzjd> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('审批进度'),
        centerTitle: true,
      ),
      body: PullListView(
        methodName: METHOD_GETFLOWEXE,
        other: {"flowID": widget.id},
        mCallback: (methodName, res) {
          if (methodName == METHOD_GETFLOWEXE) {
            ModelGzjd mModelGzjd = ModelGzjd.fromJson(res.data);
            List data = new List();
            mModelGzjd.rows.forEach((item) {
              data.add(ItemGzjd(item, data.length));
            });
            return data;
          }
        },
      ),
    );
  }
}
