import 'dart:convert' show json;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:intelligent_check_new/model/APIResponse.dart';
import 'package:intelligent_check_new/model/Hidden_Danger/hidden_danger_model.dart';
import 'package:intelligent_check_new/model/MovePointAttachment.dart';

import 'package:intelligent_check_new/model/PageDto.dart';
import 'package:intelligent_check_new/model/Task/TaskAddModel.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/hidden_Inspection_danger_add.dart';
import 'package:intelligent_check_new/pages/hidedanger_manage/hidden_danger_found.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:intelligent_check_new/tools/HttpUtil.dart';
import 'package:path_provider/path_provider.dart';

//列表查询
Future<APIResponse> stuLogin(var jsonStr, int roleType) async {
  String requestUrl = "";
  switch (roleType) {
    case 0:
      requestUrl = ApiAddress.STUDENT_LOGIN;
      break;
    case 1:
      requestUrl = ApiAddress.TEACHER_LOGIN;
      break;
    case 2:
      requestUrl = ApiAddress.ADMIN_LOGIN;
      break;
    case 3:
      requestUrl = ApiAddress.EXPADMIN_LOGIN;
      break;
  }
  var data = await HttpUtil().post(requestUrl, data: json.encode(jsonStr));

  return APIResponse.fromJson(data);
}
