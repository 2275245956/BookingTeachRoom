import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/Task/TaskAddModel.dart';
import 'package:intelligent_check_new/pages/CheckExecute/checkexec_inspection_list.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/hidden_danger_found.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/hidedanger_pending.dart';
import 'package:intelligent_check_new/services/HiddenDanger.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class InspectionHiddenDangerFound extends StatefulWidget {
  final num checkId;

  List<UNCheckInput> unCheckInputData;

  final bool  isGetQueryUnqualifiedInputItemFlag;

  InspectionHiddenDangerFound(this.isGetQueryUnqualifiedInputItemFlag,{this.checkId, this.unCheckInputData});

  @override
  _InspectionHiddenDangerFound createState() =>
      new _InspectionHiddenDangerFound();
}

class _InspectionHiddenDangerFound extends State<InspectionHiddenDangerFound> {
  List<TaskErrorItem> items = List();
  bool isAnimating = false;
  bool canOperate = true;

  reSetValue() async {
    setState(() {
      if (this.widget.unCheckInputData != null) {
        this.widget.unCheckInputData.forEach((f) {
          f.dangerLevel = 0;
        });
      } else if (items != null) {
        items.forEach((f) {
          f.dangerLevel = 0;
        });
      }
    });
  }

  bool _checkNeed() {
    if (this.widget.unCheckInputData != null) {
      for (UNCheckInput item in this.widget.unCheckInputData) {
        if (item.dangerLevel == null || item.dangerLevel == 0) {
          HiddenDangerFound.popUpMsg("请选择：  “" + item.name + "”  巡检项的隐患等级");
          return false;
        }
      }
    } else if (items != null) {
      for (TaskErrorItem item in items) {
        if (item.dangerLevel == null || item.dangerLevel == 0) {
          HiddenDangerFound.popUpMsg("请选择：  “" + item.name + "”  巡检项的隐患等级");
          return false;
        }
      }
    }

    return true;
  }

  _saveData(num checkId, List<TaskDetailForAdd> details) async {
    setState(() {
      isAnimating = true;
      canOperate = false;
    });

    await saveInspectionDangerInfo(checkId, details).then((data) {
      if (data) {
        HiddenDangerFound.popUpMsg("隐患创建成功！");
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (context) => new PendingHideDanger()),
            (route) => route == null);
      } else {
        HiddenDangerFound.popUpMsg("隐患创建失败！");
      }
      setState(() {
        isAnimating = false;
        canOperate = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(this.widget.isGetQueryUnqualifiedInputItemFlag){
      getQueryUnqualifiedInputItem();
    }
  }

  getQueryUnqualifiedInputItem() async {
    if (this.widget.unCheckInputData == null && this.widget.checkId >= 0) {
      await queryUnqualifiedInputItem(this.widget.checkId).then((data) {
        setState(() {
          items = data;
        });
      });
    } else {
      HiddenDangerFound.popUpMsg("数据不存在");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.unCheckInputData == null &&
        (this.widget.checkId == null || this.widget.checkId < 0)) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "隐患添加",
            style: TextStyle(
              color: Colors.black,
              fontSize: 19,
            ),
          ),
          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: new Container(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                      builder: (context) => new PendingHideDanger()),
                  (route) => route == null),
              child: Icon(Icons.keyboard_arrow_left,
                  color: Color.fromRGBO(50, 89, 206, 1), size: 32),
            ),
          ),
        ),
        body: Container(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "隐患添加",
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
        elevation: 0.2,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: new Container(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                    builder: (context) => new PendingHideDanger()),
                (route) => route == null),
            child: Icon(Icons.keyboard_arrow_left,
                color: Color.fromRGBO(50, 89, 206, 1), size: 32),
          ),
        ),
      ),
      body: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("说明:请确定检查不通过的是否转换为隐患任务",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
                Container(
                  height: 10,
                  color: Color.fromRGBO(244, 244, 244, 1),
                ),
                this.widget.unCheckInputData != null
                    ? Container(child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: this.widget.unCheckInputData.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  //巡检项
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.only(left: 10.0, top: 10.0),
                                    child: Text(
                                      this.widget.unCheckInputData[index].name,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  //巡检项等级
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10.0, top: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 20),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                50,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            20,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 5,
                                                                child:
                                                                    RadioListTile(
                                                                        title:
                                                                            Text(
                                                                          "一般隐患",
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                        value:
                                                                            1,
                                                                        groupValue: this
                                                                            .widget
                                                                            .unCheckInputData[
                                                                                index]
                                                                            .dangerLevel,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            print(value);
                                                                            this.widget.unCheckInputData[index].dangerLevel =
                                                                                value;
                                                                          });
                                                                        }),
                                                                //带文字的单选按钮 value值=groupValue值 即选中状态
                                                              ),
                                                              Expanded(
                                                                flex: 5,
                                                                child:
                                                                    RadioListTile(
                                                                        title:
                                                                            Text(
                                                                          "重大隐患",
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                        value:
                                                                            2,
                                                                        groupValue: this
                                                                            .widget
                                                                            .unCheckInputData[
                                                                                index]
                                                                            .dangerLevel,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            print(value);
                                                                            this.widget.unCheckInputData[index].dangerLevel =
                                                                                value;
                                                                          });
                                                                        }),
                                                                //带文字的单选按钮 value值=groupValue值 即选中状态
                                                              ),
                                                            ],
                                                          ),
                                                          flex: 3,
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    height: 10,
                                    color: Color.fromRGBO(244, 244, 244, 1),
                                  ),
                                ],
                              );
                            }))
                    : items != null && items.length > 0
                        ? Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      //巡检项
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: Text(
                                          items[index].name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      //巡检项等级
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    50,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            20,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: new Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    flex: 5,
                                                                    child: RadioListTile(
                                                                        title: Text(
                                                                          "一般隐患",
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                        value: 1,
                                                                        groupValue: items[index].dangerLevel,
                                                                        onChanged: (value) {
                                                                          setState(
                                                                              () {
                                                                            items[index].dangerLevel =
                                                                                value;
                                                                          });
                                                                        }),
                                                                    //带文字的单选按钮 value值=groupValue值 即选中状态
                                                                  ),
                                                                  Expanded(
                                                                    flex: 5,
                                                                    child: RadioListTile(
                                                                        title: Text(
                                                                          "重大隐患",
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                        value: 2,
                                                                        groupValue: items[index].dangerLevel,
                                                                        onChanged: (value) {
                                                                          setState(
                                                                              () {
                                                                            items[index].dangerLevel =
                                                                                value;
                                                                          });
                                                                        }),
                                                                    //带文字的单选按钮 value值=groupValue值 即选中状态
                                                                  ),
                                                                ],
                                                              ),
                                                              flex: 3,
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(
                                        height: 10,
                                        color: Color.fromRGBO(244, 244, 244, 1),
                                      ),
                                    ],
                                  );
                                }))
                        : Container(),
              ],
            ),
          ),
        ),
        inAsyncCall: isAnimating,
        // demo of some additional parameters
        opacity: 0.7,
        progressIndicator: CircularProgressIndicator(),
      ),
      persistentFooterButtons: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width / 2) - 16,
              height: 60,
              margin: EdgeInsets.only(left: 0),
              child: new MaterialButton(
                color: Color.fromRGBO(242, 246, 249, 1),
                height: 60,
                textColor: Colors.black,
                child: new Text(
                  '重置',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  if (canOperate) {
                    reSetValue();
                  } else {
                    HiddenDangerFound.popUpMsg("正在执行操作！请稍等...");
                  }
                },
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width / 2),
              child: new MaterialButton(
                  color: Color.fromRGBO(50, 89, 206, 1),
                  height: 60,
                  textColor: Colors.white,
                  child: new Text('确定', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    //必填项判断
                    //巡检 计划提交隐患
                    if (this.widget.unCheckInputData != null && items.length < 1) {
                      if (_checkNeed()) {
                        if (!canOperate) {
                          HiddenDangerFound.popUpMsg("正在执行操作！请稍等...");
                        } else {
                          canOperate = false;
                          List<TaskDetailForAdd> details = new List();
                          this.widget.unCheckInputData.forEach((f) {
                            details.add(TaskDetailForAdd.fromParams(
                                checkId: this.widget.checkId,
                                itemId: f.itemId,
                                dangerLevel: f.dangerLevel,
                                routePointItemId: f.routePointItemId));
                          });
                          _saveData(this.widget.checkId, details);
                        }
                      }
                    }
                    //巡检记录提交隐患
                    else if (items.length>0 &&
                        this.widget.unCheckInputData == null) {
                      if (_checkNeed()) {
                        if (!canOperate) {
                          HiddenDangerFound.popUpMsg("正在执行操作！请稍等...");
                        } else {
                          canOperate = false;
                          List<TaskDetailForAdd> details = new List();
                          items.forEach((f) {
                            details.add(TaskDetailForAdd.fromParams(
                                checkId: this.widget.checkId,
                                itemId: f.itemId,
                                dangerLevel: f.dangerLevel,
                                routePointItemId: f.route_point_item_id));
                          });
                          _saveData(this.widget.checkId, details);
                        }
                      }
                    } else {
                      HiddenDangerFound.popUpMsg("不存在不合格检查项！");
                      return false;
                    }
                  }),
            ),
          ],
        ),
      ],
      resizeToAvoidBottomPadding: false,
    );
  }
}
