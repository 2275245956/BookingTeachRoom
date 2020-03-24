import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';

class SelectDatePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: TimePage(),
    );
  }
}

class TimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GetConfig.getColor("red"),
        centerTitle: true,
        title: Text("时间轴"),
      ),
      body: TimeLinePage(),
    );
  }
}

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 10.0,
      ),
      child: ListView(
        children: <Widget>[
          Calendar(
            initialCalendarDateOverride:DateTime(2000,1,1),
            onSelectedRangeChange: (range) =>
                print("Range is ${range.item1}, ${range.item2}"),
            onDateSelected: (date) => handleNewDate(date),
          ),
          Divider(
            height: 50.0,
          ),
          _buildTimeLine('第一节'),
          _buildTimeLine('第二节'),
          _buildTimeLine('第三节'),
          _buildTimeLine('第四节'),
          _buildTimeLine('第五节'),
        ],
      ),
    );
  }

  /// handle new date selected event
  void handleNewDate(date) {}

  Widget _buildTimeLine(String message) {
    return Stack(
      children: <Widget>[
        //项目
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Card(
            margin: EdgeInsets.only(top: 0, left: 20, bottom: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("${message}    8:20 ~ 9:00"),
                  ),
                  Divider(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("教室：4-105"),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("实验名称：C++"),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("教师：XXX"),
                  ),

                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 15.0,
          child: Container(
            height: double.infinity,
            width: 2.0,
            color: Colors.red,
          ),
        ),
        Positioned(
          top: 0.0,
          left: 8.5,
          child: Container(
            height: 15.0,
            width: 15.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Container(
              margin: EdgeInsets.all(3.0),
              height: 10.0,
              width: 10.0,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            ),
          ),
        )
      ],
    );
  }
}
