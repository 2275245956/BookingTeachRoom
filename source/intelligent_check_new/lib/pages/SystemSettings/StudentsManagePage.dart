import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/services/SystemService/SystemConfigService.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class  StudentManagePage extends StatefulWidget {
  final String userRole;
  StudentManagePage(this.userRole);

  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<StudentManagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 当前页码
  int pageNum = 1;


  // 是否有下一页
  bool hasNext = true;
  List<UserModel> initData = new List();
  // 分页所需控件
  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();
  bool isAnimating = false;

  String theme = "red";


  @override
  void initState() {
    super.initState();

    loadData();
  }


  void loadData() async {
    int rearodNum=0;
    setState(() {
      isAnimating=true;
    });
   var data=await getAllUser(this.widget.userRole,pageNum.toString());
   if(data.success && data.dataList!=null){
       for(var jStr in data.dataList){
         if(jStr["role"]!=this.widget.userRole) continue;
         setState(() {
           rearodNum+=1;
           initData.add(UserModel.fromJson(jStr));
         });
       }
       if(rearodNum<10){
         setState(() {
           hasNext=false;
         });
       }
   }else{
     setState(() {
       hasNext=false;
     });
   }
    setState(() {
      isAnimating=false;

    });
  }

  void DeleteUser (String account)async{
    setState(() {
      isAnimating=true;
    });
    var data=await DELETEUSERS(account);
    if(data.success){
      GetConfig.popUpMsg("操作成功");
    }else{
      GetConfig.popUpMsg("操作失败");
    }
    setState(() {
      isAnimating=false;

    });

  }
  @override
  Widget build(BuildContext context) {
    if (this.initData == null) {
      return Scaffold(
          backgroundColor: Color.fromRGBO(242, 246, 249, 1),
          appBar: AppBar(
            title: Text(
              "${GetConfig.getRoleDesc(this.widget.userRole)}管理",
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
            "${GetConfig.getRoleDesc(this.widget.userRole)}管理",
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
          child:new Padding(
              padding: new EdgeInsets.only(top: 0.0),
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
                                  itemCount: initData.length,
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
                                                      color: Colors.red,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(4),
                                                            bottomLeft:
                                                            Radius.circular(
                                                                4)),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 8, top: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                            ),
                                                            Text(
                                                              "姓名：${initData[index].userName??"--"}",
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(padding:EdgeInsets.only(top: 1),),
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                            ),
                                                            Text(
                                                              "姓名：${initData[index].userName??"--"}",
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(padding:EdgeInsets.only(top: 1),),
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
                                                                "所属院/系：${initData[index].deptName??"--"}",
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.grey,
                                                                    fontSize: 12),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        Padding(padding:EdgeInsets.only(top:1),),
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
                                                               "专业：${initData[index].major ??"--"}",
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.grey,
                                                                    fontSize: 12),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        Padding(padding:EdgeInsets.only(top: 1),),
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
                                                                this.widget.userRole=="student"?"班级：${initData[index].uClass}":"性别：${initData[index].sex}",
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.grey,
                                                                    fontSize: 12),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        Padding(padding:EdgeInsets.only(top:1),),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ),
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          caption: '删除',
                                          color: GetConfig.getColor(theme),
                                          icon: Icons.delete_forever,
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return CupertinoAlertDialog(
                                                    title: Text("删除提示"),
                                                    content: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Align(
                                                          child: Text("确定删除？此操作无法撤回！"),
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
                                                          DeleteUser(initData[index].account);
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
                                          initData = new List();
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
                                          });
                                          loadData();
                                        }
                                      });
                                },
                              )),

                        ],
                      ))
                ],
              )),
          inAsyncCall: isAnimating,
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ));
  }

}
