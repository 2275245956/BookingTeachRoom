import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/LoginResult.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/pages/my/contact/contact_page.dart';
import 'package:intelligent_check_new/pages/my/offlinemode_page.dart';
import 'package:intelligent_check_new/pages/my/pswdchange_page.dart';
import 'package:intelligent_check_new/pages/my/subscribe_page.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/widget/completedialog.dart';
import 'package:intelligent_check_new/widget/loadingdialoge.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import './touch_callback.dart';

//通用列表项
//qi 2019-03-03
class ImItem extends StatelessWidget {
  //标题
  final String title;

  //图片路径
  final String iconPath;

  //图标
  final String righticonPath;

  //副文字
  final String subtext;

  final String theme;

  final callback;

  ImItem(
      {Key key,
      @required this.title,
      this.iconPath,
      this.righticonPath,
      this.subtext,
      this.theme,
      this.callback
//      this.bakCatchSize
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchCallBack(
      onPressed: () {
        //判断点击项
        switch (title) {
          case '修改密码':
            //路由到修改密码界面
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new PswdChangePage()),
            );
            break;
          case '通讯录':
            //路由到通讯录界面
            //Navigator.pushNamed(context, '');
//            Navigator.push(
//              context,
//              new MaterialPageRoute(builder: (context) => new ContactPage()),
//            );
            break;
          case '消息订阅':
            //路由到消息订阅界面
            //Navigator.pushNamed(context, '');
//            Navigator.push(
//              context,
//              new MaterialPageRoute(builder: (context) => new SubscribePage()),
//            );
            break;
          case '离线模式':
            //路由到离线模式界面
            //Navigator.pushNamed(context, '');
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new OfflineModePage()),
            );
            break;
          case '清除缓存':
            //路由到清除缓存界面
            //Navigator.pushNamed(context, '');
            //或者直接在当前页面进行清除缓存操作
            {
              getDatabasesPath().then((dbPath) {
                SharedPreferences.getInstance().then((sp) {
                  String str = sp.get('userInfo');
                  String myDbPath =
                      join(dbPath, '${UserModel.fromJson(str).id.toString()}', 'my.db');
                  deleteDatabase(myDbPath);
                });
              });
              showDialog<Null>(
                  context: context, //BuildContext对象
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return new LoadingDialog(
                      //调用对话框
                      text: '清除缓存...',
                    );
                  });
              new Future.delayed(Duration(seconds: 2), () {
                Navigator.pop(context); //关闭对话框
              });
              new Future.delayed(Duration(seconds: 2), () {
                showDialog<Null>(
                    context: context, //BuildContext对象
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new CompleteDialog(
                        //调用对话框
                        text: '缓存已清除...',
                      );
                    }).then((v) {
                  this.callback();
                });
                new Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context); //关闭对话框
                });
              });
            }

            break;
          case '当前版本':
            //路由到当前版本界面
            //Navigator.pushNamed(context, '');
            break;
        }
      },
      //展示部分
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 5.0),
      padding: EdgeInsets.only(top: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //图标或图片
            Expanded(
              child: Container(
                //左侧icon
                child: Image.asset(
                  iconPath,
                  width: 5.0,
                  height: 20,

                ),
                padding: const EdgeInsets.only(left: 10.0),
              ),
              flex: 1,
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                alignment: Alignment.centerLeft,
              ),
              flex: 7,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: subtext != null
                    ? Text(
                        subtext,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.red,
                            fontWeight: FontWeight.w500),
                      )
                    : Container(),
              ),
              flex: 2,
            ),
            //标题

            Expanded(
              child: Container(
                child: righticonPath != null && righticonPath != ""
                    ? Icon(
                        Icons.keyboard_arrow_right,
                        color: Color.fromRGBO(209, 6, 24, 1),
                        size: 20,
                      )
                    : Container(),
              ),
              flex: 1,
            ),
            //右侧icon
          ],
        ),
      ),
    );
  }
}
