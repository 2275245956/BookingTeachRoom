import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/Lamb/ApplyLam/RoomModel.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/ApplyLambInfo.dart';
import 'package:intelligent_check_new/services/TeacherServices/TechServices.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class SelLambScreen extends StatefulWidget {
  @override
  _SelLambScreen createState() => _SelLambScreen();
}

class _SelLambScreen extends State<SelLambScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String theme = "red";
  bool isAnimating = false;
  var startValue = "read";
  var endvalue = "read";
  TextEditingController startDate = new TextEditingController();
  TextEditingController endDate = new TextEditingController();
  var schedule;
  List<DropdownMenuItem> droplist = new List<DropdownMenuItem>();

  String dateStart = "";
  String dateEnd = "";
  List<RoomModel> roomlist = new List<RoomModel>();
 var initDateTime=new DateTime.now();

  @override
  void initState() {
    super.initState();
    _InitData();
  }

  // ignore: non_constant_identifier_names
  _InitData() async {
    await SharedPreferences.getInstance().then((sp) {
      setState(() {
        schedule = jsonDecode(sp.getString("schedule"));
        droplist = _getScheduleDrop();
      });
    });
  }

  List<DropdownMenuItem> _getScheduleDrop() {
    var drop = new List<DropdownMenuItem>();
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("read")}(${schedule["read"]})",
        style: TextStyle(color: Colors.black, fontSize: 13),
      ),
      value: "read",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("first")}(${schedule["first"]})",
        style: TextStyle(color: Colors.black, fontSize: 13),
      ),
      value: "first",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("second")}(${schedule["second"]})",
        style: TextStyle(color: Colors.black, fontSize: 13),
      ),
      value: "second",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("third")}(${schedule["third"]})",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      value: "third",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("forth")}(${schedule["forth"]})",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      value: "forth",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("fifth")}(${schedule["fifth"]})",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      value: "fifth",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("sixth")}(${schedule["sixth"]})",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      value: "sixth",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("seventh")}(${schedule["seventh"]})",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      value: "seventh",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("eight")}(${schedule["eight"]})",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      value: "eight",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("ninth")}(${schedule["ninth"]})",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      value: "ninth",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("tenth")}(${schedule["tenth"]})",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      value: "tenth",
    ));
    drop.add(new DropdownMenuItem(
      child: new Text(
        "${GetConfig.getScheduleDesc("sleep")}(${schedule["sleep"]})",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      value: "sleep",
    ));
    return drop;
  }

  getSelDate(TextEditingController controller) {

    String _format = 'yyyy年MM月dd日    EEEE';

    DatePicker.showDatePicker(
      context,
      minDateTime: DateTime.now(),
      maxDateTime: DateTime.now().add(Duration(days: 365)),
      initialDateTime: initDateTime,
      dateFormat: _format,
      locale: DateTimePickerLocale.zh_cn,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
      ),
      pickerMode: DateTimePickerMode.datetime,
      // show TimePicker
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          controller.text = DateFormat("yyyy-MM-dd(EEEE)", "zh")
              .format(dateTime)
              .toString();
          if(startDate.text!=""){
              initDateTime=DateTime.parse(startDate.text.substring(0,10));
          }
        });
      },
    );
  }

  // ignore: missing_return
  DateTime _GetDateTime(String date, String time) {
    if (time.contains(":")) {
      var timeStr = time.split(':');
      var hour = timeStr[0];
      var minute = timeStr[1];
      if (hour.length == 1 && int.tryParse(hour) <= 9) {
        hour = "0${hour}";
      }
      var dateTime = DateTime.parse("${date} ${hour}:${minute}:00");
      return dateTime;
    }
    return DateTime.now();
  }

  _SearchRoom() async {
    var sDate = startDate.text.substring(0,10);
    var eDate = endDate.text.substring(0,10);
    if (sDate == "" || eDate == "") {
      GetConfig.popUpMsg("请选择时间!");
      return;
    }
    var classbegin = schedule[startValue].contains("~")
        ? schedule[startValue].split('~')[0]
        : schedule[startValue];
    var classend = schedule[endvalue].contains("~")
        ? schedule[endvalue].split('~')[1]
        : schedule[endvalue];

    var start = _GetDateTime(sDate, classbegin);
    var end = _GetDateTime(eDate, classend);

    if (end.isBefore(start)) {
      GetConfig.popUpMsg("开始时间和结束时间不可有交叉！");
      return;
    }
    if (startValue == "read" ||
        startValue == "sleep" ||
        endvalue == "read" ||
        endvalue == "sleep") {
      GetConfig.popUpMsg("早读时间和熄灯时间不在实验范围内！");
      return;
    }
  GetConfig.IOSPopMsg("提示！",Text("您选择的结果是：\r\n${startDate.text}~${endDate.text}的每周${startDate.text.substring(11,14)}的空教室",textAlign: TextAlign.left,), context);
  }
  _Apply(String classbegin,String classend,String sDate,String eDate)async{


    var sTime="${classbegin.toString().split(":")[0]}${classbegin.toString().split(":")[1]}";
    var eTime="${classend.toString().split(":")[0]}${classend.toString().split(":")[1]}";
    setState(() {
      roomlist.clear();
    });
    print(sDate +"====>"+sTime);
    print(eDate +"====>"+eTime);


    var response = await getEmptyLam(sDate,sTime,eDate,eTime);
    if (response.success) {
      setState(() {
        for (var str in response.dataList) {

          roomlist.add(RoomModel.fromJson(str));
        }
      });
    } else {
      GetConfig.popUpMsg(response.message ?? "获取失败");
    }
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (theme.isEmpty || droplist.length == 0) {
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
              onTap: () {
                _SearchRoom();
              },
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
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "开始时间",
                      style: TextStyle(
                          color: GetConfig.getColor(theme), fontSize: 16),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 7,
                                      child: TextField(
                                        style: TextStyle(fontSize: 14),
                                        enabled: false,
                                        controller: startDate,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 3),
                                          border: InputBorder.none,
                                          hintText: "选择时间",
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        onEditingComplete: () {
                                          //print(this._controller.text);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.date_range,
                                        color: GetConfig.getColor(theme),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            getSelDate(startDate);
                          },
                        )),
                    flex: 8,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "结束时间",
                      style: TextStyle(
                          color: GetConfig.getColor(theme), fontSize: 16),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 7,
                                      child: TextField(
                                        enabled: false,
                                        controller: endDate,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 3),
                                          border: InputBorder.none,
                                          hintText: "选择时间",
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.date_range,
                                        color: GetConfig.getColor(theme),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            getSelDate(endDate);
                          },
                        )),
                    flex: 8,
                  ),
                ],
              ),
            ),
           Container(
             margin: EdgeInsets.only(left: 10,right: 10),
             child:  Row(
               children: <Widget>[
                 Expanded(
                   child: Container(
                     color: Colors.white,
                     height: 38,
                     child: new DropdownButtonHideUnderline(
                         child: new DropdownButton(
                           items: droplist,
                           hint: new Text(
                             '节次',
                             style: TextStyle(color: Colors.black12, fontSize: 12),
                           ),
                           onChanged: (value) {
                             setState(() {
                               startValue = value;
                             });
                           },
                           value: startValue,
                           elevation: 24,

                           style: new TextStyle(
                             fontSize: 12,
                           ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                           iconSize: 30.0,
                           iconEnabledColor: Colors.black12,
                         )),
                   ) ,
                   flex: 10,
                 ),
                 Expanded(
                   child: Text("~",style: TextStyle(),textAlign: TextAlign.center,),
                   flex: 1,
                 ),
                 Expanded(
                   child: Container(
                     color: Colors.white,
                     height: 38,
                     child: new DropdownButtonHideUnderline(
                         child: new DropdownButton(
                           items: droplist,
                           hint: new Text(
                             '节次',
                             style: TextStyle(
                               color: Colors.black12,
                             ),
                           ),
                           onChanged: (value) {
                             setState(() {
                               endvalue = value;
                             });
                           },
                           value: endvalue,
                           elevation: 24,
                           style: new TextStyle(
                             fontSize: 12,
                           ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                           iconSize: 30.0,
                           iconEnabledColor: Colors.black12,
                         )),
                   ),
                   flex: 10,
                 ),
               ],
             ),
           ),

            Divider(
              color: GetConfig.getColor(theme),
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text("说明：选择时间加载当前日期下的空闲教室，点击教室申请实验！",
                  style: TextStyle(color: Colors.red, fontSize: 12)),
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
                    onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => ApplyLambInfo(
                                        room,
                                        dateStart,
                                        dateEnd,
                                        "${GetConfig.getScheduleDesc(startValue)}~${GetConfig.getScheduleDesc(endvalue)}")))
                            .then((_) {
                          _SearchRoom();
                        }),
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
