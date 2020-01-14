import 'package:flutter/material.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetConfig{
  static getTheme() async{
    var pref = await SharedPreferences.getInstance();
    return pref.getString("theme")==null||pref.getString("theme").isEmpty?
            KColorConstant.DEFAULT_COLOR:pref.getString("theme").toString();
  }

  static getLogo() async{
    var pref = await SharedPreferences.getInstance();
    return pref.get("logo")??"";
  }

  static getthemeTimestamp() async{
    var pref = await SharedPreferences.getInstance();
    return pref.get("themeTimestamp")??"";
  }

  static getColor(String theme){
    if(theme=="red"){
      return Color.fromRGBO(209, 6, 24, 1);
    }else if(theme=="blue"){
      return Color.fromRGBO(50, 89, 206, 1);
    }else{
      // 默认红色
      return Color.fromRGBO(209, 6, 24, 1);
    }
  }

  static getRoleDesc(int roleType){
    switch(roleType){
      case 0:
        return "学生";
        break;
      case 1:
        return "教师";
        break;
      case 2:
        return "管理员";
        break;
      case 3:
        return "实验管理员";
        break;
      default:return "未知";
    }
  }
}