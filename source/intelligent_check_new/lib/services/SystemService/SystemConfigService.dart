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

    if(file==null)return APIResponse.error("未选择文件");

    String filename = file.path.substring(file.path.lastIndexOf("/") + 1);
    // 开始上传
    FormData formData = new FormData.from(
        {"file": new UploadFileInfo(file, filename)});
    var data = await new HttpUtil().post(ApiAddress.UPFILE, data: formData);
    return APIResponse.fromJson(data);

}

Future<APIResponse> getAllMessage(String  account) async{
  try {
    var data = await new HttpUtil().get(ApiAddress.GetAllMessage+"?account=$account");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> readAllMessage(int  id) async{
  try {
    var data = await new HttpUtil().get(ApiAddress.ReadMessage+"?id=$id");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> getAllUser(String keywords,String  pageNum) async{
  try {
    var data = await new HttpUtil().get(ApiAddress.GETALLUSER+"?keywords=$keywords&pageNum=$pageNum");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> DELETEUSERS(String  account) async{
  try {
    var data = await new HttpUtil().post(ApiAddress.DELETEUSER+"?account=$account");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> EditUSER(dynamic jsonData) async{
  try {
    var data = await new HttpUtil().post(ApiAddress.UPDATEUSER,data: json.encode(jsonData));
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> ADDUSER(dynamic jsonData) async{
  try {
    var data = await new HttpUtil().post(ApiAddress.ADDUSER,data: json.encode(jsonData));
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> GETALLLAMBS() async{
  try{
    var data=await new HttpUtil().get(ApiAddress.ALLLAMS);
    return APIResponse.fromJson(data);
  }catch(e){
    throw e;
  }
}

Future<APIResponse> AddLamb(dynamic jsonData) async{
  try{
    var data=await new HttpUtil().post(ApiAddress.ADDLAMB,data: json.encode(jsonData));
    return APIResponse.fromJson(data);
  }catch(e){
    throw e;
  }

}

Future<APIResponse> UpLambInfo(dynamic jsonData) async{
  try{
    var data=await new HttpUtil().post(ApiAddress.UPDATELMABINFO,data: json.encode(jsonData));
    return APIResponse.fromJson(data);
  }catch(e){
    throw e;
  }
}

Future<APIResponse> DeleteLamb(int id) async{
  try{
    var data=await new HttpUtil().post(ApiAddress.DELETELAMB+"?id=$id");
    return APIResponse.fromJson(data);
  }catch(e){
    throw e;
  }
}