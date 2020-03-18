import 'dart:convert' show json;
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
