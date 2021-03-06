import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:intelligent_check_new/model/version.dart';
import 'package:intelligent_check_new/pages/custom_setting_page.dart';
import 'package:intelligent_check_new/pages/navigation_keep_alive.dart';
import 'package:intelligent_check_new/services/StudentServices/StudentOperate.dart';
import 'package:intelligent_check_new/services/SystemService/SystemConfigService.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/tools/MD5String.dart';
import 'package:intelligent_check_new/tools/MessageBox.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool displayPassword = false;
  bool isAnimating = false;
  bool isSavePassword = false;

  String ErrorMsg = "";
  var loginState = false;
  int count = 0;
  String roleType =null;
  int roleSel=null;
  Version _version;

//  bool loginButtonEnable = true;
  PermissionStatus _permissionStatus = PermissionStatus.unknown;
  String theme = "red";

  @override
  Widget build(BuildContext context) {
    if (this.theme.isEmpty) {
      return Scaffold(body: Text(""));
    }
    final logo = new Column(
      children: <Widget>[
        Container(
          width: 130.0,
          height: 130.0,
          //  margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(65.0)),
              image: DecorationImage(
                  image: ExactAssetImage('assets/images/login/logo_red.png'),
                  fit: BoxFit.cover)),
        ),
//        Image.asset(
//          'assets/images/login/logo_red.png',
//          width: 130.0,
//          height: 119.0,
//        ),
        Text(
          '实验室预约系统',
          style: new TextStyle(
              color: Color.fromRGBO(209, 6, 24, 1),
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Laboratory Appointment System',
          style: new TextStyle(
              color: Color.fromRGBO(209, 6, 24, 1),
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
        ),
      ],
    );

    final username = TextField(
        controller: usernameController,
        autofocus: false,
        style: TextStyle(fontSize: 18.0, color: Colors.black),
        decoration: new InputDecoration(
//          prefixIcon: new Icon(Icons.perm_identity,color: Colors.black26,size: 26,),
          prefixIcon: Image.asset(
            'assets/images/login/username_red.png',
            scale: 1.5,
          ),
          border: InputBorder.none,
          hintText: '请输入用户名',
          hintStyle: TextStyle(fontSize: 18.0, color: Colors.black12),
          contentPadding: EdgeInsets.all(13.0),
        ));

    final usernameFinal = new Container(
        decoration: new BoxDecoration(
          color: Color.fromRGBO(247, 249, 250, 1),
          border: new Border.all(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: new BorderRadius.all(Radius.circular(5)),
        ),
        child: new Container(child: username));

    final password = TextField(
        controller: passwordController,
        autofocus: false,
        style: TextStyle(fontSize: 18.0, color: Colors.black),
        obscureText: !displayPassword,
        decoration: new InputDecoration(
          prefixIcon: Image.asset(
            'assets/images/login/password_red.png',
            scale: 1.5,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                displayPassword = !displayPassword;
              });
            },
            child: displayPassword
                ? Image.asset(
                    'assets/images/login/display_password_red.png',
                    scale: 1.2,
                  )
                : Image.asset(
                    'assets/images/login/hide_password.png',
                    scale: 1.2,
                    color: Colors.grey[350],
                  ),
          ),
          border: InputBorder.none,
          hintText: '密码',
          hintStyle: TextStyle(fontSize: 18.0, color: Colors.black12),
          contentPadding: EdgeInsets.all(13.0),
        ));

    final passwordFinal = new Container(
        decoration: new BoxDecoration(
          color: Color.fromRGBO(247, 249, 250, 1),
          border: new Border.all(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: new BorderRadius.all(Radius.circular(5)),
        ),
        child: new Container(child: password));

    final userRoleFinal = new Container(
        padding: EdgeInsets.all(3),
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          color: Color.fromRGBO(247, 249, 250, 1),
          border: new Border.all(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: new BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.folder_shared,
                size: 23,
                color: Color.fromRGBO(209, 6, 24, 1),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 90,
              padding: EdgeInsets.only(left: 10),
              child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                items: [
                  new DropdownMenuItem(
                    child: new Text(
                      '学生',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    value:0,
                  ),
                  new DropdownMenuItem(
                    child: new Text(
                      '教师',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    value:1,
                  ),
                  new DropdownMenuItem(
                    child: new Text(
                      '管理员',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    value: 2,
                  ),
                  new DropdownMenuItem(
                    child: new Text(
                      '实验管理员',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    value: 3,
                  ),
                ],
                hint: new Text(
                  '请选择登陆角色',
                  style: TextStyle(
                    color: Colors.black12,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    roleSel = value;

                    switch(roleSel){
                      case 0:
                        roleType="student";
                        break;
                      case 1:
                        roleType="teacher";
                        break;
                      case 2:
                        roleType="admin";
                        break;
                      case 3:
                        roleType="expAdmin";
                        break;
                      default:
                        roleType=null;
                          break;

                    }
                  });
                },
                value: roleSel,
                elevation: 24,

                style: new TextStyle(
                  fontSize: 18,
                ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                iconSize: 40.0,
                iconEnabledColor: Colors.black12,
              )),
            )
          ],
        ));
    final loginButton = Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () {
            this.ErrorMsg = "";

            if (this.usernameController.text.isEmpty ||
                this.passwordController.text.isEmpty) {
              //MessageBox.showMessageOnly("用户名密码不能为空！", context);
              setState(() {
                this.ErrorMsg = "用户名密码不能为空！";
              });
              return;
            }
            if (roleType == null) {
              setState(() {
                this.ErrorMsg = "请选择登陆角色！";
              });

              return;
            }
            login(this.usernameController.text, this.passwordController.text,
                isSavePassword);
          },
          padding: EdgeInsets.all(10),
//        color: Color.fromRGBO(218, 37, 30, 1),
          color: Color.fromRGBO(209, 6, 24, 1),
          child: Text('登录',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              side: BorderSide(style: BorderStyle.none)),
        ));
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 246, 249, 1),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Stack(//第一个子控件最下面
                children: <Widget>[
              SizedBox(
                  height: 230.0,
                  child: Container(
//                    color: Colors.grey,
                    child: Opacity(
                      child: ConstrainedBox(
                        child: Image.asset(
                          "assets/images/home/workspace.png",
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
//                            color: Colors.white,
                        ),
                        constraints: BoxConstraints.expand(),
                      ),
                      opacity: 1,
                    ),
                  )),
              GestureDetector(
                child: Container(
//                    height: 30,
//                    width:double.infinity,
                  child: Icon(Icons.settings,color: GetConfig.getColor(theme),),
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(top: 40, right: 16),
                ),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new CustomSettingPage();
                  }));
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 80),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: logo,
                      onTap: () {},
                    ),

                    SizedBox(height: 40.0),
                    usernameFinal,
                    SizedBox(height: 8.0),
                    passwordFinal,
                    SizedBox(height: 8.0),
                    userRoleFinal,

                    Stack(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: <Widget>[
                                    new Checkbox(
                                      value: isSavePassword,
                                      activeColor:
                                          Color.fromRGBO(209, 6, 24, 1),
                                      onChanged: (bool val) {
//                          // val 是布尔值
                                        this.setState(() {
                                          this.isSavePassword = val;
                                        });
                                      },
                                    ),
                                    Text("记住密码",
                                        style: TextStyle(
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: 15.0,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    ErrorMsg,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                          ),
                          alignment: FractionalOffset.centerLeft,
                        ),

//                          loginResultText()
                      ],
                    ),
//            SizedBox(height: 24.0),
                    loginButton,
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height - 30),
                child: Text(
                  "西安航空职业技术学院 © " +
                      DateTime.now().year.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(153, 153, 153, 1)),
                ),
              )
            ]),
          ),
          inAsyncCall: isAnimating,
          opacity: 0.7,
          progressIndicator: CircularProgressIndicator(),
        ));
  }

  login(String userName, String password, bool savePassword) async {
    setState(() {
      isAnimating = true;
    });

    String md5Password = await Md5Util.generateMd5(password);

    try {
     await stuLogin(userName, md5Password, roleType).then((data) {
        if (data.success) {
          SharedPreferences.getInstance().then((sp) {
            if (savePassword) {
              sp.setString("userName", userName);
              sp.setString("userPwd", password);
            }
            sp.setString("userRole",roleType);
            var userJson = json.encode(data.dataList[0]);
            sp.setString("userModel", userJson);

            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                    builder: (context) => NavigationKeepAlive()),
                    (route) => route == null);
          });
        }
        else {
          MessageBox.popUpMsg(data.message ?? "登陆失败",
              gravity: ToastGravity.BOTTOM);
        }

        setState(() {
          isAnimating = false;
        });
      });

     getConfigValueByKey("schedule").then((data){

       var jsonStr=data.dataList[0]["configValue"];
       SharedPreferences.getInstance().then((sp){
         sp.setString("schedule", jsonStr);
       });
     });



    } catch (e) {
      this.ErrorMsg = "登录异常，请稍后重试！";
      setState(() {
        isAnimating = false;
      });
    }
  }

  @override
  void didUpdateWidget(LoginPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    //强制竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    loginStateText = "";
    getTheme();
    getUserNameAndPassword();
    //checkUpdate();
  }

  @override
  void dispose() {
    //取消强制竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    super.dispose();
  }

  getUserNameAndPassword() async {
    await SharedPreferences.getInstance().then((preferences) {
      String loginUser = preferences.getString("userName");
      if (loginUser != null && loginUser.isNotEmpty) {
        this.usernameController.text = loginUser;
      }
      String loginPassword = preferences.getString("userPwd");
      if (loginPassword != null && loginPassword.isNotEmpty) {
        this.passwordController.text = loginPassword;
        setState(() {
          this.isSavePassword = true;
        });
      }
    });
  }
//
////  // 更新============================================================================
////  checkUpdate() async {
////    final prefs = await SharedPreferences.getInstance();
//////    print(prefs.getString("updateUrl"));
////    String updateUrl =
////        prefs.getString("updateUrl") ?? ApiAddress.DEFAULT_UPDATE_URL;
////    if (updateUrl == null || updateUrl.isEmpty) {
////      return;
////    } else {
////      await checkNewVersion(updateUrl).then((version) {
////        setState(() {
////          _version = version;
////        });
////        if (_version != null) {
////          PackageInfo.fromPlatform().then((packageInfo) {
////            if (_version.version.compareTo(packageInfo.version) == 1) {
////              if (_version.constraint) {
////                setState(() {
////                  this.loginButtonEnable = false;
////                });
////              }
////              startUpdate();
////            } else {
//////              initData();
////              setState(() {
////                this.loginButtonEnable = true;
////              });
////            }
////          });
////        } else {
////          // 更新文件获取失败、不进行更新
////        }
////      });
////    }
////  }
////
////  startUpdate() {
////    _askedToUpdate(_version).then((result) {
////      if (result != null && result) {
////        showDialog(
////            context: context,
////            barrierDismissible: false,
////            builder: (_) => new AlertDialog(
////                  content: Container(
////                      height: 100,
////                      width: 50,
////                      child: Center(
////                        child: Wrap(
////                          spacing: 10.0,
////                          runSpacing: 16.0,
////                          children: <Widget>[
////                            AnimatedRotationBox(
////                              child: GradientCircularProgressIndicator(
////                                radius: 15.0,
////                                colors: [
////                                  Colors.blue[300],
////                                  Colors.blue,
////                                  Colors.grey[50]
////                                ],
////                                value: .8,
////                                backgroundColor: Colors.transparent,
////                              ),
////                            ),
////                            Text("更新中，请稍后。。。")
////                          ],
////                        ),
////                      )),
////                ));
////
////        // 选择更新
////        if (defaultTargetPlatform == TargetPlatform.android) {
////          PackageInfo.fromPlatform().then((packageInfo) {
//////            if(_version.version.compareTo(packageInfo.version) == 1){
////            // 服务器版本大于当前版本
////            checkPermission().then((permissionStatus) {
////              if (permissionStatus == PermissionStatus.granted) {
////                executeDownload();
////              } else {
////                requestPermission().then((permissionRst) {
////                  checkPermission().then((permissionStatus) {
////                    if (permissionStatus == PermissionStatus.granted) {
////                      executeDownload();
////                    } else {
////                      // 权限申请失败
////                      // 不进行处理
////                      setState(() {
////                        _permissionStatus = PermissionStatus.denied;
////                      });
////                    }
////                  });
////                });
////              }
////            });
//////            }else{
//////              //服务器版本小于当前版本,不更新
//////            }
////          });
////        } else {
////          // 非安卓平台
////        }
////      } else {
////        // 非强制更新并且客户选择不更新,正常执行原有逻辑
//////        initData();
////        setState(() {
////          this.loginButtonEnable = true;
////        });
////      }
////    });
////  }
//
//  //是否有权限
//  Future<PermissionStatus> checkPermission() async {
//    return await PermissionHandler()
//        .checkPermissionStatus(PermissionGroup.storage);
//  }
//
////打开权限
//  Future<Map<PermissionGroup, PermissionStatus>> requestPermission() async {
//    return await PermissionHandler()
//        .requestPermissions([PermissionGroup.storage]);
//  }
//
//  // 获取安装地址
//  Future<String> get _apkLocalPath async {
//    final directory = await getExternalStorageDirectory();
//    return directory.path;
//  }
//
//// 下载
//  Future<void> executeDownload() async {
//    final path = await _apkLocalPath;
//    //下载
//    final taskId = await FlutterDownloader.enqueue(
//        url: _version.apkUrl,
//        savedDir: path,
//        fileName: "实验预约",
//        showNotification: true,
//        openFileFromNotification: true);
//
//    FlutterDownloader.registerCallback((id, status, progress) {
//      // 当下载完成时，调用安装
//      if (taskId == id && status == DownloadTaskStatus.complete) {
//        OpenFile.open(path);
//        FlutterDownloader.open(taskId: id);
//      }
//    });
//  }
//
//  Future<bool> _askedToUpdate(Version version) async {
//    return showDialog(
//        context: context,
//        barrierDismissible: false,
//        builder: (context) => AlertDialog(
//              title: Text('发现新版本是否更新？'),
//              content: Container(
//                  width: 100,
//                  height: 200,
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text("更新内容:"),
//                      Padding(
//                        padding: EdgeInsets.only(bottom: 10),
//                      ),
//                      Text(version.updateInfo)
//                    ],
//                  )),
//              actions: <Widget>[
//                version.constraint
//                    ? FlatButton(
//                        child: Text('确定'),
//                        onPressed: () => Navigator.pop(context, true),
//                      )
//                    : Row(
//                        children: <Widget>[
//                          FlatButton(
//                            child: Text('暂不'),
//                            onPressed: () => Navigator.pop(context, false),
//                          ),
//                          FlatButton(
//                            child: Text('确定'),
//                            onPressed: () => Navigator.pop(context, true),
//                          ),
//                        ],
//                      )
//              ],
//            ));
//  }

  // 获取主题
  getTheme() async {
    await SharedPreferences.getInstance().then((pref) {
      setState(() {
        this.theme = pref.getString("theme") ?? KColorConstant.DEFAULT_COLOR;
      });
    });
  }
}

class loginResultText extends StatefulWidget {
  @override
  _loginResultTextState createState() => _loginResultTextState();
}

String loginStateText = "";

class _loginResultTextState extends State<loginResultText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(loginStateText,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.0,
          )),
      padding: EdgeInsets.only(top: 10),
      alignment: FractionalOffset.centerRight,
    );
  }
}
