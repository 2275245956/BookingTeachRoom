import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/RoomModel.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/ApplyLambInfo.dart';
import 'package:intelligent_check_new/services/TeacherServices/TechServices.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/tools/min_calendar/model/date_day.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelLambScreen extends StatefulWidget {
  final dynamic selValue;
  final Map<DateDay, String> selDateMa;

  SelLambScreen({this.selValue, this.selDateMa});

  @override
  _SelLambScreen createState() => _SelLambScreen();
}

class _SelLambScreen extends State<SelLambScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String theme = "red";
  bool isAnimating = false;
  List<RoomModel> roomlist = new List<RoomModel>();
  UserModel userInfo;

  @override
  void initState() {
    super.initState();
    _InitData();
  }

  // ignore: non_constant_identifier_names
  _InitData() async {
    await SharedPreferences.getInstance().then((sp) {
      setState(() {
        userInfo = UserModel.fromJson(json.decode(sp.getString("userModel")));
      });
    });
    var data = await getEmptyLam(
        this.widget.selValue["sDate"],
        this.widget.selValue["sTime"],
        this.widget.selValue["eDate"],
        this.widget.selValue["eTime"]);
    if (data.success && data.dataList != null) {
      for (var ss in data.dataList) {
        setState(() {
          roomlist.add(RoomModel.fromJson(ss));
        });
      }
    }
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (theme.isEmpty) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        body: Text(""),
      );
    }
    //获取统计数据
//    StatisticsPage.queryAuthCompanyLeaves();
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 246, 249, 1),
      appBar: AppBar(
        title: Text(
          '实验室选择',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: GetConfig.getColor(theme),
            size: 28,
          ),
          onTap: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: Icon(
                Icons.search,
                color: GetConfig.getColor(theme),
                size: 28,
              ),
              onTap: () {},
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        child: Container(
            child: Column(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(242, 246, 249, 1),
              height:6,
            ),
            Container(

              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                    child:     Row(
                      children: <Widget>[
                        Expanded(
                          flex:3,
                          child: Text("起止时间"),
                        ),
                        Expanded(flex: 7,
                          child: Text("${this.widget.selValue["sDate"]}~${this.widget.selValue["eDate"]}"),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
            Container(

              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                    child:     Row(
                      children: <Widget>[
                        Expanded(
                          flex:3,
                          child: Text("节次"),
                        ),
                        Expanded(flex: 7,
                          child: Text("${this.widget.selValue["section"]}"),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
            Divider(
              color: GetConfig.getColor(theme),
            ),
            Flexible(
              child: GridView(
                shrinkWrap: true,
                //构造 GridView 的委托者，GridView.count 就相当于指定 gridDelegate 为 SliverGridDelegateWithFixedCrossAxisCount，
                //GridView.extent 就相当于指定 gridDelegate 为 SliverGridDelegateWithMaxCrossAxisExtent，它们相当于对普通构造方法的一种封装
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //必传参数，Cross 轴（在 GridView 中通常是横轴，即每一行）子组件个数
                  crossAxisCount: 3,
                  //子组件宽高比，如 2 表示宽：高=2:1,如 0.5 表示宽：高=0.5:1=1:2，简单来说就是值大于 1 就会宽大于高，小于 1 就会宽小于高
                  childAspectRatio: 1,
                  //Cross 轴子组件的间隔，一行中第一个子组件左边不会添加间隔，最后一个子组件右边不会添加间隔，这一点很棒
                  crossAxisSpacing: 3,
                  //Main 轴（在 GridView 中通常是纵轴，即每一列）子组件间隔，也就是每一行之间的间隔，同样第一行的上边和最后一行的下边不会添加间隔
                  mainAxisSpacing: 3,
                ),
                cacheExtent: 0,
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
                children: roomlist.map((room) {
                  return GestureDetector(
                    child: Container(
                      decoration: new BoxDecoration(
                        border:
                            new Border.all(width: 2.0, color: Colors.black12),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(8.0)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(room.rNumber,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(room.rName,
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(room.attriText01,
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      var listData=this.widget.selDateMa.keys.toList();
                      listData.sort((left,right)=>DateTime.parse(left.toString()).compareTo(DateTime.parse(right.toString())));
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>ApplyLambInfo(room,this.widget.selValue,listData)));
                    },
                  );
                }).toList(),
              ),
            )
          ],
        )),
        inAsyncCall: isAnimating,
        // demo of some additional parameters
        opacity: 0.7,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }
}
