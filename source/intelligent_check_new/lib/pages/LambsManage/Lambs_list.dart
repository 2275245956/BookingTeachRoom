import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/RoomModel.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/pages/LambsManage/Lambs_Add.dart';
import 'package:intelligent_check_new/services/SystemService/SystemConfigService.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class  LambsManage extends StatefulWidget {
  LambsManage();

  @override
  _LambsManage createState() => _LambsManage();
}

class _LambsManage extends State<LambsManage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<RoomModel> initData = new List();

  bool isAnimating = false;

  String theme = "red";


  @override
  void initState() {
    super.initState();

    loadData();
  }


  void loadData() async {
    setState(() {
      isAnimating=true;
    });
     var data= await GETALLLAMBS();
    if(data.success && data.dataList!=null){
        for(var str in data.dataList){
          this.initData.add(RoomModel.fromJson(str));
        }
    }
    setState(() {
      isAnimating=false;

    });
  }

  void DeleteUser (UserModel model)async{
    setState(() {
      isAnimating=true;
    });
    var data=await DELETEUSERS(model.account);
    if(data.success){
      initData.remove(model);
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
              "实验室管理",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            centerTitle: true,
            elevation: 0.2,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            actions: <Widget>[

            ],
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
            "实验室管理",
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
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          elevation: 5,
          label: Text("新增"),
          onPressed: () {
            Navigator.push(context,new MaterialPageRoute(builder: (context){return new LambsAdd_EditPage("add",null);}));
          },
        ),
        floatingActionButtonLocation:FloatingActionButtonLocation.endFloat,
        body: ModalProgressHUD(
          child:new Padding(
              padding: new EdgeInsets.only(top: 0.0),
              child: ListView.builder(
            itemCount: initData.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  color: Colors.white,
                  child: Card(
                    elevation: 4.5,
                    child: new Container(
                        height: 110.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  top: 5),
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
                                        "教室编号：${initData[index].rNumber??"--"}",
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
                                        "教室名称：${initData[index].rName??"--"}",
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
                                          "教室位置：${initData[index].attriText02??"--"}",
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

                                          "创建时间：${DateFormat('yyyy年MM月dd日(EEEE)','zh').format(DateTime.parse(initData[index].createDate))}",
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
                                          "最近更新：${DateFormat('yyyy年MM月dd日(EEEE)','zh').format(DateTime.parse(initData[index].updateDate))}",
                                          style: TextStyle(
                                              color:
                                              Colors.grey,
                                              fontSize: 12),
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                secondaryActions: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Card(
                      elevation: 4.5,
                      child: new Container(
                        margin: EdgeInsets.only(left: 0),
                        height: 110.0,
                        child: IconSlideAction(
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

                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Card(
                      elevation: 4.5,
                      child: new Container(
                        margin: EdgeInsets.only(left: 0),
                        height: 110.0,
                        child: IconSlideAction(
                          caption: '编辑',
                          color: Colors.green,
                          icon: Icons.border_color,
                          onTap: () {
                                Navigator.push(context,new MaterialPageRoute(builder: (context){return new LambsAdd_EditPage("edit",this.initData[index]);}));
                          },
                        ),),
                    ),
                  ),
                ],
              );
            },
          ),),
          inAsyncCall: isAnimating,
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ));
  }

}
