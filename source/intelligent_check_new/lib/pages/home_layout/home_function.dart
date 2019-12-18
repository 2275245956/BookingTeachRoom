import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:intelligent_check_new/model/CompanyInfo.dart';
import 'package:intelligent_check_new/model/home_function_model.dart';
import 'package:intelligent_check_new/pages/Activity/activility_list.dart';
import 'package:intelligent_check_new/pages/SelCompanyAndDept.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/hidden_danger_found.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/hidden_danger_processed.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/hidedanger_pending.dart';
import 'package:intelligent_check_new/pages/inspection_record/record_list_screen.dart';
import 'package:intelligent_check_new/pages/inspection_spot/inspection_spot_screen.dart';
import 'package:intelligent_check_new/pages/message/message_list.dart';
import 'package:intelligent_check_new/pages/no_plan_inspection/no_plan_inspection.dart';
import 'package:intelligent_check_new/pages/offline/inspection_spot/offline_inspection_spot_screen.dart';
import 'package:intelligent_check_new/pages/offline/no_plan_inspection/no_plan_inspection.dart';
import 'package:intelligent_check_new/pages/offline/plan_inspection/offline_plan_list_screen.dart';
import 'package:intelligent_check_new/pages/plan_inspection/plan_list_screen.dart';
import 'package:intelligent_check_new/pages/security_risk_judgment/security_risk_judgment_list.dart';
import 'package:intelligent_check_new/pages/task_calendar/calendar_main.dart';
import 'package:intelligent_check_new/services/company_services.dart';
import 'package:intelligent_check_new/tools/MessageBox.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFunction extends StatefulWidget {
  List<CompanyInfo> cqDatas;

//  int taskCount;
//  int unReadCount;

  HomeFunction({this.cqDatas} /*,this.taskCount,this.unReadCount*/);

  @override
  State<StatefulWidget> createState() => new _HomeFunctionState();
}

class _HomeFunctionState extends State<HomeFunction> {
  List<HomeFunctionModel> firstMenu = List();
  List<HomeFunctionModel> secondMenu = List();
  CompanyInfo cqSelect; //公司选择
  List<CompanyInfo> _cqDatas = new List();
  int _taskCount = 0;
  int _unReadCount = 0;
  int _dangerCount = 0;
  int _judgementCount = 0;

  bool isAnimating = false;
  bool isOffline = false;
  String theme = "blue"; //主题

  String companyName = "";

  @override
  Widget build(BuildContext context) {
    if (this.theme.isEmpty) {
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
                                  cqSelect == null
                                      ? companyName
                                      : cqSelect.label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 0),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelCompanyAndDept(
                                          isSelect: true,
                                        )));
                            //cqDialog();
                          },
                        ),
                        flex: 3,
                      ),

//                      Padding(padding: EdgeInsets.only(left: 20),),
                      theme == "blue"
                          ? Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                alignment: Alignment.center,
                                //padding: EdgeInsets.only(left: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/jiaoda/渭化集团@3x.png',
                                      width: 36,
                                      height: 36,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 2),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "陕西渭河煤化工集团",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "Shaanxi Werhe Coal Chemical",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 8),
                                        ),
                                        Text(
                                          "Corporation Group Ltd.",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 8),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              flex: 6,
                            )
                          : Expanded(
                              child: Container(
                                child: Image.asset(
                                  'assets/images/colo.png',
                                  width: 130,
                                ),
                                alignment: Alignment.center,
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
                                            backgroundColor: Colors.red,
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
                            })).then((v) {
                              //                            if(v!=null){
                              //                              getUnreadCount();
                              //                            }
                            });
                          },
                        ),
                        flex: 2,
                      ),
//                      Padding(padding: EdgeInsets.only(left: 20),),
                    ],
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Container(
                  child: new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      new Text(
                        "隐患排查",
                        style:
                            TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 40.0,
                  margin:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(250, 251, 252, 1), //Colors.grey[100],
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.circular(5.0)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: getFirstMenus(),
                    shrinkWrap: true,
                  ),
                ),
//                Padding(padding: EdgeInsets.only(top: 10),),
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
                              "隐患治理",
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
                          children: getSecondMenu(),
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
//                Padding(padding: EdgeInsets.only(top: 10),),
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
                              "作业活动",
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
                          children: getThirdMenu(),
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

    //getTaskCount();
    getUnreadCountMessage();
    getHaveToDo();
    initFunction();

    setState(() {
      this._cqDatas = this.widget.cqDatas;
//      this._taskCount = this.widget.taskCount;
//      this._unReadCount = this.widget.unReadCount;
      if (this._cqDatas != null) cqSelect = _cqDatas[0];
      SharedPreferences.getInstance().then((sp) {
        companyName = json.decode(sp.getString("sel_com"))["companyName"];
      });
    });
  }

  cqDialog() {
    if (this.isOffline) {
      MessageBox.showMessageOnly("离线模式，该功能暂不支持。", context);
      return;
    }
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return _cqDatas != null
            ? SimpleDialog(
                children: _cqDatas.map((f) {
                  return Column(
                    children: <Widget>[
                      new SimpleDialogOption(
                        child: new Text(f.label),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            cqSelect = f;
                            // 公司切换
                            selectCompany(this.cqSelect.key);
                          });
                        },
                      ),
                      Divider(
                        height: 1,
                      )
                    ],
                  );
                }).toList(),
              )
            : Container();
      },
    );
  }

  initFunction() async {
    await SharedPreferences.getInstance().then((sp) {
      if (sp.getBool("offline") != null) {
        setState(() {
          isOffline = sp.getBool("offline");
          this.theme = sp.get("theme") ?? KColorConstant.DEFAULT_COLOR;
          print(this.theme);
          print("isOffline:$isOffline");
        });
      }
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
            badge: this._taskCount > 0
                ? CircleAvatar(
              backgroundColor: Colors.red,
              radius: 3,
            )
                : Container(),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Image.asset(
                "assets/images/home/plan_inspection_" + theme + ".png",
                width: 28),
            text: "计划巡检",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return isOffline ? OfflinePlanListScreen() : PlanListScreen();
            }));
          },
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
//            badge: this._taskCount > 0
//                ? CircleAvatar(
//                    backgroundColor: Colors.red,
//                    radius: 3,
//                  )
//                : Container(),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Image.asset("assets/images/home/no_plan_" + theme + ".png",
                width: 28),
            text: "无计划巡检",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return isOffline ? OfflineNoPlanInspection() : NoPlanInspection();
            }));
//            if(isOffline){
//              Navigator.push( context,
//                  new MaterialPageRoute(builder: (context) {
//                    return OfflineHiderManageMyTaskPage();
//                  })
//              );
//            }else{
//              Navigator.push( context,
//                  new MaterialPageRoute(builder: (context) {
//                    return HideDangerPage(1);
//                  })
//              );
//            }
          },
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
//           badge: this._taskCount > 0
//               ? CircleAvatar(
//             backgroundColor: Colors.red,
//             radius: 3,
//           )
//               : Container(),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Image.asset(
              "assets/images/home/inspection_point_" + theme + ".png",
              width: 28,
            ),
            text: "固有风险点",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return isOffline
                  ? OfflineInspectionSpotScreen()
                  : InspectionSpotScreen();
            }));
          },
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
//           badge: this._taskCount > 0
//               ? CircleAvatar(
//             backgroundColor: Colors.red,
//             radius: 3,
//           )
//               : Container(),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Image.asset(
              "assets/images/home/move_inspection_" + theme + ".png",
              width: 28,
            ),
            text: "动态风险",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () { 
          },
        ));
    Container container5 = Container(
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
//           badge: this._taskCount > 0
//               ? CircleAvatar(
//             backgroundColor: Colors.red,
//             radius: 3,
//           )
//               : Container(),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon:  Image.asset("assets/images/home/inspection_record_"+theme+".png",width: 28),
            text: "巡检记录",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
           Navigator.push(context, new MaterialPageRoute(builder: (context) {
             return RecordListScreen();
           }));

          },
        ));
    Container container6 = Container(
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
//           badge: this._taskCount > 0
//               ? CircleAvatar(
//             backgroundColor: Colors.red,
//             radius: 3,
//           )
//               : Container(),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon:Image.asset("assets/images/home/inspection_calendar_"+theme+".png",width: 28),
            text: "巡检日历",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
           Navigator.push(context, new MaterialPageRoute(builder: (context) {
             return CalendarMainPage();
           }));

          },
        ));
    Container container7 = Container(
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
            badge: this._judgementCount > 0
                ? CircleAvatar(
              backgroundColor: Colors.red,
              radius: 3,
            ):Container(),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Image.asset("assets/images/jiaoda/safe_danger_judgement_"+theme+".png",width: 28),
            text: "安全风险研判",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
           Navigator.push(context, new MaterialPageRoute(builder: (context) {
             return SecurityRiskJudegmentList();
           }));

          },
        ));
    Container container8 = Container(
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
//           badge: this._judgementCount > 0
//               ? CircleAvatar(
//             backgroundColor: Colors.red,
//             radius: 3,
//           )
               //: Container(),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
//            icon: Image.asset(
//              "",
//              width: 28,
//            ),
            text: "",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {

          },
        ));
    firstMenu.add(container1);
    firstMenu.add(container2);
    firstMenu.add(container3);
    firstMenu.add(container4);
    firstMenu.add(container5);
    firstMenu.add(container6);
    firstMenu.add(container7);
    firstMenu.add(container8);


    return firstMenu;
  }

  // 隐患治理菜单
  getSecondMenu() {
    List<Container> secondMenuList = List();
    // 我姐收
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
            badge: this._dangerCount > 0
                ? CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 3,
                  )
                : Container(),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Image.asset(
              "assets/images/jiaoda/wait_do_" + theme + ".png",
              width: 28,
              height: 28,
            ),
            text: "待处理",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return new PendingHideDanger();
            }));
//            if(isOffline){
//              Navigator.push( context,
//                  new MaterialPageRoute(builder: (context) {
//                    return OfflineHiderManageMyTaskPage();
//                  })
//              );
//            }else{
//              Navigator.push( context,
//                  new MaterialPageRoute(builder: (context) {
//                    return HideDangerPage(1);
//                  })
//              );
//            }
          },
        ));
    // 我发起
    Container container2 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: GestureDetector(
          child: EachTab(
            width: 80,
            //badge: CircleAvatar(backgroundColor: Colors.red,radius: 3,),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Image.asset(
              "assets/images/jiaoda/do_over_" + theme + ".png",
              width: 28,
              height: 28,
            ),
            text: "已处理",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return new ProcessedHiddenDanger();
            }));

//            if(isOffline){
//              MessageBox.showMessageOnly("当前是离线模式，功能暂不可用", context);
//            }else{
//              Navigator.push( context,
//                  new MaterialPageRoute(builder: (context) {
//                    return HideDangerPage(2);
//                  })
//              );
//            }
          },
        ));
    // 任务添加
    Container container3 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: GestureDetector(
          child: EachTab(
            width: 80,
            badge: Text(""),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Image.asset("assets/images/home/add_task_" + theme + ".png",
                width: 28),
            text: "隐患添加",
            textStyle: TextStyle(
                fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return new HiddenDangerFound();
            }));
//            if(isOffline){
//              MessageBox.showMessageOnly("当前是离线模式，功能暂不可用", context);
//            }else{
//              Navigator.push( context,
//                  new MaterialPageRoute(builder: (context) {
//                    return TaskAdditionScreen();
//                  })
//              );
//            }
          },
        ));
    // 全部任务
    Container container4 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(bottomRight: Radius.circular(5)),
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: EachTab(
          width: 80,
          badge: Text(""),
          badgeColor: Colors.red,
          height: 40,
          padding: EdgeInsets.all(0),
//          icon: Image.asset("assets/images/home/all_task_"+theme+".png",width: 28),
          text: "",
          textStyle:
              TextStyle(fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
          color: Colors.white,
        ));
    secondMenuList.add(container1);
    secondMenuList.add(container2);
    secondMenuList.add(container3);
    secondMenuList.add(container4);
    return secondMenuList;
  }

  getThirdMenu() {
    List<Container> secondMenuList = List();
    // 我姐收
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
            badge: Text(""),
            badgeColor: Colors.red,
            height: 40,
            padding: EdgeInsets.all(0),
            icon: Image.asset(
                "assets/images/jiaoda/generalwork_" + theme + ".png",
                width: 28),
            text: "一般作业活动",
            textStyle: TextStyle(
                fontSize: 11, color: Color.fromRGBO(153, 153, 153, 1)),
            color: Colors.white,
          ),
          onTap: () {
//            if(isOffline){
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return ActivilityList();
            }));
//            }else{
//              Navigator.push( context,
//                  new MaterialPageRoute(builder: (context) {
//                    return HideDangerPage(1);
//                  })
//              );
//            }
          },
        ));
    // 我发起
    Container container2 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: EachTab(
          width: 80,
          badge: Text(""),
          badgeColor: Colors.red,
          height: 40,
          padding: EdgeInsets.all(0),
//            icon: Image.asset("assets/images/home/my_send_"+theme+".png",width: 28),
          text: "",
          textStyle:
              TextStyle(fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
          color: Colors.white,
        ));
    // 任务添加
    Container container3 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: EachTab(
          width: 80,
          badge: Text(""),
          badgeColor: Colors.red,
          height: 40,
          padding: EdgeInsets.all(0),
          //icon: Image.asset("assets/images/home/add_task_"+theme+".png",width: 28),
          text: "",
          textStyle:
              TextStyle(fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
          color: Colors.white,
        ));
    // 全部任务
    Container container4 = Container(
        height: 82,
        width: 82,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.only(bottomRight: Radius.circular(5)),
          color: Colors.white,
          border: new Border.all(width: 0.5, color: Colors.grey[100]),
        ),
        child: EachTab(
          width: 80,
          badge: Text(""),
          badgeColor: Colors.red,
          height: 40,
          padding: EdgeInsets.all(0),
//          icon: Image.asset("assets/images/home/all_task_"+theme+".png",width: 28),
          text: "",
          textStyle:
              TextStyle(fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
          color: Colors.white,
        ));
    secondMenuList.add(container1);
    secondMenuList.add(container2);
    secondMenuList.add(container3);
    secondMenuList.add(container4);
    return secondMenuList;
  }

//  getTaskCount() async {
//    await getQueryPlanTaskCount().then((count) {
//      if (mounted) {
//        setState(() {
//          _taskCount = count;
//
//        });
//      }
//    });
//  }

  getUnreadCountMessage() async {
    await getUnreadCount().then((count) {
      if (mounted) {
        setState(() {
          _unReadCount = count;
        });
      }
    });
  }

  getHaveToDo() async {
    await getSelfTaskStatus().then((obj) {
      if (mounted) {
        setState(() {
          this._dangerCount = obj.haveDanger ? 1 : 0;
          this._judgementCount = obj.havaJudgment ? 1 : 0;
          this._taskCount=obj.havaPlanTask?1:0;
        });
      }
    });
  }
}
