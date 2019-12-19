import 'package:flutter/material.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:intelligent_check_new/constants/system_config.dart';
import 'package:intelligent_check_new/pages/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intelligent_check_new/services/CommonService.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(MyApp());
Color globalTheme;
void main() async{

  SharedPreferences.getInstance().then((pref){
    pref.setString("theme", "red");
  }).then((v){
    runApp(MyApp());
  });

}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp>{

  Color globalTheme;

  @override
  void initState() {
    super.initState();
    globalTheme = SystemConfig.THEME_COLOR;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '实验预约',
      theme: ThemeData(
        primarySwatch: globalTheme,
      ),
      debugShowCheckedModeBanner: true,
      home: SplashScreen(),
      localizationsDelegates: [                             //此处
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [                                   //此处
        const Locale('zh','CH'),
        const Locale('en','US'),
      ],
    );
  }
}


