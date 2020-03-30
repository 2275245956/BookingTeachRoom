import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intelligent_check_new/pages/navigation_keep_alive.dart';
import 'package:intelligent_check_new/services/SystemService/SystemConfigService.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:file_picker/file_picker.dart';

class FileUpLoad extends StatefulWidget {
  FileUpLoad({Key key}) : super(key: key);

  @override
  _ScheduleSettingPage createState() => new _ScheduleSettingPage();
}

class _ScheduleSettingPage extends State<FileUpLoad> {
  // 当前点的附件
  bool isAnimating = false;
  bool canOperate = true;

  String theme = "red";

  void getFile() async {
    File file =
        await FilePicker.getFile(type: FileType.ANY, fileExtension: "xls");
    var res = await UpLoadFile(file);
    if (res.success) {
      GetConfig.popUpMsg(res.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "文件上传",
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
                  color: GetConfig.getColor(
                      theme) /*Color.fromRGBO(209, 6, 24, 1)*/,
                  size: 32),
            ),
          ),
        ),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Container(
              child: GestureDetector(
                child: Text("上传文件"),
                onTap: () => getFile(),
              ),
            ),
          ),
          inAsyncCall: isAnimating,
          // demo of some additional parameters
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ),
        persistentFooterButtons: <Widget>[],
        resizeToAvoidBottomPadding: false,
      ),
      onWillPop: () => Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => NavigationKeepAlive()),
          (route) => route == null),
    );
  }
}
