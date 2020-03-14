import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intelligent_check_new/pages/navigation_keep_alive.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ScheduleModel {
  TextEditingController startreadTimeController = new TextEditingController();

  TextEditingController startfirstClassController = new TextEditingController();
  TextEditingController startsecondClassController = new TextEditingController();
  TextEditingController startthirdClassController = new TextEditingController();
  TextEditingController startforthClassController = new TextEditingController();
  TextEditingController startfithClassController = new TextEditingController();
  TextEditingController startsixthClassController = new TextEditingController();
  TextEditingController startsevenClassController = new TextEditingController();
  TextEditingController starteightClassController = new TextEditingController();
  TextEditingController startnightClassController = new TextEditingController();
  TextEditingController starttenClassController = new TextEditingController();

  TextEditingController endreadTimeController = new TextEditingController();
  TextEditingController endsecondClassController = new TextEditingController();
  TextEditingController endfirstClassController = new TextEditingController();
  TextEditingController endthirdClassController = new TextEditingController();
  TextEditingController endforthClassController = new TextEditingController();
  TextEditingController endfithClassController = new TextEditingController();
  TextEditingController endsixthClassController = new TextEditingController();
  TextEditingController endsevenClassController = new TextEditingController();
  TextEditingController endeightClassController = new TextEditingController();
  TextEditingController endnightClassController = new TextEditingController();
  TextEditingController endtenClassController = new TextEditingController();
  TextEditingController closeTimeController = new TextEditingController();
}

class ScheduleSettingPage extends StatefulWidget {
  ScheduleSettingPage({Key key}) : super(key: key);

  @override
  _ScheduleSettingPage createState() => new _ScheduleSettingPage();
}

class _ScheduleSettingPage extends State<ScheduleSettingPage> {
  // 当前点的附件
  bool isAnimating = false;
  bool canOperate = true;
  ScheduleModel scheduleModel = new ScheduleModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "作息时间设置",
            style: TextStyle(
              color: Colors.black,
              fontSize: 19,
            ),
          ),
          centerTitle: true,
          elevation: 0.2,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: new Container(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_arrow_left,
                  color: Color.fromRGBO(
                      50, 89, 206, 1) /*Color.fromRGBO(209, 6, 24, 1)*/,
                  size: 32),
            ),
          ),
        ),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  //早读时间
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "早读时间",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startreadTimeController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startreadTimeController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .endreadTimeController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.endreadTimeController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //第一节
                  Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding:
                  EdgeInsets.only(left: 10, top: 10, bottom: 5),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "第一节",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            flex: 19,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child:  Container(
                                width: MediaQuery.of(context).size.width/2-30,
                                margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                padding: EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),

                                child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Text("起"),

                                            Expanded(
                                              flex: 7,
                                              child: TextField(
                                                enabled: false,
                                                keyboardType:
                                                TextInputType.number,
                                                autofocus: false,
                                                controller: scheduleModel
                                                    .startfirstClassController,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10),
                                                  border: InputBorder.none,
                                                  hintText: "选择时间",
                                                  filled: true,
                                                  fillColor: Color.fromRGBO(
                                                      244, 244, 244, 1),
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
                                                color: Color.fromRGBO(
                                                    50, 89, 206, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  onTap: () {
                                    DatePicker.showTimePicker(context,
                                        showTitleActions: true,
                                        theme: DatePickerTheme(
                                            itemStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            doneStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16)),
                                        onConfirm: (date) {
                                          scheduleModel.startfirstClassController.text =new DateFormat("HH:mm").format(date);
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.zh);
                                  },
                                )
                            ),

                          ),
                          Expanded(
                            child:  Container(
                                width: MediaQuery.of(context).size.width/2-30,
                                margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                padding: EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),

                                child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Text("止"),
                                            Expanded(
                                              flex: 7,
                                              child: TextField(
                                                enabled: false,
                                                keyboardType:
                                                TextInputType.number,
                                                autofocus: false,
                                                controller: scheduleModel
                                                    .endfirstClassController,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10),
                                                  border: InputBorder.none,
                                                  hintText: "选择时间",
                                                  filled: true,
                                                  fillColor: Color.fromRGBO(
                                                      244, 244, 244, 1),
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
                                                color: Color.fromRGBO(
                                                    50, 89, 206, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  onTap: () {
                                    DatePicker.showTimePicker(context,
                                        showTitleActions: true,
                                        theme: DatePickerTheme(
                                            itemStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            doneStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16)),
                                        onConfirm: (date) {
                                          scheduleModel.endfirstClassController.text =new DateFormat("HH:mm").format(date);
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.zh);
                                  },
                                )
                            ),

                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
                  //第二节
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "第二节",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startsecondClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startsecondClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .endsecondClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.endsecondClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //第三节
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "第三节",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startthirdClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startthirdClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startthirdClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startthirdClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //第四节
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "第四节",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startforthClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startforthClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .endforthClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.endforthClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //第五节
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "第五节",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startfithClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startfithClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .endfithClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.endfithClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //第六节
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "第六节",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startsixthClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startsixthClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startsixthClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startsixthClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //第七节
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "第七节",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startsevenClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startsevenClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .endsevenClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.endsevenClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //第八节
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "第八节",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .starteightClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.starteightClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .endeightClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.endeightClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //第九节
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "第九节",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startnightClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startnightClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .endnightClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.endnightClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //第十节
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "第十节",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("起"),

                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .starttenClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.starttenClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

                                        child: GestureDetector(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("止"),
                                                    Expanded(
                                                      flex: 7,
                                                      child: TextField(
                                                        enabled: false,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .endtenClassController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.endtenClassController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 10, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "关灯时间",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    flex: 19,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:  Container(
                                        width: MediaQuery.of(context).size.width/2-30,
                                        margin: EdgeInsets.only(left:10,top: 5, bottom: 10),
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),

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
                                                        keyboardType:
                                                        TextInputType.number,
                                                        autofocus: false,
                                                        controller: scheduleModel
                                                            .startreadTimeController,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10),
                                                          border: InputBorder.none,
                                                          hintText: "选择时间",
                                                          filled: true,
                                                          fillColor: Color.fromRGBO(
                                                              244, 244, 244, 1),
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
                                                        color: Color.fromRGBO(
                                                            50, 89, 206, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showTimePicker(context,
                                                showTitleActions: true,
                                                theme: DatePickerTheme(
                                                    itemStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                    doneStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16)),
                                                onConfirm: (date) {
                                                  scheduleModel.startreadTimeController.text =new DateFormat("HH:mm").format(date);
                                                },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        )
                                    ),

                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
          inAsyncCall: isAnimating,
          // demo of some additional parameters
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ),
        persistentFooterButtons: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width / 2) - 16,
                height: 60,
                margin: EdgeInsets.only(left: 0),
                child: new MaterialButton(
                  color: Color.fromRGBO(242, 246, 249, 1),
                  height: 60,
                  textColor: Colors.black,
                  child: new Text(
                    '重置',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width / 2),
                child: new MaterialButton(
                  color: Color.fromRGBO(50, 89, 206, 1),
                  height: 60,
                  textColor: Colors.white,
                  child: new Text('确定', style: TextStyle(fontSize: 24)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
        resizeToAvoidBottomPadding: false,
      ),
      onWillPop: () => Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => NavigationKeepAlive()),
          (route) => route == null),
    );
  }
}
