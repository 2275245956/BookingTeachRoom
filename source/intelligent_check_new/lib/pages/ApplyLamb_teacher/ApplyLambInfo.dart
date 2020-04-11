import 'dart:convert' show json;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/RoomModel.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/services/TeacherServices/TechServices.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/tools/min_calendar/mini_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyLambInfo extends StatefulWidget {
  final RoomModel roomInfo;
  final dynamic selValue;
  final List<DateDay> selDateMa;

  ApplyLambInfo(this.roomInfo, this.selValue, this.selDateMa);

  @override
  _ApplyLambInfo createState() => new _ApplyLambInfo();
}

class _ApplyLambInfo extends State<ApplyLambInfo> {
  bool isAnimating = false;
  bool canOperate = true;
  String theme = "red";
  UserModel userInfo;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController remark = new TextEditingController();
  TextEditingController lambName = new TextEditingController();

  List<DropdownMenuItem> droplist = new List<DropdownMenuItem>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    await SharedPreferences.getInstance().then((sp) {
      setState(() {
        if (sp.getString("userModel") != null) {
          userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
        }
      });
    });
//    var data = await GetAllLambName();
//    if (data.success) {
//      setState(() {
//        droplist.add(new DropdownMenuItem(
//          child: new Text(
//            "请选择",
//            style: TextStyle( fontSize: 18),
//          ),
//          value: "请选择",
//        ));
//        for (var exp in data.dataList) {
//          var expModel = new ExperimentModel.fromJson(exp);
//          droplist.add(new DropdownMenuItem(
//            child: new Text(
//              "${expModel.eName}",
//              style: TextStyle(color: GetConfig.getColor(theme), fontSize: 18),
//            ),
//            value: "${expModel.eName}",
//          ));
//        }
//      });
//    } else {
//      GetConfig.popUpMsg("未查询到学校的实验种类，可在备注处填写实验名称等信息！");
//    }
  }

  void SaveInfo() async {
    List<postFilter> list = new List();
    var data=[];
    for (var str in this.widget.selDateMa) {
      var jsonStr = {
        "tNumber": userInfo.account,
        "tName": userInfo.userName,
        "rNumber": this.widget.roomInfo.rNumber,
        "rMaxPer": this.widget.roomInfo.rMaxPer,
        "eDate":  str.toString(),
        "eTime": this.widget.selValue["eTime"],
        "sDate": str.toString(),
        "sTime": this.widget.selValue["sTime"],
        "section": this.widget.selValue["section"],
        "eName": lambName.text,
        "remark": remark.text
      };

      data.add(jsonStr);
    }
    await SaveApplyIfo(data).then((data) {
      if (data.success) {
        GetConfig.popUpMsg(data.message);
      } else {
        GetConfig.popUpMsg(data.message ?? "提交申请失败！");
      }
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo != null && this.widget.roomInfo != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "实验信息",
            style: TextStyle(
              color: Colors.black,
              fontSize: 19,
            ),
          ),
          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: new Container(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_left,
                  color: GetConfig.getColor(
                      theme) /*Color.fromRGBO(209, 6, 24, 1)*/,
                  size: 32),
            ),
          ),
        ),
        body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
            key: _formKey,
            child: new SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "教师名称",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${userInfo.userName}(${userInfo.account})",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
//height: 50,
                          child: Text(
                            "教室名",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${this.widget.roomInfo.attriText01}-${this.widget.roomInfo.rName}",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
//height: 50,
                          child: Text(
                            "教室编号",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${this.widget.roomInfo.rNumber}",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
//height: 50,
                          child: Text(
                            "最大人数",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${this.widget.roomInfo.rMaxPer}",
                          style: TextStyle(
                              color: GetConfig.getColor(theme), fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "开始时间",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${this.widget.selValue["sDate"]}",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "结束时间",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${this.widget.selValue["eDate"]}",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
//height: 50,
                          child: Text(
                            "节次",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${this.widget.selValue["section"]}",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "实验名称",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            textInputAction: TextInputAction.done,
                            autofocus: true,
                            controller: lambName,
                            maxLines: 1,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              enabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5), //边角为30
                                ),
                                borderSide: BorderSide(
                                  color: GetConfig.getColor(theme),
                                  //边线颜色为黄色
                                  width: 2, //边线宽度为2
                                ),
                              ),
                              hintText: "请输入实验名称",
                              filled: true,
                              fillColor: Color.fromRGBO(244, 244, 244, 1),
                            ),
                          ))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
//height: 50,
                          child: Text(
                            "备注",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.only(top: 5, bottom: 5, right: 10),
                          child: TextField(
                            autofocus: false,
                            style: TextStyle(fontSize: 18),
                            textInputAction: TextInputAction.done,
                            controller: remark,
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              enabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5), //边角为30
                                ),
                                borderSide: BorderSide(
                                  color: GetConfig.getColor(theme),
                                  //边线颜色为黄色
                                  width: 2, //边线宽度为2
                                ),
                              ),
                              hintText: "请输入备注名称",
                              filled: true,
                              fillColor: Color.fromRGBO(244, 244, 244, 1),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        persistentFooterButtons: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width / 2) - 16,
                height: 60,
                margin: EdgeInsets.only(left: 0),
                child: new MaterialButton(
                  color: Color.fromRGBO(242, 246, 249, 1),
                  height: 60,
                  textColor: Colors.black,
                  child: new Text(
                    '重置',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    setState(() {
                      remark.text = "";
                    });
                  },
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width / 2),
                child: new MaterialButton(
                  color: GetConfig.getColor(theme),
                  height: 60,
                  textColor: Colors.white,
                  child: new Text('提交', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    GetConfig.IOSPopMsg("提示", Text("确认无误后点击确定提交！"), context,
                        confirmFun: SaveInfo);
                  },
                ),
              ),
            ],
          ),
        ],
        resizeToAvoidBottomPadding: true,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "实验信息",
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
        elevation: 0.2,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: new Container(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left,
                color:
                    GetConfig.getColor(theme) /*Color.fromRGBO(209, 6, 24, 1)*/,
                size: 32),
          ),
        ),
      ),
    );
  }
}
class postFilter {

  String rMaxPer;
  String rNumber;
  String eDate;
  String eName;
  String eTime;
  String remark;
  String sDate;
  String sTime;
  String section;
  String tName;
  String tNumber;

  postFilter.fromParams({this.rMaxPer, this.rNumber, this.eDate, this.eName, this.eTime, this.remark, this.sDate, this.sTime, this.section, this.tName, this.tNumber});

  factory postFilter(jsonStr) => jsonStr == null ? null : jsonStr is String ? new postFilter.fromJson(json.decode(jsonStr)) : new postFilter.fromJson(jsonStr);

  postFilter.fromJson(jsonRes) {
    rMaxPer = jsonRes['rMaxPer'].toString();
    rNumber = jsonRes['rNumber'].toString();
    eDate = jsonRes['eDate'];
    eName = jsonRes['eName'];
    eTime = jsonRes['eTime'];
    remark = jsonRes['remark'];
    sDate = jsonRes['sDate'];
    sTime = jsonRes['sTime'];
    section = jsonRes['section'];
    tName = jsonRes['tName'];
    tNumber = jsonRes['tNumber'];
  }

  @override
  String toString() {
    return '{"rMaxPer": ${rMaxPer != null?'${json.encode(rMaxPer)}':'null'},"rNumber":  ${rNumber != null?'${json.encode(rNumber)}':'null'},"eDate": ${eDate != null?'${json.encode(eDate)}':'null'},"eName": ${eName != null?'${json.encode(eName)}':'null'},"eTime": ${eTime != null?'${json.encode(eTime)}':'null'},"remark": ${remark != null?'${json.encode(remark)}':'null'},"sDate": ${sDate != null?'${json.encode(sDate)}':'null'},"sTime": ${sTime != null?'${json.encode(sTime)}':'null'},"section": ${section != null?'${json.encode(section)}':'null'},"tName": ${tName != null?'${json.encode(tName)}':'null'},"tNumber": ${tNumber != null?'${json.encode(tNumber)}':'null'}}';
  }
}

