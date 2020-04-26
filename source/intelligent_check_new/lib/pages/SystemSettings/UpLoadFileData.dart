import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intelligent_check_new/model/UserLoginModel/UserModel.dart';
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
  List<UserModel> upUserList = new List();
  String theme = "red";

  void getFile() async {
    setState(() {
      upUserList=new List();
      isAnimating = true;
      canOperate = false;
    });

    try {
      File file =
          await FilePicker.getFile(type: FileType.ANY, fileExtension: "xls");
      var res = await UpLoadFile(file);
      if (res.success) {
        for (var jStr in res.dataList) {
          setState(() {
            upUserList.add(UserModel.fromJson(jStr));
          });
        }
      }else{
        GetConfig.popUpMsg(res.message??"上传失败！");
      }
    } catch (e) {
      throw e;
    } finally {
      setState(() {
        isAnimating = false;
        canOperate = true;
      });
    }

    setState(() {
      isAnimating = false;
      canOperate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "人员信息批量增加",
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
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          elevation: 5,
          label: Text("上传文件"),
          onPressed: () => getFile(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "说明：选择符合格式要求的excel文件上传！",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: GetConfig.getColor(theme), fontSize: 12),
                    ),
                  ),
                  Divider(),
                  upUserList!=null &&upUserList.length>0?Container(
                    alignment: Alignment.centerLeft,
                    child: Text("上传列表：上传成功 ${upUserList.length} 条数据",style: TextStyle(fontSize: 18),),
                  ):Container(),
                  upUserList!=null &&upUserList.length>0?Divider():Container(),
                  Container(
                    child: Column(
                      children: upUserList.map((f) {
                        return Container(
                          padding: EdgeInsets.only(left: 10,right: 10,),
                          child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text("姓名：${f.userName}"),
                                ),
                                Container(
                                  child: Text("账号：${f.account}"),
                                ),
                                Divider()
                              ],
                            ) 
                        );
                      }).toList(),
                    ),
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
        resizeToAvoidBottomPadding: true,
      ),
      onWillPop: () => Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => NavigationKeepAlive()),
          (route) => route == null),
    );
  }
}
