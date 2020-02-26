import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/widget/My_scteen_item.dart';
import 'package:intelligent_check_new/widget/touch_callback.dart';
import 'package:intelligent_check_new/pages/my/myinfo_page.dart';
import 'package:intelligent_check_new/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';


class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  UserModel userInfo;


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
      //用户类型
      setState(() {
        //用户类型
        if(sp.getString("userModel")!=null){
          userInfo=UserModel.fromJson(json.decode(sp.getString("userModel")));
        }
      });
    });

    PackageInfo.fromPlatform().then((packageInfo) {
      if (mounted) {
        setState(() {
          version = packageInfo.version;
        });
      }
    });

//    getDatabasesPath().then((dbPath) {
//      SharedPreferences.getInstance().then((sp) {
//        String str = sp.get('LoginResult');
//        String myDbPath = join(dbPath, '${LoginResult(str).user.id}', 'my.db');
//        File(myDbPath).exists().then((exists) {
//          if (exists) {
//            print("DB Path exists:${myDbPath}");
//            File(myDbPath).length().then((size) {
//              print("${myDbPath}:${size}");
//              catchSize = size;
//            });
//          } else {
//            print("DB Path not exists:${myDbPath}");
//            catchSize = 0;
//          }
//        });
//      });
//    });
  }

  clearCatch() {
    setState(() {
      catchSize = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo==null) {
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

                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(209, 6, 24, 1),
                        child: Text(
                          userInfo  == null ? "" : userInfo.userName[0],
                          style: TextStyle(color: Colors.white,fontSize: 25),
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
                            userInfo  == null ? "" : userInfo.userName,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0Xff353535),
                            ),
                          ),
                          Text(
                            userInfo  == null ? "" : userInfo.major,

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
                        "assets/images/my/modify_password_red.png",
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
                    iconPath: "assets/images/my/contact_red.png",
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
                    iconPath: "assets/images/my/message_red.png",
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
                  //清除缓存

                  ImItem(
                    iconPath: "assets/images/my/clean_red.png",
                    title: '清除缓存',
                    righticonPath: '',
                    //动态获取
                    subtext: (catchSize / 1000000).toStringAsFixed(2) + "M",
                    theme: theme,
                    callback: clearCatch,
                  ),

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
                    iconPath: "assets/images/my/version_red.png",
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
