import 'dart:convert' show json;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intelligent_check_new/model/APIResponse.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:intelligent_check_new/tools/HttpUtil.dart';

Future<APIResponse> getEmptyLam(String startDate,String endDate) async{
  try{
    var data=await HttpUtil().post(ApiAddress.GET_EMPTYLAM+"?sDate=$startDate&eDate=$endDate");
    return APIResponse.fromJson(data);
  }catch(e){
    throw e;
  }

}

Future<APIResponse> SaveApplyIfo(dynamic jsonStr) async{
  try{
    var data=await HttpUtil().post(ApiAddress.SAVE_APPLYINFO,data:json.encode(jsonStr));
    return APIResponse.fromJson(data);
  }catch(e){
    throw e;
  }

}

Future<APIResponse>GetAllLambName()async{
  try{
    var data=await HttpUtil().get(ApiAddress.GETALL_LAMBNAME);
    return APIResponse.fromJson(data);
  }catch(e){
    throw e;
  }

}
