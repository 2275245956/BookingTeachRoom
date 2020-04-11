import 'dart:convert' show json;
import 'dart:convert';
import 'package:intelligent_check_new/model/APIResponse.dart';
import 'package:intelligent_check_new/pages/ApplyLamb_teacher/ApplyLambInfo.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:intelligent_check_new/tools/HttpUtil.dart';

Future<APIResponse> getEmptyLam(String sDate,String sTime, String eDate,String eTime) async {
  try {
    var stime=int.parse(sTime);
    var etime=int.parse(eTime);
    var data = await HttpUtil()
        .post(ApiAddress.GET_EMPTYLAM + "?sDate=$sDate&sTime=$stime&eDate=$eDate&eTime=$etime");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> SaveApplyIfo(dynamic jsonDate) async {
  try {
    var data = await HttpUtil()
        .post(ApiAddress.SAVE_APPLYINFOS, data:json.encode(jsonDate));
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
    var jsonStr={
      "eName":eName,
      "tNumber":tNumber,
      "pageNum":pageNum

    };
    var data = await new HttpUtil().post(ApiAddress.GetAllStudentApplying+"?tNumber=$tNumber",data: json.encode(jsonStr));
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
    var data = await new HttpUtil().post(ApiAddress.CHECKStuApply+"?reqNumber=$reqNumber&status=${status.toString()}");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}


Future<APIResponse> GetExpModdel(String reqNumber)async{
  var data = await new HttpUtil().get(ApiAddress.GetExpModel+"?reqNumber=$reqNumber");
  return APIResponse.fromJson(data);
}
