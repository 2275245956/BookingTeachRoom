import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intelligent_check_new/constants/color.dart';
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

  String theme="red";
  FocusNode _focusNode = new FocusNode();
  // 当前页码
  int pageIndex=0;
  // 是否有下一页
  bool hasNext=false;
  // 分页所需控件
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();



  initConfig() async{
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        this.theme = preferences.getString("theme")??KColorConstant.DEFAULT_COLOR;
      });
    }).then((data){

      loadData();
    });
  }
  void loadData () async{

  }
  Color getLevelTextBgColor(int level)
  {
    if(level==1)
      return Colors.orange;
    if(level==2)
      return Colors.red;
    return Colors.black;
  }


  @override
  Widget build(BuildContext context) {
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
        new ListView.builder(
          //ListView的Item
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return  GestureDetector(
              onTap: (){

              },
              child: Container(
                height: 130.0,
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Card(
                    elevation:0.2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment
                                      .bottomCenter,
                                  child:Icon(Icons.android ,size: 32,color: GetConfig.getColor(theme),))
                    ),
                              Expanded(
                                child: Container(
                                    alignment:
                                    Alignment.topCenter,
                                    child: Text(
                                     "审核通过",
                                      style: TextStyle(
                                          ),
                                    )),
                              ),
                            ],
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                //  隐患信息
                                Row(children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 0, top: 8),
                                    child: Text(
                                    "测试测试",
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                  ),
                                ]),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                      EdgeInsets.only(
                                          left: 10,
                                          top: 6),
                                      child: Text(
                                        "测试测试",
                                        style: TextStyle(
                                            color:
                                            Colors.grey,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                      EdgeInsets.only(
                                          left: 10,
                                          top: 5),
                                      child: Text("测试：",
                                          style: TextStyle(
                                              color:
                                              Colors.grey,
                                              fontSize: 14)),
                                    ),
                                    Container(
                                      child: Text(
                                          "测试",
                                          style: TextStyle(
                                              color: getLevelTextBgColor(3),
                                              fontSize: 14)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                        padding:
                                        EdgeInsets.only(
                                            left: 10,
                                            top: 5),
                                        child:  Text("时间：",style: TextStyle(color:Colors.grey,fontSize:14))),

                                    Container(
                                        padding:
                                        EdgeInsets.only(
                                            left: 0,
                                            top: 5),
                                        child: Text("123",
                                            style: TextStyle( color:Colors.red,fontSize:14))),
                                  ],
                                ),

                                //  Padding(padding: EdgeInsets.only(top: 10),),
                              ],
                            ),
                          ),
                          flex: 5,
                        ),

                        Expanded(
                          child: Container(
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color:
                                Color.fromRGBO(209, 6, 24, 1),
                              ),
                              alignment:
                              Alignment.centerRight),
                          flex: 1,
                        ),
                      ],
                    )
                ),
              ),
            );
          },
        ),
        onRefresh: () async {
          await new Future.delayed(
              const Duration(seconds: 1), () {
            setState(() {
              pageIndex = 0;
//                pointList = [];
            });
//              loadData();
          });
        },
        loadMore: () async {
          await new Future.delayed(
              const Duration(seconds: 1), () {
            if (hasNext) {
              setState(() {
                pageIndex = pageIndex + 1;
              });
//                loadData();
            }
          });
        },
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  @override
  void initState() {
    super.initState();
    initConfig();
  }
}