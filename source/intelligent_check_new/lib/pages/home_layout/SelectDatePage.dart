import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/ExperimentModel.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/services/CommonServices/CommonServices.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDatePage extends StatefulWidget {
  SelectDatePage();
  @override
  _TimePage createState() => _TimePage();

}

class _TimePage extends State<SelectDatePage> {
  UserModel userInfo;
  String selDate=DateFormat("yyyy/MM/dd").format(DateTime.now()).toString();
  List<ExpModel> list=new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InitData();
  }
  InitData()async{

    await SharedPreferences.getInstance().then((sp) {
      if(!mounted){return;}
      setState(() {
        if (sp.getString("userModel") != null) {
          userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
        }
      });
    });
    var data=await GetTodaysTask(userInfo.account,selDate,userInfo.role);
    if(data.success){

      if(!mounted){return;}
      setState(() {
        list=[];
        for (var str in data.dataList) {
          var model=  ExpModel.fromJson((str));
          list.add(model);
        }
      });
    }
  }
  void searchNewData(date) async{
    selDate=DateFormat("yyyy/MM/dd").format(date).toString();
    var data=await GetTodaysTask(userInfo.account,selDate,userInfo.role);
    if(data.success){
      if(!mounted){return;}
      setState(() {
        list=[];
        for (var str in data.dataList) {
        var model=  ExpModel.fromJson((str));
        list.add(model);
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GetConfig.getColor("red"),
        centerTitle: true,
        title: Text("TimeLine"),
      ),
      body:  Container(
        margin: EdgeInsets.symmetric(
          horizontal: 2.0,
          vertical: 10.0,
        ),
        child: ListView(
          children: <Widget>[
            Calendar(
              initialCalendarDateOverride:DateTime.now(),
              onSelectedRangeChange: (range) =>
                  print("Range is ${range.item1}, ${range.item2}"),
              onDateSelected: (date) => searchNewData(date),
            ),
            Divider(
              height: 50.0,
            ),
            userInfo==null?Container():Container(
              child: Column(
                children:list.map((f){
                  return Stack(
                    children: <Widget>[
                      //项目
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0),
                        child: Card(
                        elevation:5,
                          margin: EdgeInsets.only(top: 10, left: 20, bottom: 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                            width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${f.eName}"),
                                ),
                                Divider(color: Colors.red,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("教师：${f.tName}"),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("时间：${DateFormat("yyyy年MM月dd（EEEE）","zh").format(DateTime.parse(f.sDate))}"),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("节次：${f.section}"),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("教室：${f.rNumber}"),
                                ), Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("备注：${f.remark}"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        bottom: 0.0,
                        left: 10.0,
                        child: Container(
                          height: double.infinity,
                          width: 1.5,
                          color:Colors.red,
                        ),
                      ),
                      Positioned(
                        top: 20.0,
                        left: 4.8,
                        child: Container(
                          height: 12.0,
                          width: 12.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(3.0),
                            height: 8.0,
                            width: 8.0,
                            decoration:
                            BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                          ),
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

