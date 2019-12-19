import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intelligent_check_new/model/CompanyInfo.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/hidden_danger_found.dart';
import 'package:intelligent_check_new/pages/navigation_keep_alive.dart';
import 'package:intelligent_check_new/services/company_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelCompanyAndDept extends StatefulWidget {
  bool isSelect;

  SelCompanyAndDept({this.isSelect = false});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelCompanyAndDept();
  }
}

class _SelCompanyAndDept extends State<SelCompanyAndDept> {
  List<CompanyInfos> comList = new List();
  Map<String, List<DeptInfo>> deptMap = new Map();
  Map<String, List<Role>> roleMap = new Map();

  CompanyInfos selectedCompany;
  DeptInfo selectedeDept;
  Role selectedRlole;

//  Map selResult=new Map();

  @override
  Widget build(BuildContext context) {
    if (comList == null || comList.length <= 0) {
      return new Scaffold(
        appBar: AppBar(
          title: Text(
            "公司部门角色选择",
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
      );
    }
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "公司部门角色选择",
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
      body: new Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        selectedCompany == null
                            ? "请选择公司"
                            : selectedCompany.companyName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 0),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
                onTap: () {
                  companyDialog();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        selectedeDept == null
                            ? "请选择部门"
                            : selectedeDept.departmentName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 0),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
                onTap: () {
                  departmentDialog();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        selectedRlole == null
                            ? "请选择角色"
                            : selectedRlole.roleName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 0),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
                onTap: () {
                  roleDialog();
                },
              )
            ],
          ),
          alignment: Alignment.center,
        ),
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
                onPressed: () {
                  setState(() {
                    selectedeDept = null;
                    selectedRlole = null;
                    selectedCompany = null;
                  });
                },
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width / 2),
              child: new MaterialButton(
                color: Color.fromRGBO(50, 89, 206, 1),
                height: 60,
                textColor: Colors.white,
                child: new Text('确定', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  //必填项判断
                  if (selectedCompany != null && selectedRlole != null) {
                    var jsonStr = {
                      "company": json.decode(selectedCompany.toString()),
                      "department": json.decode(selectedeDept.toString()),
                      "role": json.decode(selectedRlole.toString())
                    };
                    saveSelect(jsonStr);
                  } else {
                    HiddenDangerFound.popUpMsg("请完成选择!");
                  }
                },
              ),
            ),
          ],
        ),
      ],
      resizeToAvoidBottomPadding: false,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initData();
  }

  initData() async {
    await getLogInInfo().then((data) {
      if(mounted){
        setState(() {
          comList = data.coms;
          deptMap = data.deptInfos;
          roleMap = data.roleInfo;
          //角色可以和部门关联  也可以和公司关联      公司和角色是必须有的
          if (comList.length == 1 && roleMap.length == 1) {
            selectedCompany = comList[0];
            selectedeDept = null;
            if (deptMap.length >= 1) {
              //有部门的情况下
              selectedeDept = deptMap[selectedCompany.sequenceNbr][0];
              selectedRlole = roleMap[selectedeDept.sequenceNbr][0];
            } else {
              selectedRlole = roleMap[selectedCompany.sequenceNbr][0];
            }
            var jsonStr = {
              "company": json.decode(selectedCompany.toString()),
              "department": json.decode(selectedeDept.toString()),
              "role": json.decode(selectedRlole.toString())
            };
            if (!this.widget.isSelect) saveSelect(jsonStr);
          }
        });

      }
    });
  }

  companyDialog() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return comList != null
            ? SimpleDialog(
                children: comList.map((f) {
                  return Column(
                    children: <Widget>[
                      new SimpleDialogOption(
                        child: new Text(f.companyName),
                        onPressed: () {
                          setState(() {
                            selectedCompany = f;
                            //                      selResult["selCom"]=f;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(
                        height: 1,
                      )
                    ],
                  );
                }).toList(),
              )
            : Container();
      },
    );
  }

  departmentDialog() {
    if (selectedCompany == null) {
      HiddenDangerFound.popUpMsg("请先选择公司！", gravity: ToastGravity.TOP);
      return Container();
    }

    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return deptMap[selectedCompany.sequenceNbr] != null
            ? SimpleDialog(
                children: deptMap[selectedCompany.sequenceNbr].map((f) {
                  return Column(
                    children: <Widget>[
                      new SimpleDialogOption(
                        child: new Text(f.departmentName),
                        onPressed: () {
                          setState(() {
                            selectedeDept = f;
//                      selResult["selDept"]=f;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(
                        height: 1,
                      )
                    ],
                  );
                }).toList(),
              )
            : Container();
      },
    );
  }

  roleDialog() {
    if (selectedCompany == null) {
      HiddenDangerFound.popUpMsg("请先选择公司！", gravity: ToastGravity.TOP);
      return Container();
    }
    //未选择部门
    else if (selectedeDept == null) {
      if (roleMap[selectedCompany.sequenceNbr] == null) {
        HiddenDangerFound.popUpMsg("用户在该公司下没有分配角色，\n请先选择部门！",
            gravity: ToastGravity.TOP);
        return Container();
      }
      showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return roleMap[selectedCompany.sequenceNbr] != null
              ? SimpleDialog(
                  children: roleMap[selectedCompany.sequenceNbr].map((f) {
                    return Column(
                      children: <Widget>[
                        new SimpleDialogOption(
                          child: new Text(f.roleName),
                          onPressed: () {
                            setState(() {
                              selectedRlole = f;
//                      selResult["selRole"]=f;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    );
                  }).toList(),
                )
              : Container();
        },
      );
    } else {
      //选择部门

      if (roleMap[selectedeDept.sequenceNbr] == null) {
        HiddenDangerFound.popUpMsg("用户在该部门下没有分配角色！", gravity: ToastGravity.TOP);
        return Container();
      }
      showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return roleMap[selectedeDept.sequenceNbr] != null
              ? SimpleDialog(
                  children: roleMap[selectedeDept.sequenceNbr].map((f) {
                    return Column(
                      children: <Widget>[
                        new SimpleDialogOption(
                          child: new Text(f.roleName),
                          onPressed: () {
                            setState(() {
                              selectedRlole = f;
//                      selResult["selRole"]=f;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    );
                  }).toList(),
                )
              : Container();
        },
      );
    }
  }

  saveSelect(jsonData) async {
    await saveSeleCom(jsonData).then((data) {
      if (data) {
        SharedPreferences.getInstance().then((preferences) {
          preferences.setString("companyList", comList.toString());
          preferences.setString("sel_com", selectedCompany.toString());
          preferences.setString("sel_dept",
              selectedeDept == null ? "" : selectedeDept.toString());
          preferences.setString("sel_role", selectedRlole.toString());
        });
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => NavigationKeepAlive()),
            (route) => route == null);
      } else {
        HiddenDangerFound.popUpMsg("选择失败");
      }
    });
  }
}
