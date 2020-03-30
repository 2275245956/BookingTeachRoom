import 'dart:convert' show json;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intelligent_check_new/model/APIResponse.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:intelligent_check_new/tools/HttpUtil.dart';

Future<APIResponse> getEmptyLam(String startDate, String endDate) async {
  try {
    var data = await HttpUtil()
        .post(ApiAddress.GET_EMPTYLAM + "?sDate=$startDate&eDate=$endDate");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> SaveApplyIfo(dynamic jsonStr) async {
  try {
    var data = await HttpUtil()
        .post(ApiAddress.SAVE_APPLYINFO, data: json.encode(jsonStr));
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> GetAllLambName() async {
  try {
    var data = await HttpUtil().get(ApiAddress.GETALL_LAMBNAME);
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> GetAllRecordByStatus(String tNumber, String status,int pageNum,int pageSize) async {
  try {
    var data = await HttpUtil().get(
        ApiAddress.GETTechAll_RECORDS + "?status=$status&tNumber=$tNumber&pageNum=$pageNum&pageSize=$pageSize");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> GetAllRecordByKeywords(String tNumber, String keywords,pageNum) async {
  try {
    var data = await HttpUtil().get(ApiAddress.GET_RECORDS_keywords +
        "?keywords=$keywords&tNumber=$tNumber&pageNum=$pageNum&pageSize=10");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}



Future<APIResponse> CancelApplyLamb(String reqNumber) async {
  try {
    var data = await new HttpUtil().post(ApiAddress.CANCEL_LAMB + "?reqNumber=$reqNumber");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> GetAllApplyingStudentByTeachNum(String eName,String tNumber,String pageNum)async{
  try {
    var data = await new HttpUtil().get(ApiAddress.GetAllStudentApplying+"?eName=$eName&tNumber=$tNumber&pageNum=$pageNum");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> GetAllApplyedStudentByTeachNum(String tNumber ,String pageNum)async{
  try {
    var data = await new HttpUtil().get(ApiAddress.GetAllStudentApplyed+"?pageNum=$pageNum&tNumber=$tNumber" );
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse>GETAllPassedLamInfoByTNumber({tNumber,eName,rNumber}) async{
  try {
    var url=ApiAddress.GETAllPassedLamInfoByTNumber+"?";
    if(tNumber!=null && tNumber!=""){
      url+="tNumber=$tNumber&";
    }
    if(eName!=null && eName!="" ){
      url+="eName=$eName&";
    }
    if(rNumber!=null && rNumber!="" ){
      url+="rNumber=$rNumber&";
    }
    var data = await new HttpUtil().get(url+"status=3");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}


Future<APIResponse>CheckStudentApplyTeacher(String reqNumber,int status) async{
  try {
    var data = await new HttpUtil().get(ApiAddress.CHECKStuApply+"?reqNumber=$reqNumber&status=$status");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}



Future<APIResponse> UpLoadFile(File file) async{
  try {
  String filename = file.path.substring(file.path.lastIndexOf("/") + 1);
    // 开始上传
    FormData formData = new FormData.from(
        {"file": new UploadFileInfo(file, filename)});
    var data = await new HttpUtil().post("", data: formData);
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

