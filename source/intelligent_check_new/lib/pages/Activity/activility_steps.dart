import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/Activility/ActivilityModel.dart';
import 'package:intelligent_check_new/model/Activility/ActivilityStepModel.dart';
import 'package:intelligent_check_new/services/Activility_services.dart';

import 'package:intelligent_check_new/services/check_point_service.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';

class ActivilitySteps extends StatefulWidget {
  final ActivilityModel _activility;
  ActivilitySteps(this._activility);

  @override
  State<StatefulWidget> createState() {
    return _ActivilitySteps();
  }
}

class _ActivilitySteps extends State<ActivilitySteps> {


  String strRouts = "";
  String strClassify = "";
  String permissionList = "";
  String theme = "red";
  List<StepModel> steps;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async{

    await getStepsAllInfo(this.widget._activility.id).then((data){
      setState(() {
         if(data.success && data.dataList!=null){
           steps=new List();
            for(var step in data.dataList["taskworkContents"]){
              steps.add(StepModel.fromJson(step));
            }
         }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(steps==null){
      return WillPopScope(
        child:Scaffold(
          appBar: AppBar(
            title: Text("步骤清单",style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w500 ),),
            centerTitle: true,
            elevation: 0.2,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            leading:new Container(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child:Icon(Icons.keyboard_arrow_left, color: Color.fromRGBO(209, 6, 24, 1), size: 32),
              ),
            ),
          ),
        ),
        onWillPop: (){
          Navigator.pop(context);
        },
      );
    }
    return WillPopScope(
      child:Scaffold(
        backgroundColor: Colors.white,
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
                  color: Color.fromRGBO(209, 6, 24, 1), size: 32),
            ),
          ),
        ),
        body: SingleChildScrollView(
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
                          this.widget._activility.taskworkName??"--" ,
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
                      child: Text(this.widget._activility.levelDesc??"--"),
                    )
                  ],
                ),
                // Divider(),
                //所属部门/车间
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
                      child: Text(this.widget._activility.applyDateTime??"--"),
                    ),
                  ],
                ),
                //分割线
                Container(
                  color: Color.fromRGBO(242, 246, 249, 1),
                  height: 10,
                ),


                this.steps!=null?Column(
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
                        children:this.steps.map((s){
                          return  Container(
                              padding: EdgeInsets.only(left: 20, top: 10,bottom: 5),
                              width: MediaQuery.of(context).size.width,

                              child: GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        (s.serialNum.toString()+"."+(s.taskworkContentName ?? "--")),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      flex: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        s.taskworkLevel??"--级",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: new Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Color.fromRGBO(209, 6, 24, 1),
                                        size: 25,
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                                onTap: () {


                                },
                              ));
                        }).toList(),
                      ),
                    ),
                  ],
                ):Container(),

                Container(
                  color: Color.fromRGBO(242, 246, 249, 1),
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: (){
        Navigator.pop(context);
      },
    );
  }


}
