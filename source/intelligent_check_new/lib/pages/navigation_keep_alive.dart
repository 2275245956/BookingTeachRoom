import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:intelligent_check_new/model/CompanyInfo.dart';
import 'package:intelligent_check_new/pages/AndroidBackTop.dart';
import 'package:intelligent_check_new/pages/home_screen.dart';
import 'package:intelligent_check_new/pages/my/my_screen.dart';
import 'package:intelligent_check_new/pages/statistics_screen.dart';

//import 'package:intelligent_check_new/pages/statistics_screen.dart';
//import 'package:intelligent_check_new/services/company_services.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intelligent_check_new/constants/color.dart';

class NavigationKeepAlive extends StatefulWidget {
  @override
  _NavigationKeepAliveState createState() => _NavigationKeepAliveState();
}

class _NavigationKeepAliveState extends State<NavigationKeepAlive>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 0;
  var titles = ['工作台', '统计', '我的'];

//  CompanyInfo cqSelect;
  List<CompanyInfo> cqDatas = List();

//  int taskCount = -1;
//  int unReadCount = -1;
  bool isAnimating = false;
  String theme = "blue";
  bool isOffline = false;

  initData() async {
    setState(() {
      isAnimating = true;
    });

    // 判断当前是否是离线状态
    await SharedPreferences.getInstance().then((preferences) {
      setState(() {
        this.isOffline = preferences.getBool("offline");
        this.theme =
            preferences.getString("theme") ?? KColorConstant.DEFAULT_COLOR;
      });
      return isOffline;
    }).then((result) {
      // 是离线模式，从缓存中获取公司信息
      if (this.isOffline) {
        initOfflineData();
      } else {
        initOnlineData();
      }
    });
    setState(() {
      isAnimating = false;
    });
  }

  /**
   * 离线模式获取数据
   */
  initOfflineData() {
    SharedPreferences.getInstance().then((preferences) {
//      String companyData = preferences.get("companyList");
//      if(null != companyData){
//        setState(() {
//          List dataList = json.decode(companyData);
//          for(var _dataList in dataList) {
//            cqDatas.add(CompanyInfo.fromJson(_dataList));
//          }
////          taskCount = 0;
////          unReadCount = 0;
//        });
//      }

      var companyData = preferences.get("companyList");
      if (null != companyData) {
        //测试数据
//       var _dataList={
//        "level":0,
//        "checked" :false,
//        "code" :"111111" ,
//        "key"  :"1111",
//        "label" :"111",
//        "type"  :"111",
//        "value" :"111",
//        };
        try {
          var cominfo = json.decode(companyData)[0];
          var _dataList = {
            "level": null,
            "checked": false,
            "code": cominfo["orgCode"],
            "key": cominfo["sequenceNbr"],
            "label": cominfo["companyName"],
            "type": cominfo["level"],
            "value": cominfo["companyName"],
          };
          cqDatas.add(CompanyInfo.fromJson(_dataList));
        } catch (e) {
          throw e;
        }
      }
    });
  }

  /**
   * 在线模式获取数据
   */
  initOnlineData() async {
    // 获取公司列表
//    await /*getCompanyList()*/getInitData().then((data){
//      if(data!= null){
//        if(data.companies != null && data.companies.length > 0){
//          setState(() {
//            cqDatas = data.companies;
//            // 放入本地缓存
//            SharedPreferences.getInstance().then((preferences){
//              preferences.setString("companyList", data.toString());
//            });
//          });
//        }
//        if(data.permissions != null && data.permissions.isNotEmpty){
//          SharedPreferences.getInstance().then((preferences) {
//            preferences.setString("permissionList", data.permissions);
//          });
//        }
//      }
////      selectCompany(data.companies.length>0?data.companies[0].key:"");
//    });

//        .then((data){
//      getQueryPlanTaskCount().then((count){
//        setState(() {
//          taskCount = count;
//        });
//      });
//    }).then((data){
//      getUnreadCount().then((count){
//        setState(() {
//          unReadCount = count;
//        });
//      });
//          .then((data){
//        getAuthForInitCardAndOffline().then((data){
//          SharedPreferences.getInstance().then((preferences) {
//            preferences.setString("permissionList", data);
//          });
//        });
//      });
//    });

    SharedPreferences.getInstance().then((preferences) {
      var companyData = preferences.get("companyList");
      if (null != companyData) {
        //测试数据
//       var _dataList={
//        "level":0,
//        "checked" :false,
//        "code" :"111111" ,
//        "key"  :"1111",
//        "label" :"111",
//        "type"  :"111",
//        "value" :"111",
//        };
        try {
          var cominfo = json.decode(companyData)[0];
          var _dataList = {
            "level": null,
            "checked": false,
            "code": cominfo["orgCode"],
            "key": cominfo["sequenceNbr"],
            "label": cominfo["companyName"],
            "type": cominfo["level"],
            "value": cominfo["companyName"],
          };
          cqDatas.add(CompanyInfo.fromJson(_dataList));
        } catch (e) {
          throw e;
        }

//        List dataList = json.decode(companyData);
//        for(var _dataList in dataList) {
//
//          cqDatas.add(CompanyInfo.fromJson(_dataList));
//        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, initialIndex: 0, length: titles.length);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
    });
    // 初始化首页数据
    initData();
  }

  @override
  Widget build(BuildContext context) {
    if (this.theme == null || this.theme.isEmpty) {
      return WillPopScope(
        child: Scaffold(body: Text("")),
        onWillPop: () async {
          AndroidBackTop.backDeskTop(); //设置为返回不退出app
          return false;
        },
      );
    }

    if (cqDatas == null /* || taskCount == -1 || unReadCount==-1*/) {
      return WillPopScope(
        child: Scaffold(
          body: ModalProgressHUD(
            child: Text(""),
            inAsyncCall: isAnimating,
            opacity: 0.7,
            progressIndicator: CircularProgressIndicator(),
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            height: 70.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                new TabBar(
                  isScrollable: false,
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.all(0),
                  unselectedLabelColor: Colors.white,
                  tabs: <Widget>[
                    EachTab(
                      width: 80,
                      height: 60,
                      padding: EdgeInsets.all(0),
                      icon: _selectedIndex == 0
                          ? Image.asset(
                              'assets/images/home/home_tab_workspace_' +
                                  theme +
                                  '.png',
//                      width: 70,
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/home/un_home_tab_workspace.png',
//                      width: 70,
                              height: 30,
                            ),
                      text: titles[0],
                      iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == 0
                              ? GetConfig.getColor(theme)
                              : Colors.grey),
//                  color: _selectedIndex == 0?Colors.red:Colors.grey,
                    ),
                    EachTab(
                      width: 80,
                      height: 60,
                      padding: EdgeInsets.all(0),
                      icon: _selectedIndex == 1
                          ? Image.asset(
                              'assets/images/home/home_statistic_' +
                                  theme +
                                  '.png',
//                      width: 70,
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/home/un_home_statistic.png',
//                      width: 70,
                              height: 30,
                            ),
                      text: titles[1],
                      iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == 1
                              ? GetConfig.getColor(theme)
                              : Colors.grey),
                      //color: _selectedIndex == 1?Colors.white:Colors.grey,
                    ),
                    EachTab(
                      width: 80,
                      height: 60,
                      padding: EdgeInsets.all(0),
                      icon: _selectedIndex == 2
                          ? Image.asset(
                              'assets/images/home/home_my_' + theme + '.png',
//                      width: 70,
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/home/un_home_my.png',
//                      width: 70,
                              height: 30,
                            ),
                      text: titles[2],
                      iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == 2
                              ? GetConfig.getColor(theme)
                              : Colors.grey),
                      //color: _selectedIndex == 2?Colors.white:Colors.grey,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          AndroidBackTop.backDeskTop(); //设置为返回不退出app
          return false;
        },
      );
    }
    return WillPopScope(
      child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.white,
            height: 70.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                new TabBar(
                  isScrollable: false,
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.all(0),
                  unselectedLabelColor: Colors.white,
                  tabs: <Widget>[
                    EachTab(
                      width: 80,
                      height: 60,
                      padding: EdgeInsets.all(0),
                      icon: _selectedIndex == 0
                          ? Image.asset(
                              'assets/images/home/home_tab_workspace_' +
                                  theme +
                                  '.png',
//                    width: 70,
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/home/un_home_tab_workspace.png',
//                    width: 70,
                              height: 30,
                            ),
                      text: titles[0],
                      iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == 0
                              ? GetConfig.getColor(theme)
                              : Colors.grey),
//                  color: _selectedIndex == 0?Colors.red:Colors.grey,
                    ),
                    EachTab(
                      width: 80,
                      height: 60,
                      padding: EdgeInsets.all(0),
                      icon: _selectedIndex == 1
                          ? Image.asset(
                              'assets/images/home/home_statistic_' +
                                  theme +
                                  '.png',
//                    width: 70,
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/home/un_home_statistic.png',
//                    width: 70,
                              height: 30,
                            ),
                      text: titles[1],
                      iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == 1
                              ? GetConfig.getColor(theme)
                              : Colors.grey),
                      //color: _selectedIndex == 1?Colors.white:Colors.grey,
                    ),
                    EachTab(
                      width: 80,
                      height: 60,
                      padding: EdgeInsets.all(0),
                      icon: _selectedIndex == 2

                          ///修改为1  原为2
                          ? Image.asset(
                              'assets/images/home/home_my_' + theme + '.png',
//                    width: 70,
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/home/un_home_my.png',
//                    width: 70,
                              height: 30,
                            ),
                      text: titles[2],
                      iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == 2
                              ? GetConfig.getColor(theme)
                              : Colors.grey),
                      //color: _selectedIndex == 2?Colors.white:Colors.grey,
                    )
                  ],
                )
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(), //设置滑动的效果，这个禁用滑动
            controller: _tabController,
            children: <Widget>[
              HomeScreen(cqDatas /*,taskCount,unReadCount*/),
              StatisticsScreen(),
              MyScreen()
            ],
          )),
      onWillPop: () async {
        AndroidBackTop.backDeskTop(); //设置为返回不退出app
        return false;
      },
    );
  }
}
