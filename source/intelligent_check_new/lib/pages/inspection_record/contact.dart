//import 'package:flutter/material.dart';
//import 'package:intelligent_check_new/constants/color.dart';
//import 'package:intelligent_check_new/model/CheckExecute/ContactInfo.dart';
//import 'package:intelligent_check_new/model/name_value.dart';
//import 'package:intelligent_check_new/services/company_services.dart';
//import 'package:intelligent_check_new/tools/GetConfig.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:flutter_easyrefresh/easy_refresh.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:convert' show json;
//
//
//class Contact extends StatefulWidget{
//
//
//
//  @override
//  State<StatefulWidget> createState() {
//    return new _ContactState();
//  }
//}
//
//class _ContactState extends State<Contact>{
//  bool isAnimating = false;
//  int pageIndex=1;
//  bool hasNext=true;
//  List<ContractInfo> pageData = List();
//  List<ContractInfo> tmpData = List();
//
//  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
//  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
//  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
//  FocusNode _focusNode = new FocusNode();
//  final TextEditingController _controller = new TextEditingController();
//
//  String theme="blue";
//
//  @override
//  Widget build(BuildContext context) {
//    if(this.theme.isEmpty){
//      return Scaffold(
//          body:Text("")
//      );
//    }
//    return Scaffold(
//        appBar: AppBar(
//          elevation: 0.3,
//          brightness: Brightness.light,
//          backgroundColor:  Color(0xFFFFFFFF),
//          leading:new Container(
//            child: GestureDetector(
//              onTap: () {
//                _focusNode.unfocus();
//                Navigator.pop(context);
//              },
//              child:Icon(Icons.keyboard_arrow_left, color: GetConfig.getColor(theme), size: 32),
//            ),
//          ),
//          title:new  Container(
//              height: 30,
//              width: 250,
//              padding: EdgeInsets.only(bottom: 5),
//              decoration: new BoxDecoration(
//                color: Colors.grey[100],
//                borderRadius: new BorderRadius.all(Radius.circular(25.0)),
//              ),
//              child: Row(
//                children: <Widget>[
//                  Container(
//                    padding: EdgeInsets.only(left: 5,right: 5,top:6),
//                    child: Image.asset("assets/images/search_"+theme+".png",width: 20,color: Colors.black26),
//                  ),
//                  Container(
//                    width: 190,
//                    child: TextField(
//                        controller: _controller,
//                        autofocus: false,
//                        focusNode: _focusNode,
//                        style: TextStyle(fontSize: 16.0, color: Colors.black),
//                        decoration: new InputDecoration(
//                          border: InputBorder.none,
//                            contentPadding:EdgeInsets.only(top: 8)
//                        )
//                    ),
//                  )
//                ],
//              )
//          ),
//          actions: <Widget>[
//            Align(
//                child:Padding(padding: EdgeInsets.only(right: 8),
//                  child: GestureDetector(
//                    onTap: () {
//                      setState(() {
//                        if(this._controller.text.isEmpty){
//                          pageData = tmpData;
//                        }else{
////                          pageData = tmpData.where((f)=>f.children..indexOf(this._controller.text) != -1).toList();
//                          pageData = [];
//                          tmpData.forEach((f){
//                            ContractInfo _contractInfo = ContractInfo.fromParams(id:f.id,name: f.name );
//                            _contractInfo.children = f.children != null && f.children.length>0?
//                              f.children.where((d)=>d.label.indexOf(this._controller.text) != -1).toList()
//                              :List();
//                            pageData.add(_contractInfo);
//                          });
//                        }
//                      });
//                    },
//                    child:Text("搜索",style: TextStyle(color: Colors.black26,fontSize: 16.0),),
//                  ),
//                )
//            )
//          ],
//        ),
//        body:  ModalProgressHUD(
//          child:Container(
//            color: Colors.white,
//            child:  new EasyRefresh(
//              key: _easyRefreshKey,
//              behavior: ScrollOverBehavior(),
//              refreshHeader: ClassicsHeader(
//                key: _headerKey,
//                bgColor: Colors.transparent,
//                textColor: Colors.black87,
//                moreInfoColor: Colors.black54,
//                showMore: true,
//              ),
//              refreshFooter: ClassicsFooter(
//                key: _footerKey,
//                bgColor: Colors.transparent,
//                textColor: Colors.black87,
//                moreInfoColor: Colors.black54,
//                showMore: true,
//              ),
//              child: new ListView.builder(
//                //ListView的Item
//                itemCount: 1,
//                itemBuilder: (BuildContext context, int index) {
//                  return Column(
//                    children: pageData.map((data){
//                      return Column(
//                        children: <Widget>[
//                          Container(
//                            width: double.infinity,
//                            color: Colors.white,
//                            height: 40,
//                            alignment: Alignment.centerLeft,
//                            padding: EdgeInsets.only(left: 15),
//                            child: Row(children: <Widget>[
//                              Text(data.name,style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),),
//                            ],),
//                          ),
//                          Container(
//                            color: Colors.grey[100],
//                            height: 1,
//                          ),
//
//                          Column(
//                            children: data.children.map((child){
//                              return Column(
//                                children: <Widget>[
//                                  new Container(
//                                      color: Colors.white,
//                                      height: 50.0,
//                                      margin: EdgeInsets.only(top: 10,left: 10,right: 10),
//                                      child: new ListTile(
//                                          isThreeLine: false,
//                                          dense: false,
//                                          subtitle: new Row(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: <Widget>[
//
//                                              new CircleAvatar(child: Text(child.label[0])),
//                                              Padding(padding: EdgeInsets.only(right: 5),),
//                                              new Column(
//                                                crossAxisAlignment: CrossAxisAlignment.center,
//                                                mainAxisAlignment: MainAxisAlignment.start,
//                                                children: <Widget>[
//                                                  Padding(padding: EdgeInsets.only(top: 5),),
//                                                  new Text(child.label,style: new TextStyle(fontSize: 17.0,fontWeight: FontWeight.w500),),
//                                                ],
//                                              ),
//                                            ],
//                                          ),
////                                          trailing: new Icon(Icons.keyboard_arrow_right),
//                                          onTap: (){
//
//                                            Navigator.pop(context,NameValue(child.label, num.tryParse(child.id)));
//                                          }
//                                      )
//                                  ),
//                                  Divider(height: 1,),
//                                ],
//                              );
//                            }).toList(),
//                          )
//                        ],
//                      );
//                    }).toList()
//                  );
//                },
//              ),
//              onRefresh: () async {
//                await new Future.delayed(const Duration(seconds: 1), () {
//                  setState(() {
////                  pageIndex = 1;
////                  initData = [];
//                  });
////                getData();
//                });
//              },
//              loadMore: () async {
//                await new Future.delayed(const Duration(seconds: 1), () {
//                  if(hasNext){
//                    setState(() {
////                    pageIndex = pageIndex + 1;
//                    });
////                  getData();
//                  }
//                });
//              },
//            ),
//          ),
//          inAsyncCall: isAnimating,
//          // demo of some additional parameters
//          opacity: 0.7,
//          progressIndicator: CircularProgressIndicator(),
////          content: '加载中...',
//        )
//    );
//  }
//
//  @override
//  void initState(){
//    super.initState();
//
//    getData();
//
//    initConfig();
//  }
//
//  getData() async{
//    String orgCode="";
//    await SharedPreferences.getInstance().then((sp) {
//      orgCode= json.decode(sp.getString("sel_com"))["sequenceNbr"].toString();}).then((data){
//      getContractInfo(orgCode).then((data){
//        setState(() {
//          pageData  = data;
//          tmpData = data;
//        });
//      });
//    });
//
//  }
//
//  initConfig() async{
//    SharedPreferences.getInstance().then((preferences){
//      setState(() {
//        this.theme = preferences.getString("theme")??KColorConstant.DEFAULT_COLOR;
//      });
//    });
//  }
//}

import 'dart:convert';

import 'package:flutter/material.dart';
import  'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:intelligent_check_new/model/CheckExecute/ContactInfo.dart';
import 'package:intelligent_check_new/model/LoginResult.dart';
import 'package:intelligent_check_new/model/name_value.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/MultySelectContract.dart';
import 'package:intelligent_check_new/pages/my/contact/contactinfo.dart';
import 'package:intelligent_check_new/services/company_services.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/widget/touch_callback.dart';
import 'package:intelligent_check_new/pages/my/contact/contacetexpand_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contact extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<Contact>
/*with AutomaticKeepAliveClientMixin*/ {

  List<ContractInfo> pageData = List();
  List<ContractInfo> tmpData = List();
  LoginResult loginResult;

  ScrollController _scrollController = ScrollController();
  var  companyName;

  getUserInfo()  {
    SharedPreferences.getInstance().then((sp){
      String str= sp.get('LoginResult');
      setState(() {
        loginResult = LoginResult(str);
        this.theme = sp.getString("theme")??KColorConstant.DEFAULT_COLOR;
      });
      getData();
    });
  }

  @override
  void initState() {
    super.initState();

    getUserInfo();
  }

  getData() async{
    String orgCode="";
    await   SharedPreferences.getInstance().then((sp) {
      companyName=json.decode(sp.getString("sel_com"))["companyName"];

      orgCode= json.decode(sp.getString("sel_com"))["sequenceNbr"].toString();}).then((data){
      getContractInfo(orgCode).then((data){
        setState(() {
          pageData  = data;
          tmpData = data;
        });
      });
    });

  }

  final TextEditingController _controller = new TextEditingController();
  String theme="blue";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        appBar: AppBar(
          title: Text("巡检人员列表",style: TextStyle(color: Colors.black,fontSize: 19,),),

          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading:new Container(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child:Icon(Icons.keyboard_arrow_left, color:Color.fromRGBO(50, 89, 206, 1) /*GetConfig.getColor(theme)*/, size: 32),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15.0),
                  height: 50.0,
                  color: Colors.white,
                  child: new Row(
                    children: <Widget>[
                      Text(
                        companyName== null?"": companyName,
                        style: TextStyle(color: Colors.grey,fontSize: 19),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    height: 0.5,
                    //                color: Colors.grey,
                  ),
                ),
                Container(
                  child:ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: pageData.length,
                    itemBuilder:(BuildContext context,int index) => CompanyContects(pageData[index]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),


              ],
            )));
  }
}


class CompanyContects extends StatefulWidget {

  var bean;
  CompanyContects(this.bean);

  @override
  _CompanyContects createState() => _CompanyContects();
}

class _CompanyContects extends State<CompanyContects> {

  @override
  Widget build(BuildContext context) {
    return ListTile(

      title: _buildItem(widget.bean),
    );
  }

  Widget _buildItem(var bean){


    if(bean.children.isEmpty && bean.parentId!="0") {
      return Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 40.0,bottom: 10),
            child:CircleAvatar(
              backgroundColor:Colors.blue,
              child: Text(bean.name.substring(0,1),style: TextStyle(color: Colors.white),),
            ),
          ),

          GestureDetector(
              child:
              Container(
                margin: const EdgeInsets.only(left: 20.0,bottom: 10),
                child: Text(bean.name,style: TextStyle(color: Colors.black),),
              ),
              onTap:  (){
                Navigator.pop(context,NameValue(bean.name, num.tryParse(bean.id)));
              }
          ),
        ],

      );
    }
    return ExpansionTile(
      // key: PageStorageKey<NameBean>(bean),
      title: Text(bean.name),
      children: bean.children.map<Widget>(_buildItem).toList(),
      leading: CircleAvatar(
        backgroundColor:Colors.green,
        child: Text(bean.name.substring(0,1),style: TextStyle(color: Colors.white),),
      ),
    );
  }

}

