import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/ExperimentModel.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/pages/navigation_keep_alive.dart';
import 'package:intelligent_check_new/services/StudentServices/StudentOperate.dart';
import 'package:intelligent_check_new/services/TeacherServices/TechServices.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentApplyLambDetail extends StatefulWidget {
  final ExpModel recordInfo;

  StudentApplyLambDetail(this.recordInfo);

  @override
  _ApplyLambDetail createState() => new _ApplyLambDetail(recordInfo);
}

class _ApplyLambDetail extends State<StudentApplyLambDetail> {
  ExpModel expModel;

  _ApplyLambDetail(this.expModel);

  bool isAnimating = false;
  bool canOperate = true;
  String theme = "red";
  bool hasApplyed = false;
  UserModel userInfo;
  var reqNumber="0";
  var status="";

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    var sp = await SharedPreferences.getInstance();
    setState(() {
      if (sp.getString("userModel") != null) {
        userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
      }
    });
    var data = await StuApplyRecord(userInfo.account);
    if (data.success && data.dataList != null) {
      for (var str in data.dataList) {
        if (expModel.reqNumber == str["attriText01"]) {
          if (str["status"] == "申请提交(学生)") {
            setState(() {
              reqNumber=str["reqNumber"];
              status=str["status"];
              hasApplyed = true;
            });
            break;
          }
        }
      }
    }

    await GetExpModdel(this.widget.recordInfo.reqNumber).then((data) {
      var list = new List();
      if (data.success && data.dataList != null && data.dataList.length > 0) {
        setState(() {
          for (var str in data.dataList) {
            list.add(ExpModel.fromJson((str)));
          }
          if (list.length > 0) {
            expModel = list[0];
            expModel.eDate = list[list.length - 1].eDate;
          }
        });
      }
    });
  }

  void CheckResult() async {
    var jsonStr = {
      "eEndtime": DateTime.parse(expModel.eDate).toString(),
      "eName": expModel.eName,
      "eStarttime": DateTime.parse(expModel.sDate).toString(),
      "eTName": expModel.tName,
      "remark": expModel.remark,
      "sMajor": userInfo.major,
      "sName": userInfo.userName,
      "sNumber": userInfo.account,
      "attriText01": expModel.reqNumber
    };

    var res = await StuSaveApplyInfo(jsonStr);
    if (res.success) {
      GetConfig.popUpMsg(res.message ?? "申请成功");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigationKeepAlive()),
              (route) => route == null);
    } else {
      GetConfig.popUpMsg(res.message ?? "申请失败");
    }
  }

  void CancelApply() async {
    var data = await StuCalcelApply(reqNumber);
    if (data.success) {
      GetConfig.popUpMsg(data.message ?? "操作成功！");
      Navigator.pop(context);
    } else {
      GetConfig.popUpMsg(data.message ?? "操作失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo != null && this.widget.recordInfo != null) {
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
                          "${expModel.tName}(${expModel.tNumber})",
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
                            "教室编号",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${expModel.rNumber}",
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
                            "最大人数",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${expModel.rMaxPer}",
                          style: TextStyle(
                              color: GetConfig.getColor(theme), fontSize: 18),
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
                            "已选人数",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${expModel.rNowPer}",
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
                          "${DateFormat("yyyy年MM月dd日（EEEE）", "zh").format(
                              DateTime.parse(expModel.sDate))}",
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
                          "${DateFormat("yyyy年MM月dd日（EEEE）", "zh").format(
                              DateTime.parse(expModel.eDate))}",
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
                          "${expModel.section}",
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
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding:
                          EdgeInsets.only(top: 5, bottom: 5, right: 10),
                          child: Text(
                            "${expModel.eName}",
                            style: TextStyle(
                                color: GetConfig.getColor(theme), fontSize: 18),
                          ),
                        ),
                      )
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
                          constraints: BoxConstraints(
                            minHeight: 100.0,
                          ),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding:
                          EdgeInsets.only(top: 5, bottom: 5, right: 10),
                          child: TextField(
                            autofocus: false,
                            style: TextStyle(fontSize: 18),
                            controller:
                            TextEditingController(text: expModel.remark),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            enabled: false,
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
                              hintText: "",
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
        persistentFooterButtons:
        expModel.status == "申请通过(教师)" || expModel.status == "申请通过(管理员)"
            ? <Widget>[
          Row(
            children: <Widget>[
              hasApplyed
                  ? Container(
                width: (MediaQuery
                    .of(context)
                    .size
                    .width - 16),
                child: new MaterialButton(
                  color: GetConfig.getColor(theme),
                  height: 60,
                  textColor: Colors.white,
                  child: new Text('取消申请',
                      style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    if (status == "申请通过(教师)" ||
                    status == "申请通过(管理员)") {
                      GetConfig.IOSPopMsg(
                          "提示", Text("该实验已经通过审核，请联系管理员或者教师！"), context);
                      return false;
                    }else{
                      GetConfig.IOSPopMsg(
                          "取消提示", Text("确认取消该实验？"), context,confirmFun: CancelApply);
                    }
                  },
                ),
              )
                  : Container(
                width: (MediaQuery
                    .of(context)
                    .size
                    .width - 16),
                child: new MaterialButton(
                  color: hasApplyed
                      ? Colors.grey
                      : GetConfig.getColor(theme),
                  height: 60,
                  textColor: Colors.white,
                  child: new Text('申请实验',
                      style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    if (hasApplyed) {
                      GetConfig.IOSPopMsg(
                          "提示！",
                          Text("您已存在已申请或者已通过审核的记录，不能重复申请！"),
                          context);
                    } else {
                      GetConfig.IOSPopMsg(
                          "提示！", Text("是否确认该操作？"), context,
                          confirmFun: CheckResult);
                    }
                  },
                ),
              ),
            ],
          )
        ]
            : null,
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
