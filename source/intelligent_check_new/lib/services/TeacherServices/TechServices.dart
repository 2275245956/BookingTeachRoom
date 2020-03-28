import 'dart:convert' show json;
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
    var data =new HttpUtil().post(ApiAddress.CANCEL_LAMB + "?reqNumber=$reqNumber");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> GetAllApplyingStudentByTeachNum()async{
  try {
    var data =new HttpUtil().post(ApiAddress.GetAllStudentApplying );
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> GetAllApplyedStudentByTeachNum()async{
  try {
    var data =new HttpUtil().post(ApiAddress.GetAllStudentApplyed );
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}


