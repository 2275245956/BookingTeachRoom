
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:intelligent_check_new/model/CheckItem.dart';
import 'package:intelligent_check_new/model/MovePointAddModel.dart';
import 'package:intelligent_check_new/pages/move_inspection/check_item_list.dart';
import 'package:intelligent_check_new/pages/move_inspection/check_item_set.dart';
import 'package:intelligent_check_new/services/check_point_service.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/tools/MessageBox.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoveSpotAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoveSpotAddState();
}

class _MoveSpotAddState extends State<MoveSpotAdd> {
  String _noControllerErrorText = "";
  String _nameControllerErrorText = "";
  String _checkItemErrorText = "";
  final TextEditingController _noController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _noteController = new TextEditingController();
  // 数据对象
  MovePointAddModel movePoint;

  List<CheckItem> selectedCheckItem = new List();

  // 是否保存中
  bool isSaving = false;

  String theme="blue";

  @override
  void initState() {
    super.initState();
    setState(() {
      movePoint = MovePointAddModel.fromJson({});
      // 初始化
      movePoint.offline = false;
    });
    initConfig();
  }

  initConfig() async{
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        this.theme = preferences.getString("theme")??KColorConstant.DEFAULT_COLOR;
      });
    });
  }

  saveMovePoint() async {
    setState(() {
      isSaving = true;
    });

    // 验证巡检点编号
    await _noControllerValidation().then((result){
      // 验证巡检点名称
      _nameControllerValidation();
      // 验证检查项
      _checkItemValidation();

      if(this._noControllerErrorText.isEmpty && this._nameControllerErrorText.isEmpty && this._checkItemErrorText.isEmpty){
        List<int> inputItemIds = new List();
        this.selectedCheckItem.forEach((f) {
          inputItemIds.add(f.id);
        });
        movePoint.inputItems = inputItemIds.join(",");
        // 默认值
        movePoint.shotMaxNumber = 10;
        movePoint.shotMinNumber = 1;
        saveData(movePoint);
      }
    });
  }

  saveData(MovePointAddModel movePoint) async {
    await addMovePoint(movePoint).then((result) {
      setState(() {
        isSaving = false;
      });
      if (result.isOk()) {
        MessageBox.showMessageAndExitCurrentPage("保存成功！", true, context);
      }else{
        MessageBox.showMessageOnly("保存失败！", context);
      }
    });
  }

  // 巡检编号验证
  Future<bool> _noControllerValidation() async {
    if(null == movePoint.pointNo || movePoint.pointNo == ""){
      setState(() {
        isSaving = false;
        this._noControllerErrorText = "巡检点编号不能为空";
      });
      return false;
    }

    String noReg = r'.*[\u4e00-\u9fa5]{1,}.*';
    RegExp regExp = new RegExp(noReg);
    if(regExp.hasMatch(movePoint.pointNo)){
      setState(() {
        isSaving = false;
        this._noControllerErrorText = "巡检点编号不能输入中文";
      });
      return false;
    }

    // 验证是否重复
    await queryAllPotinNos().then((pointNos){
      // 编号已存在
      if(pointNos.contains(movePoint.pointNo)){
        setState(() {
          isSaving = false;
          this._noControllerErrorText = "巡检点编号已存在";
        });
        return false;
      }else{
        setState(() {
          this._noControllerErrorText = "";
        });
        return true;
      }
    }).then((result){
      return result;
    });
  }

  // 检查项验证
  _checkItemValidation(){
    if(null == this.selectedCheckItem || this.selectedCheckItem.length < 1){
      setState(() {
        isSaving = false;
        this._checkItemErrorText = "至少选择一个检查项";
      });
    }else{
      setState(() {
        this._checkItemErrorText = "";
      });
    }
  }

  // 巡检名称验证
  _nameControllerValidation(){
    if(null == movePoint.name || movePoint.name == ""){
      setState(() {
        isSaving = false;
        this._nameControllerErrorText = "巡检点名称不能为空";
      });
    }else{
      setState(() {
        this._nameControllerErrorText = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 如果还未初始化
    if (null == movePoint) {
      return Scaffold(
          appBar: AppBar(
        title: Text(
          "安全执行点添加",
          style: TextStyle(color: Colors.black, fontSize: 19),
        ),
        centerTitle: true,
        elevation: 0.2,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: new Container(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left, color:  Color.fromRGBO(209, 6, 24, 1), size: 32),
          ),
        ),
      ));
    }

    return ModalProgressHUD(
      inAsyncCall: isSaving,
      opacity: 0.2,
      progressIndicator: CircularProgressIndicator(),
        child:Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "安全执行点添加",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            centerTitle: true,
            elevation: 0.2,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            leading: new Container(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.keyboard_arrow_left, color:  Color.fromRGBO(209, 6, 24, 1), size: 32),
              ),
            ),
          ),
          body: Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: new ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "*",
                          style: TextStyle(color: Colors.red),
                        ),
                        TextSpan(
                          text: "巡检点编号",
                        ),
                        TextSpan(
                          text:  _noControllerErrorText,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ])),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      new Container(
                          height: 40,
                          width: 340,
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: new BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: new Container(
                            child: TextField(
                              controller: _noController,
                              autofocus: false,
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (val) {
                                // 编辑事件赋值
                                setState(() {
                                  movePoint.pointNo = val;
                                });
                              },
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text:"巡检点名称"
                        ),
                        TextSpan(
                          text:  _nameControllerErrorText,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        )]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      new Container(
                          height: 40,
                          width: 340,
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: new BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: new Container(
                            child: TextField(
                              controller: _nameController,
                              autofocus: false,
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  // 编辑事件赋值
                                  movePoint.name = val;
                                });
                              },
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      Text("是否允许离线巡检"),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            groupValue: movePoint.offline,
                            activeColor:  Color.fromRGBO(209, 6, 24, 1),
                            value: true,
                            onChanged: (bool val) {
                              // val 与 value 的类型对应
                              setState(() {
                                movePoint.offline = val;
                              });
                            },
                          ),
                          Text("允许"),
                          Radio(
                            groupValue: movePoint.offline,
                            activeColor:  Color.fromRGBO(209, 6, 24, 1),
                            value: false,
                            onChanged: (val) {
                              // val 与 value 的类型对应
                              setState(() {
                                movePoint.offline = val;
                              });
                            },
                          ),
                          Text("不允许")
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text:"检查项目"
                        ),
                        TextSpan(
                          text:  _checkItemErrorText,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        )]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      new Container(
                          height: 40,
                          width: 340,
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: new BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: new Container(
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.only(top: 7, bottom: 7),
                                decoration: new BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius:
                                  new BorderRadius.all(Radius.circular(25.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 300,
                                      child: Row(
                                          children: (this.selectedCheckItem.length>2?
                                          this.selectedCheckItem.sublist(0,2).toList():this.selectedCheckItem).map((f){
                                            return Text(f.name + ";");
                                          }).toList()
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                                      color:  Color.fromRGBO(209, 6, 24, 1),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (null == selectedCheckItem ||
                                    selectedCheckItem.length <= 0) {
                                  // 去添加节点页面
                                  Navigator.push(context,
                                      new MaterialPageRoute(builder: (context) {
                                        return new CheckItemList(new List());
                                      })).then((data) {
                                    setState(() {
                                      selectedCheckItem =
                                      null != data ? data : new List();
                                    });
                                    _checkItemValidation();
                                  });
                                } else {
                                  // 去节点维护页面
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CheckItemSet(this.selectedCheckItem)),
                                  ).then((data) {
                                    setState(() {
                                      selectedCheckItem =
                                      null != data ? data : new List();
                                    });
                                    _checkItemValidation();
                                  });
                                }
                              },
                            ),
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      Text("备注说明"),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      new Container(
                          height: 40,
                          width: 340,
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: new BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: new Container(
                            child: TextField(
                              controller: _noteController,
                              autofocus: false,
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  // 编辑事件赋值
                                  movePoint.remark = val;
                                });
                              },
                            ),
                          )),
                    ],
                  );
                },
              )),
          persistentFooterButtons: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 170,
                  height: 50,
                  color: Color.fromRGBO(242, 246, 249, 1),
                  child: MaterialButton(
                      onPressed: () {
                        if(isSaving){
                          return;
                        }
                        setState(() {
                          _noController.text = "";
                          _nameController.text = "";
                          // 清空检查项
                          this.selectedCheckItem = new List();
                          _noteController.text = "";
                        });
                      },
                      child: Text("重置",
                          style: TextStyle(color: Colors.black, fontSize: 18))),
                ),
                Container(
                  width: 170,
                  height: 50,
                  color:  Color.fromRGBO(209, 6, 24, 1),
                  child: MaterialButton(
                    onPressed: (){
                      if(isSaving){
                        return;
                      }
                      saveMovePoint();
                    },
                    child: Text("确定",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                )
              ],
            )
          ],
          resizeToAvoidBottomPadding: false,
        )
    );
  }
}
