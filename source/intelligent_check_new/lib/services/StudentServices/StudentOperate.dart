import 'dart:convert' show json;
import 'package:intelligent_check_new/model/APIResponse.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:intelligent_check_new/tools/HttpUtil.dart';

//列表查询
Future<APIResponse> stuLogin(String userName,String pwd, String roleType) async {
  try{
    var data = await HttpUtil().post(ApiAddress.USER_LOGIN+"?name=$userName&pass=$pwd&role=$roleType" );
    return APIResponse.fromJson(data);
  }catch(e){throw e;}
}

Future<APIResponse> GetAllPassedTeacherlambs(String sNumber,String pageNum)async{
  try{
    var data = await HttpUtil().get(ApiAddress.GETALLPASSEDLAMS+"?sNumber=$sNumber&pageNum=$pageNum" );
    return APIResponse.fromJson(data);
  }catch(e){throw e;}
}

Future<APIResponse> StudentCancelApply(String reqNumber)async{
  try{
    var data = await HttpUtil().post(ApiAddress.STUCANCELAPPLY+"?reqNumber=$reqNumber" );
    return APIResponse.fromJson(data);
  }catch(e){throw e;}
}

Future<APIResponse> StuSaveApplyInfo(dynamic jsonStr) async {
  try {
    var data = await HttpUtil().post(ApiAddress.STUAPPLYLAMB, data: json.encode(jsonStr));
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> StuApplyRecord(String sNumber) async {
  try {
    var data = await HttpUtil().get(ApiAddress.STUAPPLYRECORD+"?sNumber=$sNumber");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}