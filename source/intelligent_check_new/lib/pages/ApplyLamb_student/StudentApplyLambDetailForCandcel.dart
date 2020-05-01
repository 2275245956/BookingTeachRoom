import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/ExperimentModel.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/StuApplyLamModel.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/TeacherApplyRecord.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/pages/navigation_keep_alive.dart';
import 'package:intelligent_check_new/services/StudentServices/StudentOperate.dart';
import 'package:intelligent_check_new/services/TeacherServices/TechServices.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentApplyLambDetailForCancel extends StatefulWidget {
  final StuApplyModel recordInfo;

  StudentApplyLambDetailForCancel(this.recordInfo);

  @override
  _ApplyLambDetail createState() => new _ApplyLambDetail(recordInfo);
}

class _ApplyLambDetail extends State<StudentApplyLambDetailForCancel> {
  StuApplyModel expStuModel;
 ExpModel expModel;
  _ApplyLambDetail( this.expStuModel);
  bool isAnimating = false;
  bool canOperate = true;
  String theme = "red";
  UserModel userInfo;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }
  void _CancelApplyStu() async{
   var res= await StudentCancelApply(expStuModel.reqNumber);
  if(res.success){
    GetConfig.popUpMsg(res.message??"操作成功！");
    Navigator.pop(context);
    return;
  }
  Navigator.pop(context);
  }

  void initData() async {
   var sp= await SharedPreferences.getInstance();
   setState(() {
        if (sp.getString("userModel") != null) {
          userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
        }
      });

   await GetExpModdel(this.widget.recordInfo.attriText01).then((data){
     var list=new List();
     if(data.success && data.dataList!=null && data.dataList.length>0){
       setState(() {
         for(var str in data.dataList){
           list.add(ExpModel.fromJson((str)));
         }
         if(list.length>0){
           expModel=list[0];
           expModel.eDate=list[list.length-1].eDate;
         }
       });

     }
   });



  }

  @override
  Widget build(BuildContext context) {
    if (userInfo != null && this.widget.recordInfo != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "实验信息",
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
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_left,
                  color: GetConfig.getColor(
                      theme) /*Color.fromRGBO(209, 6, 24, 1)*/,
                  size: 32),
            ),
          ),
        ),
        body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
            key: _formKey,
            child: new SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "教师名称",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${expStuModel.eTName}",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "开始时间",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${DateFormat("yyyy年MM月dd日（EEEE）","zh").format(DateTime.parse(expStuModel.eStarttime))}",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "结束时间",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "${DateFormat("yyyy年MM月dd日（EEEE）","zh").format(DateTime.parse(expStuModel.eEndtime))}",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),

                  Container(
                    color: Color.fromRGBO(242, 246, 249, 1),
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "实验名称",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.only(top: 5, bottom: 5, right: 10),
                          child: Text(
                            "${expStuModel.eName}",
                            style: TextStyle(
                                color: GetConfig.getColor(theme), fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            "备注",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 100.0,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.only(top: 5, bottom: 5, right: 10),
                          child: TextField(
                            autofocus: false,
                            style: TextStyle(fontSize: 18),
                            controller: TextEditingController(
                                text: expStuModel.remark),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              enabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5), //边角为30
                                ),
                                borderSide: BorderSide(
                                  color: GetConfig.getColor(theme),
                                  //边线颜色为黄色
                                  width: 2, //边线宽度为2
                                ),
                              ),
                              hintText: "",
                              filled: true,
                              fillColor: Color.fromRGBO(244, 244, 244, 1),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        persistentFooterButtons: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width - 16),
                child: new MaterialButton(
                  color: expStuModel.status=="申请通过(教师)"?Colors.grey:GetConfig.getColor(theme),
                  height: 60,
                  textColor: Colors.white,
                  child: new Text('取消申请', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    if( expStuModel.status=="申请通过(教师)" ||  expStuModel.status=="申请通过(教师)"){
                      GetConfig.IOSPopMsg("提示！", Text("您已存在已申请或者已通过审核的记录，不能重复申请！"), context);
                    } else{
                      GetConfig.IOSPopMsg("提示！", Text("是否确认该操作？"), context,
                          confirmFun: _CancelApplyStu);
                    }
                  },
                ),
              ),
            ],
          )
        ],
        resizeToAvoidBottomPadding: true,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "实验信息",
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
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_left,
                color:
                    GetConfig.getColor(theme) /*Color.fromRGBO(209, 6, 24, 1)*/,
                size: 32),
          ),
        ),
      ),
    );
  }
}
