import 'package:flutter/material.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:intelligent_check_new/pages/home_layout/home_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBackgroundImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeBackgroundImageState();
  }
}

class _HomeBackgroundImageState extends State<HomeBackgroundImage>{

  String theme = "red";

  @override
  Widget build(BuildContext context) {
    if(this.theme.isEmpty){
      return Scaffold(
          body:Text("")
      );
    }
    return Stack(//第一个子控件最下面
        children: <Widget>[
          SizedBox(
              height: 240.0,
              child:Container(
                color: Color.fromRGBO(218, 37, 30, 1),
                child: Opacity(
                  child: ConstrainedBox(
                    child:Image.asset(
                      "assets/images/home/workspace.png",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                      color: theme=="blue"?Colors.blue[800]:Color.fromRGBO(209, 6, 24, 1),
                    ),
                    constraints: BoxConstraints.expand(),
                  ),
                  opacity: 1,
                ),
              )
          ),
          HomeFunction()
        ]
    );
  }

  @override
  void initState() {
    super.initState();
    initConfig();
  }

  initConfig() async{
    SharedPreferences.getInstance().then((preferences){
      setState(() {
        this.theme = preferences.getString("theme")??KColorConstant.DEFAULT_COLOR;
      });
    });
  }
}