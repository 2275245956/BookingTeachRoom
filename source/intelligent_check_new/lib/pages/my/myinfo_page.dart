import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/widget/touch_callback.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {

  UserModel userInfo;
  String theme = "red";

  @override
  void initState() {

    super.initState();
    getData();
  }

  getData() {
    SharedPreferences.getInstance().then((sp) {
      setState(() {
       userInfo=UserModel.fromJson(json.decode(sp.getString("userModel")));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return Scaffold(
          backgroundColor: Color.fromRGBO(242, 246, 249, 1),
          appBar: new AppBar(
            backgroundColor: Colors.white,
            elevation: 0.2,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromRGBO(209, 6, 24, 1),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              '我的信息',
              style: new TextStyle(
                color: Colors.black,
//              fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[],
          ),
          body: Text(""));
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0.2,
          leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Color.fromRGBO(209, 6, 24, 1),
                size: 28,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            '我的信息',
            style: new TextStyle(
              color: Colors.black,
//              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
          ],
        ),
        body: ListView(
          children: <Widget>[
            //头像部分
            TouchCallBack(
              onPressed: () {},
              child: Container(
                //margin: const EdgeInsets.only(top: 0.0),
                color: Colors.white,
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    //图标或图片
                    Expanded(
                      child: Container(

                        height: 32.0,
                        child: Text(
                          '头像',
                          style: TextStyle(
                              fontSize: 16.0,
//                            fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        padding: const EdgeInsets.only(left: 10.0),
                      ),
                      flex: 1,
                    ),

                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(209, 6, 24, 1),
                          child: Text(
                            userInfo == null ? "" : userInfo.userName[0],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                      ),
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                height: 0.5,
                color: Color(0XFFd9d9d9),
              ),
            ),
            Container(
              color: Colors.white,
              height: 50.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: new Text(
                        '姓名',
                        style: TextStyle(
                            fontSize: 15.0,
//                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      padding: const EdgeInsets.only(left: 10.0),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    // child: new Text(myInfo.username),
                    child:
                        new Text("${userInfo.userName}"),
                    flex: 3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                height: 0.5,
                color: Color(0XFFd9d9d9),
              ),
            ),

            Container(
              color: Colors.white,
              height: 50.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: new Text(
                        '学院',
                        style: TextStyle(
                            fontSize: 15.0,
//                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      padding: const EdgeInsets.only(left: 10.0),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    //child: new Text(myInfo.userdepartment),
                    child: new Text("${userInfo.deptName}"),
                    flex: 3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                height: 0.5,
                color: Color(0XFFd9d9d9),
              ),
            ),
            Container(
              color: Colors.white,
              height: 50.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: new Text(
                        '专业',
                        style: TextStyle(
                            fontSize: 15.0,
//                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      padding: const EdgeInsets.only(left: 10.0),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    //child: new Text(myInfo.userdepartment),
                    child: new Text(userInfo.major ?? "--"),
                    flex: 3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                height: 0.5,
                color: Color(0XFFd9d9d9),
              ),
            ),
            Container(
              color: Colors.white,
              height: 50.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: new Text(
                        '账号',
                        style: TextStyle(
                            fontSize: 15.0,
//                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      padding: const EdgeInsets.only(left: 10.0),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    //child: new Text(myInfo.userid.toString()),
                    child: new Text(
                       "${userInfo.account}"),
                    flex: 3,
                  ),
                ],
              ),
            ),
                  Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                height: 0.5,
                color: Color(0XFFd9d9d9),
              ),
            ),
            Container(
              color: Colors.white,
              height: 50.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: new Text(
                        '邮箱',
                        style: TextStyle(
                            fontSize: 15.0,
//                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      padding: const EdgeInsets.only(left: 10.0),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: new Text(
                        userInfo.email ??"--"),
                    flex:3,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
