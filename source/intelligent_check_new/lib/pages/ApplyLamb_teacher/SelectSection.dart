import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/SelectLambPage.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/tools/min_calendar/model/date_day.dart';
import 'package:intelligent_check_new/tools/min_calendar/model/i18n_model.dart';
import 'package:intelligent_check_new/tools/min_calendar/model/month_option.dart';
import 'package:intelligent_check_new/tools/min_calendar/widget/month_page_view.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';


class SelectSection extends StatefulWidget {
  @override
  _SelectSection createState() => _SelectSection();
}

class _SelectSection extends State<SelectSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String theme = "red";
  bool isAnimating = false;
  var startValue = "read";
  var endvalue = "read";
  Map<DateDay,String> _selDateMap=new Map();

  TextEditingController startDate = new TextEditingController(text: DateFormat("yyyy-MM-dd","zh").format(DateTime.now()));
  DateTime selSDate=DateTime.now();
  DateTime selEDate=DateTime.now();
  TextEditingController endDate = new TextEditingController(text: DateFormat("yyyy-MM-dd","zh").format(DateTime.now()));
  var schedule;
  List<DropdownMenuItem> droplist = new List<DropdownMenuItem>();

  String dateStart = "";
  String dateEnd = "";
  var initDateTime = new DateTime.now();

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
          controller.text = DateFormat("yyyy-MM-dd").format(dateTime).toString();
          if(_selDateMap.length>0){
            _selDateMap.clear();
            GetConfig.popUpMsg("当前选择已清空");
          }

          if (startDate.text != "") {
            initDateTime = DateTime.parse(startDate.text.substring(0, 10));
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
    var sDate = startDate.text.substring(0, 10);
    var eDate = endDate.text.substring(0, 10);
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
    var end = _GetDateTime(sDate, classend);
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

    var sStr = DateFormat("yyyy-MM-dd HH:mm:00").format(start);
    var eStr = DateFormat("yyyy-MM-dd HH:mm:00").format(end);
    print(sDate+"========>"+classbegin);
    print(eDate+"========>"+classend);
    var sTime="${classbegin.toString().split(":")[0]}${classbegin.toString().split(":")[1]}";
    var eTime="${classend.toString().split(":")[0]}${classend.toString().split(":")[1]}";
    var josnStr={
      "sDate":sDate,
      "eDate":eDate,
      "sTime":sTime,
      "eTime":eTime,
      "section": "${GetConfig.getScheduleDesc(startValue)}~${GetConfig.getScheduleDesc(endvalue)}"
    };
    Navigator.push(context, new MaterialPageRoute(builder: (context)=>SelLambScreen(selValue:josnStr,selDateMa: _selDateMap,)));
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (theme.isEmpty || droplist.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            '上课时间',
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
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
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
          '上课时间',
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
                ///开始时间
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
                ///结束时间
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
                ///上课时间选择
                Container(
                  child:     MonthPageView(
                    padding: EdgeInsets.all(1),
                    option: MonthOption(
                      marks:_selDateMap,
                    ),
                    showWeekHead: true,

                    buildMark: (ctx, day, data) => Positioned(
                      bottom: 3,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size:25,
                        ),
                      ),
                    ),
                    onDaySelected: (day, data) {
                      setState(() {
                        if(DateTime.parse(startDate.text).isAfter(DateTime.parse(day.toString())) || DateTime.parse(endDate.text).isBefore(DateTime.parse(day.toString()))){
                          GetConfig.popUpMsg("该时间不在开始和结束时间的范围内！");
                          return;
                        }
                        if(_selDateMap.containsKey(day)){
                          _selDateMap.remove(day);
                        }else{
                          _selDateMap[day]=data;
                        }
                      });
                    },
                    localeType: LocaleType.zh,
                  ),
                ),
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
