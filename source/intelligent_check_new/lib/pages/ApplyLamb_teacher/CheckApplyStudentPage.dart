import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/StuApplyLamModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/services/TeacherServices/TechServices.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckApplyStudent extends StatefulWidget {
  CheckApplyStudent();

  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<CheckApplyStudent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 当前页码
  int pageNum = 1;
  int pageSize = 10;

  // 是否有下一页
  bool hasNext = true;
  List<StuApplyModel> initRecordData = new List();
  List<Map<String, dynamic>> TITLE_ALL_CONTENT=new List();
  List<String> allLams=new List();
  // 分页所需控件
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  bool isAnimating = false;

  String theme = "red";
  UserModel userInfo;

  String eName = "";
  int checkStatus=0;
  String reqNumber="";

  @override
  void initState() {
    super.initState();

    _InitData();
  }

  void _InitData() async {
    await SharedPreferences.getInstance().then((sp) {
      setState(() {
        if (sp.getString("userModel") != null) {
          userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
        }
      });
    }).then((_){
      GETAllPassedLamInfoByTNumber(tNumber:userInfo.account).then((data){
        setState(() {
          if(data.success) {

            for (var str in data.dataList) {
              Map<String, dynamic> map = new Map();
              map["title"] = str["eName"];
              map["id"] = str["reqNumber"];
             if(!allLams.contains(str["eName"])){
               allLams.add(str["eName"]);
               TITLE_ALL_CONTENT.add(map);
             }

            }
          }
        });
      });

    });

    // await loadData();
  }


  void loadData() async {
    setState(() {
      isAnimating=true;
    });
    var data = await GetAllApplyingStudentByTeachNum(
       eName, userInfo.account, pageNum.toString());
    if (data.success && data.dataList != "") {
      setState(() {
        hasNext = true;
      });
      for (var str in data.dataList) {
        setState(() {
          initRecordData.add(new StuApplyModel.fromJson(str));
        });
      }
    } else {
      setState(() {
        hasNext = false;
      });
      GetConfig.popUpMsg(data.message);
    }
    setState(() {
      isAnimating=false;

    });
  }

  void CheckStudentApplyWithStatus(StuApplyModel tempModel,int status) async{
    setState(() {
      isAnimating=true;
    });
   var data= await CheckStudentApplyTeacher(tempModel.reqNumber,status);
   if(data.success){
     GetConfig.popUpMsg(data.message??"操作成功");
     setState(() {
       initRecordData.remove(tempModel);
     });
   }else{
     GetConfig.popUpMsg(data.message??"操作失败");
   }


    setState(() {
      isAnimating=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (this.initRecordData == null && userInfo.account != "") {
      return Scaffold(
          backgroundColor: Color.fromRGBO(242, 246, 249, 1),
          appBar: AppBar(
            title: Text(
              "申请记录",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            centerTitle: true,
            elevation: 0.2,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            actions: <Widget>[],
            leading: new Container(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.keyboard_arrow_left,
                    color: GetConfig.getColor(theme), size: 32),
              ),
            ),
          ),
          body: Container());
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        appBar: AppBar(
          title: Text(
            "申请记录",
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          actions: <Widget>[],
          leading: new Container(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_left,
                  color: GetConfig.getColor(theme), size: 32),
            ),
          ),
        ),
        body: ModalProgressHUD(

          child: _getWidget(),
          inAsyncCall: isAnimating,
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ));
  }

  Widget _getWidget() {
    return buildInnerListHeaderDropdownMenu();
  }

  ScrollController scrollController = new ScrollController();
  GlobalKey globalKey2 = new GlobalKey();

  Widget buildInnerListHeaderDropdownMenu() {
    return new DefaultDropdownMenuController(
        onSelected: ({int menuIndex, int index, int subIndex, dynamic data}) {
          if (menuIndex == 0) {
            setState(() {
             eName= data["title"].toString();
              initRecordData = [];
              pageNum =1;
              loadData();
            });
          }
        },
        child: new Stack(
          children: <Widget>[
            new CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  new SliverList(
                      key: globalKey2,
                      delegate: new SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return new Container(
                          color: Colors.black26,
                        );
                      }, childCount: 1)),
                  new SliverPersistentHeader(
                    delegate: new DropdownSliverChildBuilderDelegate(
                        builder: (BuildContext context) {
                      return new Container(
                          color: Colors.white,
                          child: buildDropdownHeader(onTap: this._onTapHead));
                    }),
                    pinned: true,
                    floating: true,
                  ),
                  new SliverList(
                      delegate: new SliverChildBuilderDelegate(
                          (BuildContext context, int index) {},
                          childCount: 10)),
                ]),
            new Padding(
                padding: new EdgeInsets.only(top: 46.0),
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                        child: new Stack(
                      children: <Widget>[
                        Center(

                            child: EasyRefresh(
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
                          child: ListView.builder(
                            itemCount: initRecordData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                child: Container(
                                  color: Colors.white,
                                  child: Card(
                                    color: Color.fromRGBO(252, 249, 244, 1),
                                    elevation:0,
                                    margin: EdgeInsets.only(
                                        top: 5, left: 3, right: 3),
                                    child: new Container(
                                        height: 100.0,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 8,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(4),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  4)),
                                                  color:getPointColor(initRecordData[index].status)),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, top: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new Text(
                                                    "${(index + 1)}.  ${initRecordData[index].eName}",
                                                    style: new TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                      ),
                                                      Text(
                                                        "学生姓名：${initRecordData[index].sName}",
                                                        style: TextStyle(
                                                            color: Colors.grey,
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
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            50,
                                                        child: Text(
                                                          "专业：${initRecordData[index].sMajor}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12),
                                                        ),
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
                                                            color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "${initRecordData[index].status}",
                                                        style: TextStyle(
                                                          color:getPointColor(initRecordData[index].status),
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                  ),

                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: '驳回',
                                    color: GetConfig.getColor(theme),
                                    icon: Icons.delete_forever,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: Text("驳回提示"),
                                              content: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    child: Text("确定驳回“${initRecordData[index].sName}”的实验申请？此操作无法撤回！"),
                                                    alignment: Alignment(0, 0),
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                CupertinoDialogAction(
                                                  child: Text("取消"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                CupertinoDialogAction(
                                                  child: Text("确定"),
                                                  onPressed: (){
                                                    CheckStudentApplyWithStatus(initRecordData[index], 8);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  IconSlideAction(
                                    caption: '通过',
                                    color: Colors.green,
                                    icon: Icons.spellcheck,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: Text("提示"),
                                              content: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    child: Text("确定执行该操作？"),
                                                    alignment: Alignment(0, 0),
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                CupertinoDialogAction(
                                                  child: Text("取消"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                CupertinoDialogAction(
                                                  child: Text("确定"),
                                                  onPressed: (){
                                                    CheckStudentApplyWithStatus(initRecordData[index],7);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });

                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          onRefresh: () async {
                            await new Future.delayed(const Duration(seconds: 1),
                                () {
                              setState(() {
                                pageNum = 1;
                                initRecordData = new List();
                              });
                              loadData();
                            });
                          },
                          loadMore: () async {
                            await new Future.delayed(const Duration(seconds: 1),
                                () {
                              if (hasNext) {
                                setState(() {
                                  pageNum = pageNum + 1;
                                  initRecordData=[];
                                });
                                loadData();
                              }
                            });
                          },
                        )),
                        buildDropdownMenu()
                      ],
                    ))
                  ],
                )),
          ],
        ));
  }

  Color getPointColor(String status) {
    switch (status) {
      case "申请提交(学生)":
        return Colors.orange;
      case "申请通过(教师)":
        return Colors.green;
      case "申请退回(教师)":
        return Colors.red;
      case "申请通过(管理员)":
        return Colors.green;
      case "申请退回(管理员)":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }


  void _onTapHead(int index) {
    RenderObject renderObject = globalKey2.currentContext.findRenderObject();
    DropdownMenuController controller =
    DefaultDropdownMenuController.of(globalKey2.currentContext);
    scrollController
        .animateTo(scrollController.offset + renderObject.semanticBounds.height,
        duration: new Duration(milliseconds: 150), curve: Curves.ease)
        .whenComplete(() {
      controller.show(index);
    });
  }

  String titleAll = '所有';

  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback onTap}) {
    return new DropdownHeader(
      onTap: onTap,
      titles: [titleAll],
    );
  }

  static const int TYPE_INDEX = 0;

  DropdownMenu buildDropdownMenu() {
    return new DropdownMenu(
        maxMenuHeight: kDropdownMenuItemHeight * 10,
        menus: [
          TITLE_ALL_CONTENT!=null && TITLE_ALL_CONTENT.length>0?  new DropdownMenuBuilder(
              builder: (BuildContext context) {
                return new DropdownListMenu(
                  selectedIndex: TYPE_INDEX,
                  data: TITLE_ALL_CONTENT,
                  itemBuilder:
                      (BuildContext context, dynamic data, bool selected) {
                    return new Padding(
                        padding: new EdgeInsets.all(3.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              defaultGetItemLabel(data),
                              style: selected
                                  ? new TextStyle(
                                  fontSize: 14.0,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w400)
                                  : new TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ));
                  },
                );
              },
              height: kDropdownMenuItemHeight * TITLE_ALL_CONTENT?.length):new DropdownMenuBuilder(builder: (BuildContext context) {return Container();}),
        ]);
  }


}
