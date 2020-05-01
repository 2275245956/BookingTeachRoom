import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/model/message/SubscribeInfo.dart';
import 'package:intelligent_check_new/services/SystemService/SystemConfigService.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMessagePage extends StatefulWidget {
  MyMessagePage();
  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<MyMessagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<MessageModel> MessageList = new List();

  bool isAnimating = false;

  String theme = "red";
  UserModel userInfo;

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
    }).then((_) {
      loadData();
    });
  }

  void loadData() async {
    var data = await getAllMessage(userInfo.account);
    if (data.success && data.dataList != null && data.dataList.length > 0) {
      setState(() {
        for (var jStr in data.dataList) {
          setState(() {
            MessageList.add(MessageModel.fromJson(jStr));
          });
        }
      });
    }
  }

  void  readAll(int id,bool readAll) async{
     if(readAll){
       for(MessageModel m in MessageList){
         if(m.readed)continue;
         var res= await readAllMessage(m.id);
         if(!res.success)print("失败====================================");
       }
     }else{
       var res=await readAllMessage(id);
       if(!res.success)print("失败====================================");
     }

  }
  @override
  Widget build(BuildContext context) {
    if (this.MessageList == null && userInfo.account == "") {
      return Scaffold(
          backgroundColor: Color.fromRGBO(242, 246, 249, 1),
          appBar: AppBar(
            title: Text(
              "消息记录",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            centerTitle: true,
            elevation: 0.2,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            leading: new Container(
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context,true);
                },
                child: Icon(Icons.keyboard_arrow_left,
                    color: GetConfig.getColor(theme), size: 32),
              ),
            ),
          ),
          body: Container());
    }
    return WillPopScope(child:  Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        appBar: AppBar(
          title: Text(
            "消息记录",
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: new Container(
            child: GestureDetector(
              onTap: (){
                var hasReadAll=true;
                for(MessageModel m in MessageList){
                  if(!m.readed){
                    hasReadAll=false;
                    break;
                  }
                }
                Navigator.pop(context,hasReadAll);
              },
              child: Icon(Icons.keyboard_arrow_left,
                  color: GetConfig.getColor(theme), size: 32),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("一键已读"),
          onPressed: () {
                readAll(0,true);
          },
        ),
        body: ModalProgressHUD(
          child: new Padding(
            padding: new EdgeInsets.only(top: 1.0),
            child: ListView.builder(
              //ListView的Item
              itemCount: MessageList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        if(MessageList[index].readed)return;
                        MessageList[index].readed = true;
                        readAll(MessageList[index].id,false);
                      });
                    },
                    child: Container(
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.only(top: 5, left: 3, right: 3),
                        child: new Container(
                            margin:
                            EdgeInsets.only(left: 10, right: 10, top: 5),
                            height: 120.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.notifications_active,
                                        color: MessageList[index].readed
                                            ? Colors.grey
                                            : GetConfig.getColor(theme),
                                        size: 25,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                          "${MessageList[index].messagetype}"),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: GestureDetector(
                                        child: MessageList[index].readed
                                            ? Text(
                                          "已读",
                                          style: TextStyle(
                                              color: Colors.grey),
                                          textAlign: TextAlign.right,
                                        )
                                            : Text("标记已读",
                                            style: TextStyle(
                                                color: GetConfig.getColor(
                                                    theme)),
                                            textAlign: TextAlign.right),
                                        onTap: () {
                                          setState(() {
                                            if(MessageList[index].readed)return;
                                            MessageList[index].readed = true;
                                            readAll(MessageList[index].id,false);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Text("消息："),
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child:
                                      Text("${MessageList[index].message}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Text("时间："),
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child: Text(
                                          "${DateFormat("yyyy年MM月dd日（EEEE）", "zh").format(DateTime.parse(MessageList[index].createdDate))}"),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
//                                          margin: EdgeInsets.only(left: 10,right: 10),
                    ));
              },
            ),
          ),
          inAsyncCall: isAnimating,
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ))
    ,onWillPop:(){
        var hasReadAll=true;
        for(MessageModel m in MessageList){
          if(!m.readed){
            hasReadAll=false;
            break;
          }
        }
        Navigator.pop(context,hasReadAll);
      },
    );
  }
}
