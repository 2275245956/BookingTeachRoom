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
