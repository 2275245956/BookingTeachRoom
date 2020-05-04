import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intelligent_check_new/model/APIResponse.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:intelligent_check_new/tools/HttpUtil.dart';
import 'package:intelligent_check_new/tools/MD5String.dart';

Future<APIResponse> ChangePwq(String newPass,String oldPass,String repeatNewPass,String account ) async {
  try {
    newPass=await Md5Util.generateMd5(newPass);
    oldPass=await Md5Util.generateMd5(oldPass);
    repeatNewPass=await Md5Util.generateMd5(repeatNewPass);
    var data = await HttpUtil()
        .post(ApiAddress.CHANGEPWD + "?newPass=$newPass&oldPass=$oldPass&repeatNewPass=$repeatNewPass&account=$account");
    return APIResponse.fromJson(data);
  } catch (e) {
    throw e;
  }
}

Future<APIResponse> GetTodaysTask(String account,String date,String role) async{
 var data=await HttpUtil().get(ApiAddress.GetTodaysTask+"?account=$account&date=$date&role=$role");
 return APIResponse.fromJson(data);
}
