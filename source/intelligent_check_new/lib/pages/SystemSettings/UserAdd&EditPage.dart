import 'dart:convert' show json;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/services/SystemService/SystemConfigService.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditControllers {
  //姓名
  TextEditingController uName = new TextEditingController();

  //性别
  TextEditingController sex = new TextEditingController();

  //专业
  TextEditingController major = new TextEditingController();

  //院系
  TextEditingController deptName = new TextEditingController();

  //班级
  TextEditingController uClass = new TextEditingController();

  //角色
  TextEditingController role = new TextEditingController();

  //角色
  TextEditingController account = new TextEditingController();
}

class UserEditAddPage extends StatefulWidget {
  final String opType;
  final UserModel userModel;
  final String userRole;

  UserEditAddPage(this.opType, this.userModel, this.userRole);

  @override
  _UserEditAddPage createState() => new _UserEditAddPage();
}

class _UserEditAddPage extends State<UserEditAddPage> {
  bool isAnimating = false;
  bool canOperate = true;
  String theme = "red";
  UserModel userInfo;
  UserModel newUserInfo = new UserModel.fromParams();
  EditControllers editCons = new EditControllers();
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
        if (this.widget.opType == "edit") {
          this.newUserInfo = this.widget.userModel;
        }
        editCons.uName.text = this.newUserInfo.userName;
        editCons.sex.text = this.newUserInfo.sex;
        editCons.role.text = this.newUserInfo.role;
        editCons.major.text = this.newUserInfo.major;
        editCons.deptName.text = this.newUserInfo.deptName;
        editCons.uClass.text = this.newUserInfo.uClass;
        editCons.account.text = this.newUserInfo.account;
      });
    });
  }

  void SaveInfo() async {
    if(this.widget.opType=="add"){
      var jsonData=
        {
          "account":editCons.account.text,
          "deptName": editCons.deptName.text,
          "employeeNumber":editCons.account.text,
          "major":editCons.major.text,
          "role": this.widget.userRole,
          "sex": editCons.sex.text,
          "uClass": editCons.uClass.text,
          "userName":editCons.uName.text
        };
      var data=await ADDUSER(jsonData);
      if(data.success){
        GetConfig.popUpMsg(data.message??"操作成功");
        Navigator.pop(context);
      }else{
        GetConfig.popUpMsg(data.message??"操作失败");
      }
    }else if(this.widget.opType=="edit"){
      var jsonData=
      {
        "account":editCons.account.text,
        "deptName": editCons.deptName.text,
        "employeeNumber":editCons.account.text,
        "major":editCons.major.text,
        "role": this.widget.userRole,
        "sex": editCons.sex.text,
        "uClass": editCons.uClass.text,
        "userName":editCons.uName.text,
        "id":newUserInfo.id
      };
      var data=await  EditUSER(jsonData);
      if(data.success){
        GetConfig.popUpMsg(data.message??"操作成功");
        Navigator.pop(context);
      }else{
        GetConfig.popUpMsg(data.message??"操作失败");
      }
    }else{
      return ;
    }

  }

  @override
  Widget build(BuildContext context) {
    //新增
    if (userInfo != null && this.widget.opType != "") {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "${GetConfig.getRoleDesc(this.widget.userRole)}添加",
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
                            "姓名",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            textInputAction: TextInputAction.done, 
                            controller: editCons.uName,
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
                              hintText: "请输入姓名",
                              filled: true,
                              fillColor: Color.fromRGBO(244, 244, 244, 1),
                            ),
                          ))
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "账号",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            textInputAction: TextInputAction.done,
                            controller: editCons.account,
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
                              hintText: "请输入账号",
                              filled: true,
                              fillColor: Color.fromRGBO(244, 244, 244, 1),
                            ),
                          ))
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "院/系",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            textInputAction: TextInputAction.done,
                            
                            controller: editCons.deptName,
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
                              hintText: "请输入院/系",
                              filled: true,
                              fillColor: Color.fromRGBO(244, 244, 244, 1),
                            ),
                          ))
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "专业",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            textInputAction: TextInputAction.done,
                            controller: editCons.major,
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
                              hintText: "请输入专业",
                              filled: true,
                              fillColor: Color.fromRGBO(244, 244, 244, 1),
                            ),
                          ))
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "班级",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            textInputAction: TextInputAction.done,
                            controller: editCons.uClass,
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
                              hintText: "请输入班级",
                              filled: true,
                              fillColor: Color.fromRGBO(244, 244, 244, 1),
                            ),
                          ))
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "性别",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: new Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: RadioListTile(
                                    title: Text("男"),
                                    value: "男",
                                    groupValue:editCons.sex.text,
                                    onChanged: (value) {
                                      setState(() {
                                        editCons.sex.text=value;
                                      });
                                    }),
                                //带文字的单选按钮 value值=groupValue值 即选中状态
                              ),
                              Expanded(
                                flex: 5,
                                child: RadioListTile(
                                    title: Text("女"),
                                    value: "女",
                                    groupValue:editCons.sex.text,
                                    onChanged: (value) {
                                      setState(() {
                                        editCons.sex.text=value;
                                      });
                                    }),
                                //带文字的单选按钮 value值=groupValue值 即选中状态
                              ),
                            ],
                          ),)
                    ],
                  ),
                  Divider(),
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
     //空白页面
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "用户添加",
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
      );
    }
  }
}
