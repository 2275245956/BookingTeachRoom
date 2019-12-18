import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/Activility/ActivilityModel.dart';
import 'package:intelligent_check_new/model/Activility/ActivilityStepModel.dart';
import 'package:intelligent_check_new/pages/Activity/activility_list.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/hidden_danger_found.dart';
import 'package:intelligent_check_new/services/Activility_services.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'activility_steps2running.dart';

class ActivilityStepsRun extends StatefulWidget {
  final ActivilityModel _activility;

  ActivilityStepsRun(this._activility);

  @override
  State<StatefulWidget> createState() {
    return _ActivilityStepsRun();
  }
}

class _ActivilityStepsRun extends State<ActivilityStepsRun> {
  String strRouts = "";
  String strClassify = "";
  String permissionList = "";
  String theme = "blue";
  List<StepModel> steps;
  String resultJosnStr = "";
  bool isAnimating = false;
  bool canOperate = true;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    await getStepsAllInfo(this.widget._activility.id).then((data) {
      setState(() {
        if (data.success && data.dataList != null) {
          steps = new List();
          for (var step in data.dataList["taskworkContents"]) {
            steps.add(StepModel.fromJson(step));
          }
        }
      });
    });
  }

  executeFlow(int type, String remark, dynamic flowJson) async {
    setState(() {
      isAnimating = true;
      canOperate = false;
    });
    await executeFlowActivility(
            this.widget._activility.currentFlowRecordId, type, remark, flowJson)
        .then((response) {
          setState(() {
            if (response.success) {
              //通过
              HiddenDangerFound.popUpMsg("操作成功！");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new ActivilityList();
              }));
            } else {
              //流程执行失败
              if (response.message != null) {
                HiddenDangerFound.popUpMsg(response.message);
              } else {
                HiddenDangerFound.popUpMsg("操作失败！");
              }
            }
            isAnimating = false;
            canOperate = true;
          });


    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (steps == null) {
      return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "步骤清单",
              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            elevation: 0.2,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            leading: new Container(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.keyboard_arrow_left,
                    color: GetConfig.getColor(theme), size: 32),
              ),
            ),
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
        }

      );

    }
    return WillPopScope(
      child:  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(top: 15, right: 20),
                  child: Text(
                    "提交",
                    style: TextStyle(
                        color: Color.fromRGBO(50, 89, 206, 1),
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  if (canOperate) {
                    var jsonStr = {
                      "taskworkContents": json.decode(this.steps.toString())
                    };
                    executeFlow(2, "", jsonStr);
                  } else {
                    HiddenDangerFound.popUpMsg("正在执行操作！请稍等...");
                  }
                })
          ],
          title: Text(
            "步骤清单",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: new Container(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_left,
                  color: GetConfig.getColor(theme), size: 32),
            ),
          ),
        ),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  //开关柜检修
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, top: 10,bottom: 10),
                          //height: 50,
                          child: Text(
                            this.widget._activility.taskworkName ?? "--",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //等级
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.only(left: 10, top: 10,bottom: 10),
                          //height: 50,
                          child: Text(
                            "等级",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(this.widget._activility.levelDesc ?? "--"),
                      )
                    ],
                  ),
                  // Divider(),

                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.only(left: 10, top: 10,bottom: 10),
                          //height: 50,
                          child: Text(
                            "申请时间",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child:
                        Text(this.widget._activility.applyDateTime ?? "--"),
                      ),
                    ],
                  ),
                  //分割线
                  Container(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    height: 10,
                  ),

                  this.steps != null
                      ? Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10,bottom: 10),
                        //height: 50,
                        width: MediaQuery.of(context).size.width,

                        child: Text(
                          "作业活动步骤",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: this.steps.map((s) {
                            return Container(
                                padding: EdgeInsets.only(left: 20, top: 10,bottom: 5),
                                width: MediaQuery.of(context).size.width,

                                child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          (s.serialNum.toString() +
                                              "." +
                                              (s.taskworkContentName ??
                                                  "--")),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        flex: 8,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.build,
                                              color: Color.fromRGBO(
                                                  50, 89, 206, 1),
                                              size: 15,
                                            ),
                                            new Text('执行',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromRGBO(
                                                        50, 89, 206, 1))),
                                          ],
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: new Icon(
                                          Icons.keyboard_arrow_right,
                                          color: GetConfig.getColor(theme),
                                          size: 25,
                                        ),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) {
                                              return ActivilitySteps2Running(
                                                  this.widget._activility, s);
                                            }));
                                  },
                                ));
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                      : Container(),

                  Container(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          inAsyncCall: isAnimating,
          // demo of some additional parameters
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ),
        resizeToAvoidBottomPadding: true,
      ),
      onWillPop: () {
        Navigator.pop(context);
      },
    );

  }
}
