import 'dart:convert' show json;
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
