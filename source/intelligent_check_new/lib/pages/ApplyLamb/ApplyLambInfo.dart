import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/RoomModel.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/services/TeacherServices/TechServices.dart';
import 'package:intelligent_check_new/tools/AvoidKeyBoradCoverInput.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyLambInfo extends StatefulWidget {
  final RoomModel roomInfo;
  final String StartDate;
  final String EndDate;
  final String sectionStr;

  ApplyLambInfo(this.roomInfo, this.StartDate, this.EndDate, this.sectionStr);

  @override
  _ApplyLambInfo createState() => new _ApplyLambInfo();
}

class _ApplyLambInfo extends State<ApplyLambInfo> {
  bool isAnimating = false;
  bool canOperate = true;
  String theme = "red";
  UserModel userInfo;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FocusNode _focusNodeForRemark = new FocusNode();
  FocusNode _focusNodeForLambName = new FocusNode();

  TextEditingController lamName = new TextEditingController();
  TextEditingController remark = new TextEditingController();

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

  void SaveInfo() async {
    if(lamName.text==""){
      GetConfig.popUpMsg("请填写实验名称");
      return;
    }
    var json = {
      "tNumber": userInfo.account,
      "tName": userInfo.userName,
      "rNumber": this.widget.roomInfo.rNumber,
      "rMaxPer": this.widget.roomInfo.rMaxPer,
      "eDate": this.widget.StartDate,
      "attriText01": this.widget.EndDate,
      "section": this.widget.sectionStr,
      "eName": lamName.text,
      "remark": remark.text
    };
    await SaveApplyIfo(json).then((data) {
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
//height: 50,
                          child: Text(
                            "开始时间",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${this.widget.StartDate}",
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
                            "结束时间",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${this.widget.EndDate}",
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
                          "${this.widget.sectionStr}",
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
                            child: EnsureVisibleWhenFocused(
                                child: TextField(
                                  style: TextStyle(fontSize: 18),
                                  textInputAction: TextInputAction.done,
                                  autofocus: true,
                                  controller: lamName,
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
                                ),
                                focusNode: _focusNodeForLambName)),
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
                            width: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.only(top: 5, bottom: 5, right: 10),
                            child: EnsureVisibleWhenFocused(
                                child: TextField(
                                  style: TextStyle(fontSize: 18),
                                  textInputAction: TextInputAction.done,
                                  autofocus: true,
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
                                focusNode: _focusNodeForLambName)),
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
                  onPressed: () {},
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
                    setState(() {
                      lamName.text="";
                      remark.text="";
                    });
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
