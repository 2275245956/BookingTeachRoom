import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';

import 'package:intelligent_check_new/pages/home_layout/home_background_image.dart';
import 'package:intelligent_check_new/pages/my/my_message.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final JPush jpush = new JPush();
  var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  UserModel userInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 初始化极光推送
    InitData();
  }

  void InitData() async {
   final prefs = await SharedPreferences.getInstance();
   setState(() {
     userInfo = UserModel.fromJson(json.decode(prefs.getString("userModel")));
   });
    await initPlatformState();
    await setAlias();
  }

  Future<void> setAlias() async {
    await jpush.setAlias(userInfo.account);
  }

  // 推送相关-极光
  Future<void> initPlatformState() async {
    String platformVersion;

    jpush.setup(
      appKey: "3500f6a1262613c11690ea94",
      channel: "developer-default",
      production: false,
      debug: true,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));
      jpush.getRegistrationID().then((rid) {
      print("推送测试getRegistrationID>>>>>" + rid);
    });

    try {

      List<String> tags = List();

      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          print("extras info:" + message["extras"]["cn.jpush.android.EXTRA"]);
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => MyMessagePage()));
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
        },
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeBackgroundImage();
  }
}
