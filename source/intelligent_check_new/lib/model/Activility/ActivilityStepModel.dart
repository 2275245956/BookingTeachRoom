import 'dart:convert' show json;

import 'package:intelligent_check_new/model/CheckExecute/query_point_detail.dart';
//
//class ActivilityStepModel {
//
//  int excuteState;
//  String img;
//  String remark;
//  String riskLevelName;
//  int createDate;
//  int id;
//  int riskLevelId;
//  int serialNum;
//  int taskworkId;
//  String content;
//
//  ActivilityStepModel.fromParams({this.excuteState, this.img, this.remark, this.riskLevelName, this.createDate, this.id, this.riskLevelId, this.serialNum, this.taskworkId, this.content});
//
//  factory ActivilityStepModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ActivilityStepModel.fromJson(json.decode(jsonStr)) : new ActivilityStepModel.fromJson(jsonStr);
//
//  ActivilityStepModel.fromJson(jsonRes) {
//    excuteState = jsonRes['excuteState'];
//    img = jsonRes['img'];
//    remark = jsonRes['remark'];
//    riskLevelName = jsonRes['riskLevelName'];
//    createDate = jsonRes['createDate'];
//    id = jsonRes['id'];
//    riskLevelId = jsonRes['riskLevelId'];
//    serialNum = jsonRes['serialNum'] ?? 0;
//    taskworkId = jsonRes['taskworkId'];
//    content = jsonRes['content'];
//  }
//
//  @override
//  String toString() {
//    return '{"excuteState": $excuteState,"img": ${img != null?'${json.encode(img)}':'null'},"remark": ${remark != null?'${json.encode(remark)}':'null'},"riskLevelName": ${riskLevelName != null?'${json.encode(riskLevelName)}':'null'},"createDate": $createDate,"id": $id,"riskLevelId": $riskLevelId,"serialNum": $serialNum,"taskworkId": $taskworkId,"content": ${content != null?'${json.encode(content)}':'null'}}';
//  }
//}
//
//
//
//
//
//class StepDetailModel {
//
//  int createDate;
//  int executeState;
//  int id;
//  int measuresContentId;
//  int riskFactorsCmId;
//  int taskworkContentId;
//  int violateState;
//  String measuresBasis;
//  String measuresContent;
//  String remerk;
//  String ensurePerson;
//
//  StepDetailModel.fromParams({this.ensurePerson,this.createDate, this.executeState, this.id, this.measuresContentId, this.riskFactorsCmId, this.taskworkContentId, this.violateState, this.measuresBasis, this.measuresContent, this.remerk});
//
//  factory StepDetailModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new StepDetailModel.fromJson(json.decode(jsonStr)) : new StepDetailModel.fromJson(jsonStr);
//
//  StepDetailModel.fromJson(jsonRes) {
//    createDate = jsonRes['createDate'];
//    executeState = jsonRes['executeState'];
//    id = jsonRes['id'];
//    measuresContentId = jsonRes['measuresContentId'];
//    riskFactorsCmId = jsonRes['riskFactorsCmId'];
//    taskworkContentId = jsonRes['taskworkContentId'];
//    violateState = jsonRes['violateState'];
//    measuresBasis = jsonRes['measuresBasis'];
//    measuresContent = jsonRes['measuresContent'];
//    remerk = jsonRes['remerk'];
//    ensurePerson = jsonRes['ensurePerson'];
//  }
//
//  @override
//  String toString() {
//    return '{"createDate": $createDate,"executeState": $executeState,"id": $id,"measuresContentId": ${measuresContent != null?'${json.encode(measuresContent)}':'null'}Id,"riskFactorsCmId": $riskFactorsCmId,"taskworkContentId": $taskworkContentId,"violateState": $violateState,"measuresBasis": ${measuresBasis != null?'${json.encode(measuresBasis)}':'null'},"measuresContent": ${measuresContent != null?'${json.encode(measuresContent)}':'null'},"remerk": ${remerk != null?'${json.encode(remerk)}':'null'},"ensurePerson": ${ensurePerson != null?'${json.encode(ensurePerson)}':'null'}}';
//  }
//}





class StepModel {

  String remark;
  String taskworkLevel;
  int serialNum;
  int taskworkContentId;
  String imgs;
  String taskworkContentName;
  List<StepMeasureModel> taskworkMeasures;
  List<RiskFactorList> riskFactors;
  String uniqueKey;

  StepModel.fromParams({this.uniqueKey,this.riskFactors,this.remark, this.taskworkLevel, this.serialNum, this.taskworkContentId, this.imgs, this.taskworkContentName, this.taskworkMeasures});

  factory StepModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new StepModel.fromJson(json.decode(jsonStr)) : new StepModel.fromJson(jsonStr);

  StepModel.fromJson(jsonRes) {
    remark = jsonRes['remark'];
    taskworkLevel = jsonRes['taskworkLevel'];
    serialNum = jsonRes['serialNum'];
    taskworkContentId = jsonRes['taskworkContentId'];
    imgs = jsonRes['imgs'];
    taskworkContentName = jsonRes['taskworkContentName'];
    taskworkMeasures = jsonRes['taskworkMeasures'] == null ? null : [];

    for (var taskworkMeasuresItem in taskworkMeasures == null ? [] : jsonRes['taskworkMeasures']){
      taskworkMeasures.add(taskworkMeasuresItem == null ? null : new StepMeasureModel.fromJson(taskworkMeasuresItem));
    }

    riskFactors = jsonRes['riskFactors'] == null ? null : [];

    for (var riskFactorListItem in riskFactors == null ? [] : jsonRes['riskFactors']){
      riskFactors.add(riskFactorListItem == null ? null : new RiskFactorList.fromJson(riskFactorListItem));
    }
  }

  @override
  String toString() {
    return '{"remark": ${remark != null?'${json.encode(remark)}':'null'},"taskworkLevel": ${taskworkLevel != null?'${json.encode(taskworkLevel)}':'null'},"serialNum": $serialNum,"taskworkContentId": $taskworkContentId,"imgs": ${imgs != null?'${json.encode(imgs)}':'null'},"taskworkContentName": ${taskworkContentName != null?'${json.encode(taskworkContentName)}':'null'},"taskworkMeasures": $taskworkMeasures}';
  }
}

class StepMeasureModel {

  String remark;
  int executeState;
  int id;
  int violateState;
  String ensurePerson;
  String measuresContent;
  bool showRemark;
  String uniqueKeyForMeasures;

  StepMeasureModel.fromParams({this.remark, this.executeState, this.id, this.violateState, this.ensurePerson, this.measuresContent});

  StepMeasureModel.fromJson(jsonRes) {
    remark = jsonRes['remark'];
    executeState = jsonRes['executeState'];
    id = jsonRes['id'];
    violateState = jsonRes['violateState'];
    ensurePerson = jsonRes['ensurePerson'];
    measuresContent = jsonRes['measuresContent'];
    showRemark=false;
  }

  @override
  String toString() {
    return '{"remark": ${remark != null?'${json.encode(remark)}':'null'},"executeState": $executeState,"id": $id,"violateState": $violateState,"ensurePerson": ${ensurePerson != null?'${json.encode(ensurePerson)}':'null'},"measuresContent": ${measuresContent != null?'${json.encode(measuresContent)}':'null'}}';
  }
}



