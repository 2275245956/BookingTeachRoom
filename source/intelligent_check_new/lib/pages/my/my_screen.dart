import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/widget/My_scteen_item.dart';
import 'package:intelligent_check_new/widget/touch_callback.dart';
import 'package:intelligent_check_new/pages/my/myinfo_page.dart';
import 'package:intelligent_check_new/pages/login_page.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intelligent_check_new/model/LoginResult.dart';
import 'package:intelligent_check_new/services/myinfo_services.dart';
import 'package:package_info/package_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intelligent_check_new/constants/color.dart';

//我的页面
//qi 2019.03.03

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  LoginResult loginResult;
  String version;
  bool isOffline = false;
  String theme = "";
  num catchSize = 0.0;
  var userCompany = "";
   

  @override
  void didUpdateWidget(MyScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    getData();
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() {
    SharedPreferences.getInstance().then((sp) {
      userCompany = json.decode(sp.getString("sel_com"))["companyName"];

      String str = sp.get('LoginResult');
      if (mounted) {
        setState(() {
          loginResult = LoginResult(str);
          this.theme = sp.getString("theme") ?? KColorConstant.DEFAULT_COLOR;
        });
      }

      if (sp.getBool("offline") != null) {
        if(mounted){
          setState(() {
            isOffline = sp.getBool("offline");
          });
        }

      }
    });

    PackageInfo.fromPlatform().then((packageInfo) {
      if (mounted) {
        setState(() {
          version = packageInfo.version;
        });
      }
    });

    getDatabasesPath().then((dbPath) {
      SharedPreferences.getInstance().then((sp) {
        String str = sp.get('LoginResult');
        String myDbPath = join(dbPath, '${LoginResult(str).user.id}', 'my.db');
        File(myDbPath).exists().then((exists) {
          if (exists) {
            print("DB Path exists:${myDbPath}");
            File(myDbPath).length().then((size) {
              print("${myDbPath}:${size}");
              catchSize = size;
            });
          } else {
            print("DB Path not exists:${myDbPath}");
            catchSize = 0;
          }
        });
      });
    });
  }

  clearCatch() {
    setState(() {
      catchSize = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (theme.isEmpty) {
      return Scaffold(
        body: Text(""),
      );
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.2,
          //backgroundColor: KColorConstant.floorTitleColor,
          title: Text(
            '我的',
            style: new TextStyle(
              color: Colors.black,
//              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            //头像部分
            Container(
              //margin: const EdgeInsets.only(top: 0.0),
              color: Colors.white,
              height: 80.0,
              child: TouchCallBack(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
//                    Container(
//                      margin: const EdgeInsets.only(left: 12.0, right: 15.0),
//                      child: Image.asset(
//                        "assets/images/icons/head.png",
//                        width: 70.0,
//                        height: 70.0,
//                      ),
//                      //Image.network(myinfo.avantarUrl),
//                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(209, 6, 24, 1),
                        child: Text(
                          loginResult == null ? "" : loginResult.user.name[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            //myInfo.username,
                            loginResult == null ? "" : loginResult.user.name,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0Xff353535),
                            ),
                          ),
                          Text(
                            //"中科集团/" + myInfo.userdepartment,
                            //loginResult.user.company.companyName == null?"": loginResult.user.company.companyName+ "/" + loginResult.user.department == null?"": loginResult.user.department.departmentName,
                            userCompany,
//                            loginResult == null
//                                ? ""
//                                : loginResult.user.company.companyName,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0Xffa9a9a9),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new MyInfoPage(),
                      )
                      //点击进入个人信息详细页面
                      );
                },
              ),
            ),
            //列表项，使用自定义ImItem
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  //修改密码
                  ImItem(
                    iconPath:
                        "assets/images/my/modify_password_" + theme + ".png",
                    title: '修改密码',
                    righticonPath: "assets/images/icons/righticon.png",
                    subtext: '',
                    theme: theme,
                  ),
                  //分割线
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Divider(
                      height: 0.5,
                      color: Color(0XFFd9d9d9),
                    ),
                  ),
                  //通讯录
                  ImItem(
                    iconPath: "assets/images/my/contact_" + theme + ".png",
                    title: '通讯录',
                    righticonPath: "assets/images/icons/righticon.png",
                    subtext: '',
                    theme: theme,
                  ),
                  //分割线
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Divider(
                      height: 0.5,
                      color: Color(0XFFd9d9d9),
                    ),
                  ),
                  //消息订阅
                  ImItem(
                    iconPath: "assets/images/my/message_" + theme + ".png",
                    title: '消息订阅',
                    righticonPath: "assets/images/icons/righticon.png",
                    subtext: '',
                    theme: theme,
                  ),
                  //分割线
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Divider(
                      height: 0.5,
                      color: Color(0XFFd9d9d9),
                    ),
                  ),
                  // TODO:暂时出去离线模式和清除缓存
                  //离线模式
                  ImItem(
                    iconPath: "assets/images/my/offline_" + theme + ".png",
                    title: '离线模式',
                    righticonPath: "assets/images/icons/righticon.png",
                    //动态获取
                    subtext: isOffline ? "已开启" : "未开启",
                    theme: theme,
                  ),
                  //分割线
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Divider(
                      height: 0.5,
                      color: Color(0XFFd9d9d9),
                    ),
                  ),
                  //清除缓存
//                  new Container(
//                      child: GestureDetector(
//                    onTap: clearCatch(),
//                    child:
                  ImItem(
                    iconPath: "assets/images/my/clean_" + theme + ".png",
                    title: '清除缓存',
                    righticonPath: '',
                    //动态获取
                    subtext: (catchSize / 1000000).toStringAsFixed(2) + "M",
                    theme: theme,
                    callback: clearCatch,
                  ),
//                  )),
                  //分割线
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Divider(
                      height: 0.5,
                      color: Color(0XFFd9d9d9),
                    ),
                  ),
                  //当前版本
                  ImItem(
                    iconPath: "assets/images/my/version_" + theme + ".png",
                    title: '当前版本',
                    righticonPath: '',
                    //动态获取
                    subtext: version ?? "",
                    theme: theme,
                  ),
                  //分割线
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Divider(
                      height: 0.5,
                      color: Color(0XFFd9d9d9),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
              color: Color.fromRGBO(209, 6, 24, 1),
              width: 330,
              child: new MaterialButton(
                onPressed: () {
                  //userid ,loginType从登陆处获取
                  Logout(loginResult.user.id);
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => route == null);
                },
                child: new Text(
                  "退出登录",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}