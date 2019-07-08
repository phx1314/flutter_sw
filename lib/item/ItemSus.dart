import 'package:flutter/material.dart';
import 'package:flutter_std/model/ModelUser.dart';

class ItemSus extends StatelessWidget {
  String txt;

  ItemSus(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$txt',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }
}
