import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/RoomModel.dart';
import 'package:intelligent_check_new/services/SystemService/SystemConfigService.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:flutter/cupertino.dart';

class LamsTextControler {
  TextEditingController rNumber = new TextEditingController();
  TextEditingController rName = new TextEditingController();
  TextEditingController rMaxPre = new TextEditingController();
  TextEditingController rPlace = new TextEditingController();
  bool isUserful = true;
}

class LambsAdd_EditPage extends StatefulWidget {
  final String opType;
  final RoomModel room;

  LambsAdd_EditPage(this.opType, this.room);

  @override
  _LambsAdd_EditPage createState() => new _LambsAdd_EditPage();
}

class _LambsAdd_EditPage extends State<LambsAdd_EditPage> {
  bool isAnimating = false;
  bool canOperate = true;
  String theme = "red";
  LamsTextControler cons = new LamsTextControler();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData(){
    setState(() {
      if(this.widget.opType=="edit"){
        cons.isUserful=this.widget.room.attriText01=='1';
        cons.rPlace.text=this.widget.room.attriText02;
        cons.rNumber.text=this.widget.room.rNumber;
        cons.rMaxPre.text=this.widget.room.rMaxPer.toString();
        cons.rName.text=this.widget.room.rName;
      }
    });
  }

  void SaveInfo() async {
    /*======================checkdata===========================*/
    if( this.cons.rName.text=="" ||
        this.cons.rNumber.text==""||
        this.cons.rPlace.text==""||
        this.cons.rMaxPre.text==""
      ){
      GetConfig.popUpMsg("请填写完整数据!");
      return;
    }
    /*===========================================================*/




    if(this.widget.opType=="add"){
      var jsonData=
      {
        "rMaxPer":cons.rMaxPre.text,
        "rName": cons.rName.text,
        "rNumber":cons.rNumber.text,
        "attriText02": cons.rPlace.text,
        "attriText01": cons.isUserful ? 1 : 0,
      };
      var data=await AddLamb(jsonData);
      if(data.success){
        GetConfig.popUpMsg(data.message??"操作成功");
        Navigator.pop(context,true);
      }else{
        GetConfig.popUpMsg(data.message??"操作失败");
      }
    }else if(this.widget.opType=="edit"){
      var jsonData=
      {
        "rMaxPer":cons.rMaxPre.text,
        "id":this.widget.room.id,
        "rName": cons.rName.text,
        "rNumber":cons.rNumber.text,
        "attriText02": cons.rPlace.text,
        "attriText01": cons.isUserful ? 1 : 0,
      };
      var data=await  UpLambInfo(jsonData);
      if(data.success){
        GetConfig.popUpMsg(data.message??"操作成功");
        Navigator.pop(context,true);
      }else{
        GetConfig.popUpMsg(data.message??"操作失败");
      }
    }else{
      return ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "实验室${this.widget.opType != "add" ? '信息修改' : '添加'}",
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
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Text(
                          "教室编号",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          textInputAction: TextInputAction.done,
                          controller: cons.rNumber,
                          maxLines: 1,
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
                            hintText: "请输入",
                            filled: true,
                            fillColor: Color.fromRGBO(244, 244, 244, 1),
                          ),
                        ))
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Text(
                          "教室名称",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          textInputAction: TextInputAction.done,
                          controller: cons.rName,
                          maxLines: 1,
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
                            hintText: "请输入",
                            filled: true,
                            fillColor: Color.fromRGBO(244, 244, 244, 1),
                          ),
                        ))
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Text(
                          "教室人数",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: TextField(
                          inputFormatters: [
                            WhitelistingTextInputFormatter(
                                RegExp("[0-9]")), //数字
                          ],
                          style: TextStyle(fontSize: 18),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          controller: cons.rMaxPre,
                          maxLines: 1,
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
                            hintText: "请输入",
                            filled: true,
                            fillColor: Color.fromRGBO(244, 244, 244, 1),
                          ),
                        ))
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Text(
                          "教室位置",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          textInputAction: TextInputAction.done,
                          controller: cons.rPlace,
                          maxLines: 1,
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
                            hintText: "请输入",
                            filled: true,
                            fillColor: Color.fromRGBO(244, 244, 244, 1),
                          ),
                        ))
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Text(
                          "是否可用",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: CupertinoSwitch(
                        value: cons.isUserful,
                        onChanged: (bool value) {
                          setState(() {
                            cons.isUserful = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ),
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
                  setState(() {
                    cons.isUserful=true;
                    cons.rPlace.text="";
                    cons.rNumber.text='';
                    cons.rMaxPre.text="";
                    cons.rName.text="";
                  });
                },
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width / 2),
              child: new MaterialButton(
                color: GetConfig.getColor(theme),
                height: 60,
                textColor: Colors.white,
                child: new Text('提交', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  GetConfig.IOSPopMsg("提示", Text("确认无误后点击确定提交！"), context,
                      confirmFun: SaveInfo);
                },
              ),
            ),
          ],
        ),
      ],
      resizeToAvoidBottomPadding: true,
    );
  }
}
