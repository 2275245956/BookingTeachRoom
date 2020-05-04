
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:intelligent_check_new/pages/AndroidBackTop.dart';
import 'package:intelligent_check_new/pages/home_layout/SelectDatePage.dart';
import 'package:intelligent_check_new/pages/home_screen.dart';
import 'package:intelligent_check_new/pages/my/my_screen.dart';

class NavigationKeepAlive extends StatefulWidget {
  @override
  _NavigationKeepAliveState createState() => _NavigationKeepAliveState();
}

class _NavigationKeepAliveState extends State<NavigationKeepAlive>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 0;
  var titles = ['首页', 'TimeLine', '我的'];

  bool isAnimating = false;
  String theme = "red";
  bool isOffline = false;

  initData() async {
    setState(() {
      isAnimating = true;
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

  }

  @override
  Widget build(BuildContext context) {
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
                              'assets/images/home/home_tab_workspace_red.png',  height: 30,
                            )
                          : Image.asset(
                              'assets/images/home/un_home_tab_workspace.png',  height: 30,
                            ),
                      text: titles[0],
                      iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == 0
                              ? Color.fromRGBO(209, 6, 24, 1)
                              : Colors.grey),
//                  color: _selectedIndex == 0?Colors.red:Colors.grey,
                    ),
                    EachTab(
                      width: 80,
                      height: 60,
                      padding: EdgeInsets.all(0),
                      icon: _selectedIndex == 1
                          ? Image.asset(
                              'assets/images/home/home_statistic_red.png',
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/home/un_home_statistic.png',
                              height: 30,
                            ),
                      text: titles[1],
                      iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == 1
                              ? Color.fromRGBO(209, 6, 24, 1)
                              : Colors.grey),
                     
                    ),
                    EachTab(
                      width: 80,
                      height: 60,
                      padding: EdgeInsets.all(0),
                      icon: _selectedIndex == 2
                          ? Image.asset(
                              'assets/images/home/home_my_red.png',
                              height: 30,
                            )
                          : Image.asset(
                              'assets/images/home/un_home_my.png',
                              height: 30,
                            ),
                      text: titles[2],
                      iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == 2
                              ? Color.fromRGBO(209, 6, 24, 1)
                              : Colors.grey),
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
              HomeScreen(),
              SelectDatePage(),
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
