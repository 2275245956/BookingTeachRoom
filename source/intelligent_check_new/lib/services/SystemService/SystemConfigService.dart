import 'dart:convert' show json;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intelligent_check_new/model/APIResponse.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:intelligent_check_new/tools/HttpUtil.dart';

//保存
Future<APIResponse> saveConfigInfo(Object jsonStr) async {
  try {
    var data = await HttpUtil().post(ApiAddress.SCHEDULE_CONFIG +
        "?key=schedule&value=${json.encode(jsonStr)}");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> getConfigValueByKey(String key) async{
  try{
    var data=await HttpUtil().get(ApiAddress.GETSYSTEM_CONFIGBYKEY+"?key=$key");
    return APIResponse.fromJson(data);
  }catch(e){
    throw e;
  }

}



Future<APIResponse> UpLoadFile(File file) async{
  try {
    String filename = file.path.substring(file.path.lastIndexOf("/") + 1);
    // 开始上传
    FormData formData = new FormData.from(
        {"file": new UploadFileInfo(file, filename)});
    var data = await new HttpUtil().post(ApiAddress.UPFILE, data: formData);
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

