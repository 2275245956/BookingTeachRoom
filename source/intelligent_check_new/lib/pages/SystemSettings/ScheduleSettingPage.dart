import 'dart:convert' show json;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intelligent_check_new/pages/navigation_keep_alive.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ScheduleSettingPage extends StatefulWidget {
  ScheduleSettingPage({Key key}) : super(key: key);


  @override
  _ScheduleSettingPage createState() => new _ScheduleSettingPage();
}

class _ScheduleSettingPage extends State<ScheduleSettingPage> {
  // 当前点的附件
  bool isAnimating = false;
  bool canOperate=true;

  @override
  Widget build(BuildContext context) {

    return  WillPopScope(child:  Scaffold(
      appBar: AppBar(
        title: Text("作息时间设置",style: TextStyle(color: Colors.black,fontSize: 19,),),

        centerTitle: true,
        elevation: 0.2,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading:new Container(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child:Icon(Icons.keyboard_arrow_left, color:Color.fromRGBO(50, 89, 206, 1) /*Color.fromRGBO(209, 6, 24, 1)*/, size: 32),
          ),
        ),
      ),
      body:ModalProgressHUD(

        child:  SingleChildScrollView(

          child: Container(

            color: Colors.white,
            child: Column(
              children: <Widget>[
                /// 隐患地点
                Row(
                  children: <Widget>[
                    Expanded(
                      child:Container(
                        padding: EdgeInsets.only(left:20,top:10,bottom: 5),
                        width: MediaQuery.of(context).size.width-50,
                        child:Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("*",style: TextStyle(color: Colors.red),),
                                flex:0,
                              ),
                              Expanded(
                                child:Text("",style:  TextStyle(color: Colors.black,fontSize: 18,),),
                                flex: 19,
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width-50,
                            padding: EdgeInsets.only(top: 5,bottom:10,),
                            child:  Row(

                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    autofocus:false,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 10),
                                      border: InputBorder.none,
                                      hintText: "请输入隐患地点",
                                      filled: true,
                                      fillColor:Color.fromRGBO(244, 244, 244, 1),
                                    ),
                                    onEditingComplete: (){
                                      //print(this._controller.text);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],),
                      ),),
                  ],
                ),

                ///隐患名称
                Row(
                  children: <Widget>[
                    Expanded(
                      child:Container(
                        padding: EdgeInsets.only(left:20,top:10,bottom: 5),
                        width: MediaQuery.of(context).size.width-50,
                        child:Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("*",style: TextStyle(color: Colors.red),),
                                flex:0,
                              ),
                              Expanded(
                                child:Text("隐患名称",style: TextStyle(color: Colors.black,fontSize: 18,),),
                                flex: 19,
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width-50,
                            padding: EdgeInsets.only(top: 5,bottom: 10,),
                            child:  Row(

                              children: <Widget>[
                                Expanded(

                                  child: TextField(
                                    autofocus:false,

                                    enableInteractiveSelection: true,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 10),
                                      border: InputBorder.none,
                                      hintText: "请输入隐患名称",
                                      filled: true,
                                      fillColor:Color.fromRGBO(244, 244, 244, 1),
                                    ),
                                    onEditingComplete: (){
                                      //print(this._controller.text);
                                    },
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ],),
                      ),),
                  ],
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
      persistentFooterButtons: <Widget>[


        Row(
          children: <Widget>[
            Container(

              width:  (MediaQuery.of(context).size.width/2)-16,
              height: 60,
              margin: EdgeInsets.only(left: 0),
              child:   new MaterialButton(
                color: Color.fromRGBO(242, 246, 249, 1),
                height: 60,

                textColor: Colors.black,
                child: new Text('重置',style: TextStyle(fontSize: 24),),
                onPressed: () {


                },
              ),
            ),

            Container(
              width:  (MediaQuery.of(context).size.width/2),
              child: new MaterialButton(

                color: Color.fromRGBO(50,89,206,1),
                height: 60,
                textColor: Colors.white,
                child: new Text('确定',style: TextStyle(fontSize: 24)),
                onPressed: () {


                },
              ),
            ),


          ],
        ),


      ],
      resizeToAvoidBottomPadding: false,
    ), onWillPop: ()
      => Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (context) => NavigationKeepAlive()),
              (route) => route == null),

    );
  }
}




