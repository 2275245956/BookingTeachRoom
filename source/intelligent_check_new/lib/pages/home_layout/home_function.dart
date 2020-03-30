import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_student/StudentApplyRecord.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/ApplyRecord.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/CheckApplyStudentPage.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/CheckedApplyStudentPage.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/SelectLambPage.dart';
import 'package:intelligent_check_new/pages/ExpPage/ExpCheckStudentApply.dart';
import 'package:intelligent_check_new/pages/ExpPage/TeachApplyCheck.dart';
import 'package:intelligent_check_new/pages/SystemSettings/ScheduleSettingPage.dart';
import 'package:intelligent_check_new/pages/message/message_list.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFunction extends StatefulWidget {
  HomeFunction();

  @override
  State<StatefulWidget> createState() => new _HomeFunctionState();
}

class _HomeFunctionState extends State<HomeFunction> {
  int _unReadCount = 10;
  bool isAnimating = false;

  String theme = "red"; //主题
  UserModel userInfo;

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return Scaffold(body: Text(""));
    }
    return ModalProgressHUD(
      color: Color.fromRGBO(242, 246, 249, 1),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.only(left: ScreenUtil.screenWidthDp/4-2),
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "${GetConfig.getRoleDesc(userInfo.role)}:${userInfo.userName}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.center,
                          //padding: EdgeInsets.only(left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(65.0)),
                                    image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/login/logo_red.png'),
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 2),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "西安航空职业技术学院",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  Text(
                                    "Xi'an Aeronatutical Polytechnic Institute",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        flex: 6,
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Icon(
                                    Icons.message,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  _unReadCount > 0
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              bottom: 10, left: 15),
                                          child: CircleAvatar(
                                            radius: 3,
                                            backgroundColor: Colors.blue,
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                              ),
                              Text(
                                '消息',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                          onTap: () {
                            // MessageListPage
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new MessageListPage();
                            })).then((v) {});
                          },
                        ),
                        flex: 2,
                      ),
                    ],
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Container(
                  child: Column(
                    children: GetFunctions(),
                  ),
                ),
              ],
            );
          }),
      inAsyncCall: isAnimating,
      opacity: 0.7,
      progressIndicator: CircularProgressIndicator(),
    );
  }

  List<Widget> GetFunctions() {
    List<Widget> menus = new List();
    switch (userInfo.role) {
      case "student":
        menus.add(
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      new Text(
                        "学生菜单",
                        style:
                            TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(250, 251, 252, 1),
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.circular(5.0)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: <Widget>[
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.laptop_windows,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "开放性实验",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentApplyRecord()));
                            },
                          )),
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.assignment_ind,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "我的实验",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentApplyRecord())),
                          ))
                    ],
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            decoration: new BoxDecoration(
                //                      color: Color.fromRGBO(242, 246, 249, 1),
                borderRadius: new BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    blurRadius: 5.0,
                  ),
                ]),
          ),
        );
        break;
      case "teacher":
        menus.add(
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      new Text(
                        "实验申请",
                        style:
                            TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(250, 251, 252, 1),
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.circular(5.0)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: <Widget>[
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.apps,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "实验申请",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () => Navigator.push(context,
                                    new MaterialPageRoute(builder: (context) {
                                  return SelLambScreen();
                                })),
                          )),
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.attachment,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "申请记录",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        ApplyRecordListScreen())),
                          )),
                    ],
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            decoration: new BoxDecoration(
                //                      color: Color.fromRGBO(242, 246, 249, 1),
                borderRadius: new BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    blurRadius: 5.0,
                  ),
                ]),
          ),
        );
        menus.add(
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      new Text(
                        "实验审核",
                        style:
                            TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(250, 251, 252, 1),
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.circular(5.0)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: <Widget>[
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.check_circle_outline,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "学生待审核",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CheckApplyStudent();
                              }));
                            },
                          )),
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.check_circle,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "学生已审核",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckedApplyStudent())),
                          )),
                    ],
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            decoration: new BoxDecoration(
                //                      color: Color.fromRGBO(242, 246, 249, 1),
                borderRadius: new BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    blurRadius: 5.0,
                  ),
                ]),
          ),
        );
        break;
      case "admin":
        menus.add(
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      new Text(
                        "人员管理",
                        style:
                            TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(250, 251, 252, 1),
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.circular(5.0)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: <Widget>[
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.account_circle,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "教师管理",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () {},
                          )),
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.accessibility_new,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "学生管理",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () {},
                          )),
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.folder_shared,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "管理员管理",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () {},
                          ))
                    ],
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            decoration: new BoxDecoration(
                //                      color: Color.fromRGBO(242, 246, 249, 1),
                borderRadius: new BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    blurRadius: 5.0,
                  ),
                ]),
          ),
        );
        menus.add(
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      new Text(
                        "资源管理",
                        style:
                            TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(250, 251, 252, 1),
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.circular(5.0)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: <Widget>[
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.class_,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "实验室分配",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () {},
                          )),
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.assignment,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "实验室管理",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () {},
                          )),
                    ],
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            decoration: new BoxDecoration(
                //                      color: Color.fromRGBO(242, 246, 249, 1),
                borderRadius: new BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    blurRadius: 5.0,
                  ),
                ]),
          ),
        );
        menus.add(
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      new Text(
                        "系统配置",
                        style:
                            TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(250, 251, 252, 1),
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.circular(5.0)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: <Widget>[
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.timer,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "作息时间配置",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () => Navigator.push(context,
                                    new MaterialPageRoute(builder: (context) {
                                  return ScheduleSettingPage();
                                })),
                          )),
                    ],
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            decoration: new BoxDecoration(
                //                      color: Color.fromRGBO(242, 246, 249, 1),
                borderRadius: new BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    blurRadius: 5.0,
                  ),
                ]),
          ),
        );
        break;
      case "expAdmin":
        menus.add(
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      new Text(
                        "实验管理",
                        style:
                            TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(250, 251, 252, 1),
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.circular(5.0)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: <Widget>[
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                Icons.playlist_add_check,
                                color: GetConfig.getColor(theme),
                                size: 32,
                              ),
                              text: "教师审核",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        new TeachApplyCheck())),
                          )),
                      Container(
                          height: 82,
                          width: 82,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(5)),
                            color: Colors.white,
                            border: new Border.all(
                                width: 0.5, color: Colors.grey[100]),
                          ),
                          child: GestureDetector(
                            child: EachTab(
                              width: 80,
                              badge: CircleAvatar(
                                backgroundColor: GetConfig.getColor("blue"),
                                radius: 3,
                              ),
                              badgeColor: GetConfig.getColor("blue"),
                              height: 40,
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.spellcheck,
                                  size: 32, color: GetConfig.getColor(theme)),
                              text: "学生审核",
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              color: Colors.white,
                            ),
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(context)=>ExpCheckStudentApply())),
                          )),
                    ],
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            decoration: new BoxDecoration(
                //                      color: Color.fromRGBO(242, 246, 249, 1),
                borderRadius: new BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    blurRadius: 5.0,
                  ),
                ]),
          ),
        );
        break;

      default:
        break;
    }
    return menus;
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    await SharedPreferences.getInstance().then((sp) {
      setState(() {
        //用户类型
        if (sp.getString("userModel") != null) {
          userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
        }
      });
    });
  }
}
