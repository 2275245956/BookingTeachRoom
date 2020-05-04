import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/StuApplyLamModel.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/services/StudentServices/StudentOperate.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentSelfApplyRecord extends StatefulWidget {
  StudentSelfApplyRecord();

  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<StudentSelfApplyRecord>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 当前页码
  int pageNum = 1;
  int pageSize = 10;

  List<StuApplyModel> initRecordData = new List();

  bool isAnimating = false;

  String theme = "red";
  UserModel userInfo;

  var reqNumber="0";
  @override
  void initState() {
    super.initState();
    _InitData();
  }

  void _InitData() async {
    await SharedPreferences.getInstance().then((sp) {
      setState(() {
        if (sp.getString("userModel") != null) {
          userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
        }
      });
    }).then((_) {
      loadData();
    });
  }

  void loadData() async {
    var data = await StuApplyRecord(userInfo.account);
    if (data.success && data.dataList != "") {
      for (var str in data.dataList) {
        setState(() {
          initRecordData.add(new StuApplyModel.fromJson(str));
        });
      }
    }
  }
  void CancelApply() async {
    var data = await StuCalcelApply(reqNumber);
    if (data.success) {
      GetConfig.popUpMsg(data.message ?? "操作成功！");
      Navigator.pop(context);
    } else {
      GetConfig.popUpMsg(data.message ?? "操作失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.initRecordData == null && userInfo.account != "") {
      return Scaffold(
          backgroundColor: Color.fromRGBO(242, 246, 249, 1),
          appBar: AppBar(
            title: Text(
              "申请记录",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            centerTitle: true,
            elevation: 0.2,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            actions: <Widget>[],
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
            "申请记录",
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          actions: <Widget>[],
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
              child:ListView.builder(
            //ListView的Item
            itemCount: initRecordData.length,
            itemBuilder: (BuildContext context, int index) {

              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.only(
                        top: 5, left: 3, right: 3),
                    child: new Container(
                        height: 110.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 8,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft:
                                    Radius.circular(4)),
                                color: getPointColor(
                                    initRecordData[index]
                                        .status),
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
                                        "教师:${initRecordData[index].eTName}",
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
                                          "学生：${initRecordData[index].sName}(${initRecordData[index].sNumber})",
                                          style: TextStyle(
                                              color:
                                              Colors.grey,
                                              fontSize: 12),
                                        ),
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
                                            color: getPointColor(
                                                initRecordData[
                                                index]
                                                    .status),
                                            fontSize: 12),
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
                                        "时间:",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        "${initRecordData[index].eStarttime} ~ ${initRecordData[index].eEndtime}",
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
                ),
                secondaryActions: <Widget>[
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.only(
                        top: 5, right: 3),
                    child: new Container(
                        height: 110.0,
                        child:  IconSlideAction(
                          caption: '取消申请',
                          color: GetConfig.getColor(theme),
                          icon: Icons.delete_forever,
                          onTap: () {
                           if (initRecordData[index].status == "申请通过(教师)" ||
                                initRecordData[index].status == "申请通过(管理员)") {
                              GetConfig.IOSPopMsg(
                                  "提示", Text("该实验已经通过审核，请联系管理员或者教师！"), context);
                              return false;
                            }else if(initRecordData[index].status=="申请提交(学生)"){
                              setState(() {
                                reqNumber=initRecordData[index].reqNumber;
                              });
                              GetConfig.IOSPopMsg(
                                  "取消提示", Text("确认取消该实验？"), context,confirmFun: CancelApply);
                            }
                          },
                        ),),
                  ),
                ],
              );

            },
          ),),
          inAsyncCall: isAnimating,
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ));
  }

  Color getPointColor(String status) {
    switch (status) {
      case "申请提交(学生)":
        return Colors.orange;
      case "申请取消(学生)":
        return Colors.black;
      case "申请通过(管理员)":
        return Colors.green;
      case "申请通过(教师)":
        return Colors.green;
      case "申请退回(教师)":
        return Colors.red;
      case "申请退回(管理员)":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
