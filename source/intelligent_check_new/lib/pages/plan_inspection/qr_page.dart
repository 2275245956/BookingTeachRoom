import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:intelligent_check_new/model/plan_inspection/plan_task_detail.dart';
import 'package:intelligent_check_new/pages/CheckExecute/navigation_checkexec.dart';
import 'package:intelligent_check_new/services/no_plan_inspection.dart';
import 'package:intelligent_check_new/services/plan_inspection_services.dart';
import 'package:intelligent_check_new/tools/GetConfig.dart';
import 'package:intelligent_check_new/tools/MessageBox.dart';
//import 'package:last_qr_scanner/last_qr_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:intelligent_check_new/constants/color.dart';


class QrPage extends StatefulWidget{

  final num planTaskId;
  QrPage(this.planTaskId);

  @override
  State<StatefulWidget> createState() => _QrPageState();

}

class _QrPageState extends State<QrPage>{

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QrReaderViewController _controller;

//  QrCamera qrCamera;
  bool camState = false;
  int returnTimes = 0;

  PermissionStatus _permissionStatus = PermissionStatus.unknown;

  PlanTaskDetail initData;
  String theme="blue";


  @override
  void initState() {
    super.initState();
    initConfig();

    // 权限check
    checkPermission().then((v){
      if(v == PermissionStatus.granted){
        setState(() {
          camState = true;
        });
      }else{
        requestPermission().then((v){
          if(_permissionStatus == PermissionStatus.granted){
            setState(() {
              camState = true;
            });
          }else{
            setState(() {
              camState = false;
            });
            MessageBox.showMessageOnly("请授予权限后重新操作！", context);
          }
        });
      }
    });

    // 加载计划数据
    loadData();
  }

  void loadData () async{
    await queryPlanTaskById(this.widget.planTaskId).then((data){
      setState(() {
        initData = data;
      });
    });
  }

  initConfig() async{
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        this.theme = preferences.getString("theme")??KColorConstant.DEFAULT_COLOR;
      });
    });
  }

  //是否有权限
  Future<PermissionStatus> checkPermission() async {
    return await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
  }

//打开权限
  Future<void> requestPermission() async {
    PermissionGroup permission = PermissionGroup.camera;
    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
    await PermissionHandler().requestPermissions(permissions);

    setState(() {
//      print(permissionRequestResult);
      _permissionStatus = permissionRequestResult[permission];
//      print(_permissionStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("二维码扫描",style: TextStyle(color: Colors.black,fontSize: 19),),
        centerTitle: true,
        elevation: 0.2,
        brightness: Brightness.light,
        backgroundColor:  Colors.grey,
        leading:new Container(
          child: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child:Icon(Icons.keyboard_arrow_left, color: Color.fromRGBO(209, 6, 24, 1), size: 32),
          ),
        ),
//        actions: <Widget>[
//          IconButton(icon:ImageIcon(AssetImage("assets/images/noplan/no_plan_torch.png"),size: 30,),
//            onPressed: (){
//            this.controller.toggleTorch();
//          },)
//        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                camState?
//                LastQrScannerPreview(
//                  key: qrKey,
//                  onQRViewCreated: _onQRViewCreated,
//                )
                QrReaderView(
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height,
                    callback: (container) {
                      this._controller = container;
                      _controller.startCamera(onScan);
                    })
                    :new Container(
                  decoration: new BoxDecoration(
                    color: Colors.black,
                  ),
                ),
//                camState?QrCamera(
//                  onError: (context, error) => Text(
//                    error.toString(),
//                    style: TextStyle(color: Colors.red),
//                  ),
//                  qrCodeCallback: (code) {
//                    setState(() {
//                      qrText = code;
//                    });
//                    scan(qrText);
//                  },
//                ):
                Container(
                    height: 40,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 60,right: 60,top:40),
                    child:Container(
//                      padding: EdgeInsets.only(left: 40,top:10),
                      child: Text("对准二维码",style: TextStyle(fontSize: 16,color: Colors.white),),
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.black38,
                      borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                    ),
                    alignment: Alignment.center
                ),
                GestureDetector(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(bottom: 10),),
                        SizedBox(
                          height: 300.0,
                          width: 270.0,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1.0)),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            width: 270.0,
                            height: 1,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    this._controller.setFlashlight();
                  },
                )
              ],
            ),
            flex: 4,
          ),
        ],
      )
    );
  }

//  void _onQRViewCreated(/*QRViewController controller*/) {
//    this.controller = controller;
//    final channel = controller.channel;
//    controller.init(qrKey);
//    channel.setMethodCallHandler((MethodCall call)  async{
//      switch (call.method) {
//        case "onRecognizeQR":
//          controller.pauseScanner();
//          scan(call.arguments.toString());
//      }
//    });
//  }

  void onScan(String v, List<Offset> offsets) {
    if(v != null && v.isNotEmpty){
      setState(() {
        returnTimes = returnTimes + 1;
      });
      if(returnTimes == 1){
        scan(v);
      }
      _controller.stopCamera();
    }
  }

  scan(String code){
    print(code);
    if(code.isNotEmpty){
      getContent(code);
    }else{
      Fluttertoast.showToast(
        msg: '标签内容无法识别！',
        toastLength: Toast.LENGTH_SHORT,
      ).then((v){
        if(this._controller != null){
          setState(() {
            returnTimes = 0;
          });
          this._controller.startCamera(onScan);
        }
      });
    }
  }

  getContent(String no) async{
    if(null == initData){
      Fluttertoast.showToast(
        msg: '计划数据不存在！',
        toastLength: Toast.LENGTH_SHORT,
      ).then((v){
        if(this._controller != null){
          setState(() {
            returnTimes = 0;
          });
          this._controller.startCamera(onScan);
        }
      });
      return;
    }
    int pointNum = initData.points.where((f)=>f.pointNO==no).toList().length;
    if(pointNum <= 0){
      Fluttertoast.showToast(
        msg: '此点非巡检计划中的点，请确认后重新执行！',
        toastLength: Toast.LENGTH_SHORT,
      ).then((v){
        if(this._controller != null){
          setState(() {
            returnTimes = 0;
          });
          this._controller.startCamera(onScan);
        }
      });
      return;
    }

    await getQueryPlanTaskBySerialInfo(1,no,this.widget.planTaskId).then((data){
      // 跳转页面
      if(data != null&& data.success){
        Point _execPoint;
        for(var _point in initData.points){
          if(_point.pointId == data.id){
            _execPoint = _point;
            break;
          }
        }
        if(null == _execPoint){
          Fluttertoast.showToast(
            msg: '此点非巡检计划中的点，请确认后重新执行！',
            toastLength: Toast.LENGTH_SHORT,
          ).then((v){
            if(this._controller != null){
              setState(() {
                returnTimes = 0;
              });
              this._controller.startCamera(onScan);
            }
          });
        }else{
          if(_execPoint.finish != 0){
            Fluttertoast.showToast(
              msg: '该巡检点已执行巡检！',
              toastLength: Toast.LENGTH_SHORT,
            ).then((v){
              if(this._controller != null){
                setState(() {
                  returnTimes = 0;
                });
                this._controller.startCamera(onScan);
              }
            });
            return;
          }
          setState(() {
            camState = false;
          });
          Navigator.push( context,
              new MaterialPageRoute(builder: (context) {
                return NavigationCheckExec(
                    data.id, planId: this.widget.planTaskId,checkMode:"QR");
              })).then((v){
            if(this._controller != null){
              setState(() {
                returnTimes = 0;
              });
              this._controller.startCamera(onScan);
            }
            setState(() {
              camState = true;
            });
            // 重新加载计划数据
            loadData();
          });
        }
      }else{
        Fluttertoast.showToast(
          msg: data.message,
          toastLength: Toast.LENGTH_SHORT,
        ).then((v){
          if(this._controller != null){
            setState(() {
              returnTimes = 0;
            });
            this._controller.startCamera(onScan);
          }
        });
      }
    });
  }
}