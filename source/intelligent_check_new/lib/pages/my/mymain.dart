 import 'package:flutter/material.dart';
import 'package:intelligent_check_new/pages/navigation_keep_alive.dart';

class MyMainPage extends StatefulWidget{
  @override
  _MyMainPageState createState() => new _MyMainPageState();
}
class _MyMainPageState extends State<MyMainPage> {

//  TextEditingController usernameController = new TextEditingController();
//  TextEditingController passwordController = new TextEditingController();
//  bool displayPassword = false;
//  bool isAnimating = false;
//  bool isSavePassword = false;
  final usericon = Image.asset('assets/images/login/2.0x/username_red.png');

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(10.0),
      child: new Row(
        children: [
              new Column(
                children: <Widget>[
                  new Container(
                    child: usericon,
                  )
                ],
              ),

              Padding(padding: EdgeInsets.only(left:5.0)),

              new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    '王多余',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  '中科集团/生产部',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

//  login(String userName,String password,bool savePassword)async{
//    Navigator.of(context).pushAndRemoveUntil(
//        new MaterialPageRoute(
//            builder: (context) => NavigationKeepAlive()),
//            (route) => route == null);
//  }

  @override
  void initState() {
    super.initState();
  }
}