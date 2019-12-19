import 'package:flutter/material.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'dart:async';
import 'package:intelligent_check_new/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();


    new Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (context) => LoginPage(
                  )),
          (route) => route == null);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.asset(
          "assets/images/splash_red.png",
          fit: BoxFit.fitHeight,
          height:  MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
