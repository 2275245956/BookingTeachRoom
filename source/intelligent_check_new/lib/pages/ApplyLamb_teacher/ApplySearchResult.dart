import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/ExperimentModel.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/TeacherApplyRecord.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/ApplyLambDetail.dart';
import 'package:intelligent_check_new/services/TeacherServices/TechServices.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApplySearchResultPage extends StatefulWidget{

  final String searchText;
  final bool isHandle;
  ApplySearchResultPage(this.searchText,this.isHandle);

  @override
  State<StatefulWidget> createState() => new _ApplySearchResultPage();
}

class _ApplySearchResultPage extends State<ApplySearchResultPage>{


  @override
  bool get wantKeepAlive => true;

  bool isAnimating = false;

  String myUserId;
  UserModel userInfo;
  String theme="red";
  FocusNode _focusNode = new FocusNode();
  // 当前页码
  // 当前页码
  int pageNum = 1;
  int pageSize = 10;
  // 是否有下一页
  bool hasNext=true;
  // 分页所需控件
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  List<ExpModel> initRecordData=new List() ;



  initConfig() async{
    SharedPreferences.getInstance().then((sp){
      setState(() {
        this.theme = sp.getString("theme")??KColorConstant.DEFAULT_COLOR;
        if (sp.getString("userModel") != null) {
          userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
        }
      });
    }).then((data){

      loadData();
    });
  }
  void loadData () async{
      var data= await GetAllRecordByKeywords(userInfo.account,this.widget.searchText,pageNum);
      if(data.success && data.dataList!=""){
        for(var str in data.dataList){
          setState(() {
            initRecordData.add(new ExpModel.fromJson(str));
          });
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    if(initRecordData==null || initRecordData.length==0){
      return Scaffold(
        backgroundColor: Color.fromRGBO(240, 243, 245, 1),
        appBar: AppBar(
            elevation: 0.2,
            brightness: Brightness.light,
            backgroundColor:  Color(0xFFFFFFFF),
            leading:new Container(
              child: GestureDetector(
                onTap: () {
                  _focusNode.unfocus();
                  Navigator.pop(context);
                },
                child:Icon(Icons.keyboard_arrow_left, color: Color.fromRGBO(209, 6, 24, 1), size: 32),
              ),
            ),
            title:InkWell(
              child: Container(
                height: 30,
                padding: EdgeInsets.only(top: 7,bottom: 6),
                decoration: new BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0,left: 10.0,top: 2),
                      child: Image.asset("assets/images/search_"+theme+".png",width: 14,color: Color(0xFF999999)),
                    ),
                    Text(this.widget.searchText, style: TextStyle(fontSize: 14.0,color: Color(0xFF999999))),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
        ),
//      ),
        body:Container(),
        resizeToAvoidBottomPadding: false,
      );
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 243, 245, 1),
      appBar: AppBar(
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor:  Color(0xFFFFFFFF),
          leading:new Container(
            child: GestureDetector(
              onTap: () {
                _focusNode.unfocus();
                Navigator.pop(context);
              },
              child:Icon(Icons.keyboard_arrow_left, color: Color.fromRGBO(209, 6, 24, 1), size: 32),
            ),
          ),
          title:InkWell(
            child: Container(
              height: 30,
              padding: EdgeInsets.only(top: 3,bottom:3),
              decoration: new BoxDecoration(
                color: Colors.grey[100],
                borderRadius: new BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0,left: 10.0,top: 2),
                    child: Image.asset("assets/images/search_"+theme+".png",width: 14,color: Color(0xFF999999)),
                  ),
                  Text(this.widget.searchText, style: TextStyle(fontSize: 14.0,color: Color(0xFF999999))),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
      ),
//      ),
      body:EasyRefresh(
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
        child:
        ListView.builder(
          //ListView的Item
          itemCount: initRecordData.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ApplyLambDetail(initRecordData[index]);
                  }));
                },
                child: Container(
                  child: Card(

                    elevation: 2,
                    margin: EdgeInsets.only(
                        top: 5, left: 3, right: 3),
                    child: new Container(
                        height: 125.0,
//                                          margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 8,
                              height: 125,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.only(
                                    topLeft: Radius
                                        .circular(4),
                                    bottomLeft:
                                    Radius.circular(
                                        4)),
                                color: getPointColor(initRecordData[index].status),
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
                                    "${index+1}.  ${initRecordData[index].eName}",
                                    style: new TextStyle(
                                        fontSize: 18.0,
                                        fontWeight:
                                        FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 5),
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
                                            color:
                                            Colors.grey,
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
                                        width: MediaQuery.of(context).size.width -50,
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
                                        color: GetConfig
                                            .getColor(theme),
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
                                            color:
                                            Colors.grey,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        "${initRecordData[index].status}",
                                        style: TextStyle(
                                            color:getPointColor(initRecordData[index].status),fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 5),
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
                                            color:
                                            Colors.grey,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        "${initRecordData[index].sDate} ~ ${initRecordData[index].eDate}",
                                        style: TextStyle(
                                            color:
                                            Colors.grey,
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
          await new Future.delayed(
              const Duration(seconds: 1), () {
            setState(() {
              pageNum = 0;
               initRecordData=[];
            });
             loadData();
          });
        },
        loadMore: () async {
          await new Future.delayed(
              const Duration(seconds: 1), () {
            if (hasNext) {
              setState(() {
                pageNum = pageNum + 1;
              });
              loadData();
            }
          });
        },
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
  Color getPointColor(String status){
    switch(status){
      case "申请提交(教师)":return Colors.orange;
      case "申请取消(教师)":return Colors.black;
      case "申请通过(管理员)":return Colors.green;
      case "申请退回(管理员)":return Colors.red;
      default:return Colors.grey;
    }
  }
  @override
  void initState() {
    super.initState();
    initConfig();
  }
}