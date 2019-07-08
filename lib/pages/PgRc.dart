import 'package:flutter/material.dart';
import 'package:flutter_std/utils/BaseState.dart';
import 'package:flutter_std/utils/GSYStyle.dart';
import 'package:table_calendar/table_calendar.dart';

class PgRc extends StatefulWidget {
  @override
  PgRcState createState() => new PgRcState();
}

class PgRcState extends BaseState<PgRc> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          TableCalendar(
            forcedCalendarFormat: CalendarFormat.month,
          ),
          Expanded(
            child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) => Divider(
                      height: 1,
                    ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'ceddas',
                      style: Style.text_style_14_black,
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
