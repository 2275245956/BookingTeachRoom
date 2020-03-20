import 'dart:convert' show json;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intelligent_check_new/model/MovePointAttachment.dart';
import 'package:intelligent_check_new/pages/CheckExecute/ImageList.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/MultySelectContract.dart';
import 'package:intelligent_check_new/pages/inspection_record/contact.dart';
import 'package:intelligent_check_new/services/HiddenDanger.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/tools/MessageBox.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class  HideDanger{
  TextEditingController dangerPlace=new TextEditingController();//隐患地点
  TextEditingController dangerName=new TextEditingController();//隐患名称
  num dangerLevel=0;//隐患等级   1 一般隐患  2重大隐患
  TextEditingController remark=new TextEditingController();//备注信息
  TextEditingController limitDate=new  TextEditingController();//治理时间
  String reviewUserIds;//评审人id
  TextEditingController reviewUserName=new TextEditingController();//评审人
  int reviewDeptIds;//评审部门id
  TextEditingController reviewDeptName=new TextEditingController();//评审部门
  String photoUrls="";
}


class HiddenDangerFound extends StatefulWidget {
  HiddenDangerFound({Key key}) : super(key: key);
  @override
  _HiddenDangerFound createState() => new _HiddenDangerFound();
}

class _HiddenDangerFound extends State<HiddenDangerFound> {
  // Default placeholder text
  // var radioValue=0;
  HideDanger hidedanger=new HideDanger();

  FocusNode _focusNode = new FocusNode();
  // 当前点的附件
  List<File> imageList;
  bool isAnimating = false;
  bool canOperate=true;
  _saveHideDangerInfo(HideDanger jsonStr) async{
    setState(() {
      isAnimating = true;
      canOperate=false;
    });

    await saveHideDangerInfo(jsonStr).then((data){
      setState(() {

        if(data){
          GetConfig.popUpMsg("隐患添加成功!");

          reSetValue();//重置数据
          Navigator.pop(context);

        }else{
          GetConfig.popUpMsg("隐患添加失败!");
        }
        isAnimating = false;
        canOperate=true;
      });
    });
  }

  _upDateImg(List<Attachment> att) async{
    setState(() {
      isAnimating = true;
      canOperate=false;
    });
    var bizCode="latent_danger";
    await updataImg(att,bizCode).then((data){
      if(mounted){
        setState(() {
          if(data.success){
            hidedanger.photoUrls=data.message;
            GetConfig.popUpMsg("图片上传成功!");
          }else{
            GetConfig.popUpMsg(data.message);
          }

          isAnimating = false;
          canOperate=true;

        });
      }

    });
  }

  reSetValue() async{
    setState(() {
      hidedanger.reviewUserIds="";
      hidedanger.reviewUserName.text="";
      hidedanger.reviewDeptIds=0;
      hidedanger.reviewDeptName.text="";
      hidedanger.dangerName.text="";
      hidedanger.dangerLevel=0;
      hidedanger.dangerPlace.text="";
      hidedanger.remark.text="";
      hidedanger.limitDate.text="";
      hidedanger.photoUrls="";
      imageList=[];
    });
  }

  bool _checkNeed() {

    if(hidedanger.dangerPlace.text==null || hidedanger.dangerPlace.text==""){
      GetConfig.popUpMsg("请填写隐患地点！");
      return false;
    }
    if(hidedanger.dangerName.text==null || hidedanger.dangerName.text==""){
      GetConfig.popUpMsg("请填写隐患名称！");
      return false;
    }
//    if(imageList==[] || imageList==null){
//      GetConfig.popUpMsg("请上传隐患图片");
//      return false;
//    }
    return true;
  }



  // final TextEditingController _controller = new TextEditingController();
  //List<String> reviewNotes = List();
//  List<TextEditingController> controllers = List();
  // Map<String,TextEditingController> controllers = Map();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("发现隐患",style: TextStyle(color: Colors.black,fontSize: 19,),),

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
                                child:Text("隐患地点",style:  TextStyle(color: Colors.black,fontSize: 18,),),
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
                                    focusNode: _focusNode,
                                    autofocus:false,
                                    controller: hidedanger.dangerPlace,
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
                                    controller: hidedanger.dangerName,
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
                ///隐患等级
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
                                child:Text("隐患等级",style:TextStyle(color: Colors.black,fontSize: 18,),),
                                flex: 19,
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width-20,
                            padding: EdgeInsets.only(top: 5,bottom: 5,),
                            child:  Row(

                              children: <Widget>[
                                Expanded(
                                    child:Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                flex:5 ,
                                                child:RadioListTile(
                                                    title: Text("一般隐患"),
                                                    value: 1,
                                                    groupValue: hidedanger.dangerLevel,
                                                    onChanged: (value){
                                                      setState(() {
                                                        print(value);
                                                        hidedanger.dangerLevel = value;
                                                      });
                                                    }
                                                ),
                                                //带文字的单选按钮 value值=groupValue值 即选中状态


                                              ), Expanded(
                                                flex:5 ,
                                                child:RadioListTile(
                                                    title: Text("重大隐患"),
                                                    value: 2,
                                                    groupValue: hidedanger.dangerLevel,
                                                    onChanged: (value){
                                                      setState(() {
                                                        print(value);
                                                        hidedanger.dangerLevel = value;
                                                      });
                                                    }
                                                ),
                                                //带文字的单选按钮 value值=groupValue值 即选中状态


                                              ),
                                            ],
                                          ),
                                          flex: 3,
                                        ),


                                      ],
                                    )

                                ),
                              ],
                            ),
                          ),
                        ],),
                      ),),
                  ],
                ),


                /// 备注
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
                                child:Text("备注",style: TextStyle(color: Colors.black,fontSize: 18,),),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width-50,
                            height: 100,
                            margin: EdgeInsets.only(top:30),
                            decoration: new BoxDecoration(
                                color:Color.fromRGBO(244, 244, 244, 1)
                            ),
                            child: TextField(
                              autofocus:false,

                              controller: hidedanger.remark,
                              enableInteractiveSelection: true,
                              maxLines: null,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 10),
                                border: InputBorder.none,
                                hintText: "请输入备注信息",
                                filled: true,
                                fillColor:Color.fromRGBO(244, 244, 244, 1),
                              ),
                              onEditingComplete: (){
                              },
                            ),

                          ),
                        ],),
                      ),),
                  ],
                ),
                ///拍照取证
                ///
                Container(
                  child:     GestureDetector(
                    child:   Row(
                      children: <Widget>[
                        Expanded(flex: 10,
                          child:Container(

                            padding: EdgeInsets.only(left: 20,top:10,bottom: 10),

                            height:80,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
//                            Expanded(
//                              child: Text("*",style: TextStyle(color: Colors.red),),
//                              flex: 0,
//                            ),
                                Expanded(
                                  child:Text("拍照取证",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: 18,),),
                                  flex: 9,
                                ),
                              ],),
                          ),),
                        Expanded(
                          flex: 0,
                          child:Container(
                            child:Icon(Icons.photo_camera,color:Color.fromRGBO(50, 89, 206, 1),size: 22,),

                          ),
                        ),

                        Expanded(
                          flex:1,
                          child:Container(
                            child:GestureDetector(
                              //50  89  206
                              child: Icon(Icons.keyboard_arrow_right,color:Color.fromRGBO(50, 89, 206, 1),size: 22,),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:(context){
                                  return ImageList(this.imageList);
                                })).then((v){
                                  if(v!=null){
                                    setState(() {
                                      imageList = v;
                                      List<Attachment> fileData =  new List();
                                      if(null != this.imageList && this.imageList.length > 0){
                                        this.imageList.forEach((f){
                                          fileData.add(Attachment.fromParams(file: f));
                                        });
                                        //保存图片
                                        _upDateImg(fileData);
                                      }
                                    });
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context){
                        return ImageList(this.imageList);
                      })).then((v){
                        if(v!=null){
                          setState(() {
                            imageList = v;
                            List<Attachment> fileData =  new List();
                            if(null != this.imageList && this.imageList.length > 0){
                              this.imageList.forEach((f){
                                fileData.add(Attachment.fromParams(file: f));
                              });
                              //保存图片
                              _upDateImg(fileData);
                            }
                          });
                        }
                      });
                    },
                  ),
                )





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
                  if(canOperate){
                    reSetValue();
                  }else{
                    GetConfig.popUpMsg("网速较慢！请等待图片上传完成");
                  }

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
                  //必填项判断
                  if(canOperate){
                    if(_checkNeed()){
                      _saveHideDangerInfo(hidedanger);
                    }
                  }else{
                    GetConfig.popUpMsg("正在执行操作！请稍等...");
                  }

                },
              ),
            ),


          ],
        ),


      ],
      resizeToAvoidBottomPadding: false,
    );
  }
}




