import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/TeacherApplyRecord.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_student/StudentApplyLambDetail.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_student/StudentApplySearchPage.dart';
import 'package:intelligent_check_new/services/StudentServices/StudentOperate.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentApplyRecord extends StatefulWidget {
  StudentApplyRecord();

  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<StudentApplyRecord>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 当前页码
  int pageNum = 1;
  int pageSize = 10;

  // 是否有下一页
  bool hasNext = true;
  List<TeacherApplyRecord> initRecordData = new List();

  // 分页所需控件
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  bool isAnimating = false;

  String theme = "red";
  UserModel userInfo;

  String status = "0";
  String tNumber = "";
  String selectNumber = "";

  @override
  void initState() {
    super.initState();
    _InitData();
  }

  void _InitData() async {
    var sp = await SharedPreferences.getInstance();
    setState(() {
      if (sp.getString("userModel") != null) {
        userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
      }
    });
    await StuApplyRecord(userInfo.account).then((data) {
      setState(() {
        if(data.success && data.dataList!=null){
          selectNumber = data.dataList[0]["reqNumber"];
        }

      });
    }).then((_){
      loadData();
    });


  }

  void loadData() async {
    var data =
        await GetAllPassedTeacherlambs(userInfo.account, pageNum.toString());
    if (data.success && data.dataList != "") {
      setState(() {
        hasNext = true;
      });
      for (var str in data.dataList) {
        setState(() {
          var model = new TeacherApplyRecord.fromJson(str);
          model.selected = model.reqNumber == selectNumber;
          initRecordData.add(model);
        });
      }
      if (initRecordData.length < 10) {
        setState(() {
          hasNext = false;
        });
      }
    } else {
      setState(() {
        hasNext = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.initRecordData == null && userInfo.account != "") {
      return Scaffold(
          backgroundColor: Color.fromRGBO(242, 246, 249, 1),
          appBar: AppBar(
            title: Text(
              "开放性实验",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            centerTitle: true,
            elevation: 0.2,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  child: Image.asset(
                    "assets/images/search_red.png",
                    width: 22,
                  ),
                  padding: EdgeInsets.only(right: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return StudentApplySearchPage(false);
                  }));
                },
              )
            ],
            leading: new Container(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.keyboard_arrow_left,
                    color: GetConfig.getColor(theme), size: 32),
              ),
            ),
          ),
          body: Container());
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        appBar: AppBar(
          title: Text(
            "开放性实验",
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          actions: <Widget>[
            GestureDetector(
              child: Container(
                child: Image.asset(
                  "assets/images/search_red.png",
                  width: 22,
                ),
                padding: EdgeInsets.only(right: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return StudentApplySearchPage(false);
                }));
              },
            )
          ],
          leading: new Container(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_left,
                  color: GetConfig.getColor(theme), size: 32),
            ),
          ),
        ),
        body: ModalProgressHUD(
          child: new Padding(
              padding: new EdgeInsets.only(top: 0.0),
              child: new Column(
                children: <Widget>[
                  new Expanded(
                      child: new Stack(
                    children: <Widget>[
                      Center(
                          child: EasyRefresh(
                        key: _easyRefreshKey,
                        behavior: ScrollOverBehavior(),
                        refreshHeader: ClassicsHeader(
                          key: _headerKey,
                          bgColor: Colors.transparent,
                          textColor: Colors.black87,
                          moreInfoColor: Colors.black54,
                          showMore: true,
                        ),
                        refreshFooter: ClassicsFooter(
                          key: _footerKey,
                          bgColor: Colors.transparent,
                          textColor: Colors.black87,
                          moreInfoColor: Colors.black54,
                          showMore: true,
                        ),
                        child: ListView.builder(
                          //ListView的Item
                          itemCount: initRecordData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return StudentApplyLambDetail(
                                        initRecordData[index]);
                                  }));
                                },
                                child: Container(
                                  child: Card(
                                    elevation: 2,
                                    margin: EdgeInsets.only(
                                        top: 5, left: 3, right: 3),
                                    child: new Container(
                                        height: 133.0,
//                                          margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 8,
                                              height: 133,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4)),
                                                color: initRecordData[index]
                                                        .selected
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, top: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new Text(
                                                    "${index + 1}.  ${initRecordData[index].eName}",
                                                    style: new TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                      ),
                                                      Text(
                                                        "教室名称及编号:${initRecordData[index].rNumber} (${initRecordData[index].rMaxPer})",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            50,
                                                        child: Text(
                                                          "节次：${initRecordData[index].section}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      new Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color:
                                                            GetConfig.getColor(
                                                                theme),
                                                        size: 28,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                      ),
                                                      Text(
                                                        "当前状态:",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "${initRecordData[index].status}",
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                      ),
                                                      Text(
                                                        "时间:",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "${initRecordData[index].eDate} ~ ${initRecordData[index].attriText01}",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
//                                          margin: EdgeInsets.only(left: 10,right: 10),
                                ));
                          },
                        ),
                        onRefresh: () async {
                          await new Future.delayed(const Duration(seconds: 1),
                              () {
                            setState(() {
                              pageNum = 1;
                              initRecordData = new List();
                            });
                            loadData();
                          });
                        },
                        loadMore: () async {
                          await new Future.delayed(const Duration(seconds: 1),
                              () {
                            if (hasNext) {
                              setState(() {
                                pageNum = pageNum + 1;
                              });
                              loadData();
                            }
                          });
                        },
                      )),
                    ],
                  ))
                ],
              )),
          inAsyncCall: isAnimating,
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ));
  }
}
