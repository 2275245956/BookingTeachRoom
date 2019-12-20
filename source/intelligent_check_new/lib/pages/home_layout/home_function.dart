import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:intelligent_check_new/model/StudentModel/StudentModel.dart';
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
  StudentsInfo studentInfo;
  int userType = -1;

  @override
  Widget build(BuildContext context) {
    if (studentInfo==null) {
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
                                  "${studentInfo.sRole}:${studentInfo.sName}",
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
                                height:  36,
                                //  margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            65.0)),
                                    image: DecorationImage(
                                        image: ExactAssetImage('assets/images/login/logo_red.png'),
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
                                    "Xi'an Aviation Institute of Technology",
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
                    children: <Widget>[
                      Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                            ),
                            new Text(
                              "模块一",
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1)),
                            )
                          ],
                        ),
                        width: double.infinity,
                        height: 40.0,
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(250, 251, 252, 1),
                          //Colors.grey[100],
                          borderRadius: new BorderRadius.vertical(
                              top: Radius.circular(5.0)),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: GridView.count(
                          crossAxisCount: 4,
                          children: getFirstMenus(),
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
                              "模块二",
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1)),
                            )
                          ],
                        ),
                        width: double.infinity,
                        height: 40.0,
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(250, 251, 252, 1),
                          //Colors.grey[100],
                          borderRadius: new BorderRadius.vertical(
                              top: Radius.circular(5.0)),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: GridView.count(
                          crossAxisCount: 4,
                          children: getFirstMenus(),
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
                )
              ],
            );
          }),
      inAsyncCall: isAnimating,
      opacity: 0.7,
      progressIndicator: CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    super.initState();

    if (!mounted) {
      return;
    }
    initData();
  }

  void initData() async {
    await SharedPreferences.getInstance().then((sp) {
      setState(() {
        //用户类型
        userType = sp.getInt("userRole");
        if(sp.getString("userInfo")!=null){
          studentInfo=StudentsInfo.fromJson(json.decode(sp.getString("userInfo")));
        }
      });
    });
  }

  getFirstMenus() {
    List<Container> firstMenu = List();
    Container container1 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(5)),
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: GestureDetector(
          child: EachTab(
            width: 80,
            badge: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 3,
            ),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.functions, size: 32, color: Colors.red),
            text: "功能1",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {},
        ));
    Container container2 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(5)),
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: GestureDetector(
          child: EachTab(
            width: 80,
            badge: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 3,
            ),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.functions, size: 32, color: Colors.red),
            text: "功能2",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {},
        ));
    Container container3 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(5)),
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: GestureDetector(
          child: EachTab(
            width: 80,
            badge: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 3,
            ),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.functions, size: 32, color: Colors.red),
            text: "功能3",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {},
        ));
    Container container4 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(5)),
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: GestureDetector(
          child: EachTab(
            width: 80,
            badge: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 3,
            ),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.functions, size: 32, color: Colors.red),
            text: "功能4",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {},
        ));
    firstMenu.add(container1);
    firstMenu.add(container2);
    firstMenu.add(container3);
    firstMenu.add(container4);

    return firstMenu;
  }

}
