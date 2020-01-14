import 'package:intelligent_check_new/model/no_plan_inspection/NoPlanPlanInfo.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:intelligent_check_new/tools/HttpUtil.dart';

//Future<List<NoPlanPlanInfo>> getQueryPlanTaskBySerialInfo(num dataType,String serial) async{
//
//  List<NoPlanPlanInfo> rst = List();
//  var data = await HttpUtil().get(ApiAddress.QUERY_PLANT_ASK_BY_SERIAL,data:{"dataType":dataType,"serial":serial});
//  if(data["result"] == "SUCCESS"){
//    if(data["dataList"].toString()!="[]"){
//      for(var _info in data["dataList"]){
//        rst.add(NoPlanPlanInfo.fromJson(_info));
//      }
//    }
//  }
//  return rst;
//}

Future<NoPlanPlanInfo> getQueryPlanTaskBySerialInfo(num dataType,String serial,num planTaskId) async{

  NoPlanPlanInfo rst;
  var data;
  if(planTaskId != null){
    data = await HttpUtil().get(ApiAddress.QUERY_PLANT_ASK_BY_SERIAL,data:{"dataType":dataType,"serial":serial,"planTaskId":planTaskId});
  }else{
    data = await HttpUtil().get(ApiAddress.QUERY_PLANT_ASK_BY_SERIAL,data:{"dataType":dataType,"serial":serial});
  }
//  var data = await HttpUtil().get(ApiAddress.QUERY_PLANT_ASK_BY_SERIAL,data:{"dataType":dataType,"serial":serial,"planTaskId":planTaskId});
//  var data = await HttpUtil().get(ApiAddress.QUERY_PLANT_ASK_BY_SERIAL,data:{"serial":serial});
  if(data["result"] == "SUCCESS"){
    if(data["dataList"].toString()!="[]" && data["dataList"].toString()!="null"){
      rst = NoPlanPlanInfo.fromJson(data["dataList"]);
      rst.success = true;
      rst.message="";
    }
  }else{
    rst = NoPlanPlanInfo.fromParams();
    rst.success = false;
    rst.message = data["message"];
  }
  return rst;
}