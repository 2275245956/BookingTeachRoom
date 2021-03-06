import 'package:intelligent_check_new/model/APIResponse.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:intelligent_check_new/tools/HttpUtil.dart';

Future<APIResponse> getAllTeachApplyLam(int pageNumber) async {
  try {
    var data = await HttpUtil()
        .get(ApiAddress.GETALLTEACH_APPLYLAM + "?pageNum=$pageNumber");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> CheckApplyForTeach(String reqNumber, String status) async {
  try {
    var data = await HttpUtil().post(
        ApiAddress.CheckTeacherApply + "?reqNumber=$reqNumber&status=$status");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> getAllStudentApplyLam(int pageNumber) async {
  try {
    var data = await HttpUtil().get(ApiAddress.GETALLTEACHERPASSEDSTU + "?pageNum=$pageNumber");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}
Future<APIResponse> GetAllCheckStuByStatus(int pageNumber,String status) async {
  try {
    var data = await HttpUtil().get(ApiAddress.GetAllCheckStuByStatus + "?keywords=$status&pageNum=$pageNumber");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}
Future<APIResponse> CheckStuApplyExpAdmin(String reqNumber,int status) async {
  try {
    var data = await HttpUtil().post(ApiAddress.CHECKSTUAPPLY + "?reqNumber=$reqNumber&status=$status");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}


Future<APIResponse>GetAllTeachlambInfoByStatus(String  status) async{
  try {
    var data = await new HttpUtil().get(ApiAddress.GETAllPassedLamInfoByTNumber+"?status=$status");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

