import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intelligent_check_new/constants/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetConfig {
  static getTheme() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString("theme") == null || pref.getString("theme").isEmpty
        ? KColorConstant.DEFAULT_COLOR
        : pref.getString("theme").toString();
  }

  static getLogo() async {
    var pref = await SharedPreferences.getInstance();
    return pref.get("logo") ?? "";
  }

  static getthemeTimestamp() async {
    var pref = await SharedPreferences.getInstance();
    return pref.get("themeTimestamp") ?? "";
  }

  static getColor(String theme) {
    if (theme == "red") {
      return Color.fromRGBO(209, 6, 24, 1);
    } else if (theme == "blue") {
      return Color.fromRGBO(50, 89, 206, 1);
    } else {
      // 默认红色
      return Color.fromRGBO(209, 6, 24, 1);
    }
  }

  static popUpMsg(String msg, {txtColor, bgColor, gravity}) {
    Fluttertoast.showToast(
        msg: msg,
        gravity: gravity ?? ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        textColor: txtColor ?? Colors.white,
        backgroundColor: bgColor ?? Colors.black54);
  }

  static getRoleDesc(String roleType) {
    switch (roleType) {
      case "student":
        return "学生";
        break;
      case "teacher":
        return "教师";
        break;
      case "admin":
        return "管理员";
        break;
      case "expAdmin":
        return "实验管理员";
        break;
      default:
        return "未知";
    }
  }

  static getScheduleDesc(String num) {
    switch (num) {
      case "read":
        return "早读时间";
      case "first":
        return "第一节";
      case "second":
        return "第二节";
      case "third":
        return "第三节";
      case "forth":
        return "第四节";
      case "fifth":
        return "第五节";
      case "sixth":
        return "第六节";
      case "seventh":
        return "第七节";
      case "eight":
        return "第八节";
      case "ninth":
        return "第九节";
      case "tenth":
        return "第十节";
      case "sleep":
        return "熄灯";
    }
  }
}
