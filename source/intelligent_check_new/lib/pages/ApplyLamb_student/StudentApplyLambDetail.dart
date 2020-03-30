import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/TeacherApplyRecord.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/services/StudentServices/StudentOperate.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentApplyLambDetail extends StatefulWidget {
  final TeacherApplyRecord recordInfo;

  StudentApplyLambDetail(this.recordInfo);

  @override
  _ApplyLambDetail createState() => new _ApplyLambDetail();
}

class _ApplyLambDetail extends State<StudentApplyLambDetail> {
  bool isAnimating = false;
  bool canOperate = true;
  String theme = "red";
  UserModel userInfo;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
  }

  void CheckResult() async {
    var jsonStr = {
      "eEndtime": this.widget.recordInfo.attriText01,
      "eName":  this.widget.recordInfo.eName,

      "eStarttime":  this.widget.recordInfo.eDate,
      "eTName":this.widget.recordInfo.tName,
      "remark":this.widget.recordInfo.remark,

      "sMajor": userInfo.major,
      "sName": userInfo.userName,
      "sNumber": userInfo.account
    };
   var res = await StuSaveApplyInfo(jsonStr);
   if(res.success){
     GetConfig.popUpMsg(res.message??"申请成功");
     Navigator.pop(context);
   }else{
     GetConfig.popUpMsg(res.message??"申请失败");
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
                          "${this.widget.recordInfo.tName}(${this.widget.recordInfo.tNumber})",
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
                            "申请单号",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${this.widget.recordInfo.reqNumber}",
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
                          "${this.widget.recordInfo.rNumber}",
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
                          "${this.widget.recordInfo.rMaxPer}",
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
                          "${this.widget.recordInfo.eDate}",
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
                          "${this.widget.recordInfo.attriText01}",
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
                          "${this.widget.recordInfo.section}",
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
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.only(top: 5, bottom: 5, right: 10),
                          child: Text(
                            "${this.widget.recordInfo.eName}",
                            style: TextStyle(color: Colors.black, fontSize: 18),
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
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.only(top: 5, bottom: 5, right: 10),
                          child: TextField(
                            autofocus: false,
                            style: TextStyle(fontSize: 18),
                            controller: TextEditingController(
                                text: this.widget.recordInfo.remark),
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
        persistentFooterButtons: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width - 16),
                child: new MaterialButton(
                  color: GetConfig.getColor(theme),
                  height: 60,
                  textColor: Colors.white,
                  child: new Text('申请实验', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    setState(() {
                      GetConfig.IOSPopMsg("提示！", Text("是否确认该操作？"), context,
                          confirmFun: CheckResult);
                    });
                  },
                ),
              ),
            ],
          )
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
