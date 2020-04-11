import 'dart:convert' show json;

class ExperimentModel {

  Object attriNumber01;
  Object attriNumber02;
  Object attriText01;
  Object attriText02;
  int id;
  String createDate;
  String eName;
  String eNumber;
  String rNumber;
  String updateDate;

  ExperimentModel.fromParams({this.attriNumber01, this.attriNumber02, this.attriText01, this.attriText02, this.id, this.createDate, this.eName, this.eNumber, this.rNumber, this.updateDate});

  factory ExperimentModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ExperimentModel.fromJson(json.decode(jsonStr)) : new ExperimentModel.fromJson(jsonStr);

  ExperimentModel.fromJson(jsonRes) {
    attriNumber01 = jsonRes['attriNumber01'];
    attriNumber02 = jsonRes['attriNumber02'];
    attriText01 = jsonRes['attriText01'];
    attriText02 = jsonRes['attriText02'];
    id = jsonRes['id'];
    createDate = jsonRes['createDate'];
    eName = jsonRes['eName'];
    eNumber = jsonRes['eNumber'];
    rNumber = jsonRes['rNumber'];
    updateDate = jsonRes['updateDate'];
  }

  @override
  String toString() {
    return '{"attriNumber01": $attriNumber01,"attriNumber02": $attriNumber02,"attriText01": $attriText01,"attriText02": $attriText02,"id": $id,"createDate": ${createDate != null?'${json.encode(createDate)}':'null'},"eName": ${eName != null?'${json.encode(eName)}':'null'},"eNumber": ${eNumber != null?'${json.encode(eNumber)}':'null'},"rNumber": ${rNumber != null?'${json.encode(rNumber)}':'null'},"updateDate": ${updateDate != null?'${json.encode(updateDate)}':'null'}}';
  }
}

class ExpModel {

  Object attriNumber02;
  Object attriText02;
  int attriNumber01;
  int eTime;
  int id;
  int rMaxPer;
  int rNowPer;
  int sTime;
  String attriText01;
  String createDate;
  String eDate;
  String eName;
  String rNumber;
  String remark;
  String reqNumber;
  String sDate;
  String section;
  String status;
  String tName;
  String tNumber;
  String updateDate;

  ExpModel.fromParams({this.attriNumber02, this.attriText02, this.attriNumber01, this.eTime, this.id, this.rMaxPer, this.rNowPer, this.sTime, this.attriText01, this.createDate, this.eDate, this.eName, this.rNumber, this.remark, this.reqNumber, this.sDate, this.section, this.status, this.tName, this.tNumber, this.updateDate});

  factory ExpModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ExpModel.fromJson(json.decode(jsonStr)) : new ExpModel.fromJson(jsonStr);

  ExpModel.fromJson(jsonRes) {
    attriNumber02 = jsonRes['attriNumber02'];
    attriText02 = jsonRes['attriText02'];
    attriNumber01 = jsonRes['attriNumber01'];
    eTime = jsonRes['eTime'];
    id = jsonRes['id'];
    rMaxPer = jsonRes['rMaxPer'];
    rNowPer = jsonRes['rNowPer'];
    sTime = jsonRes['sTime'];
    attriText01 = jsonRes['attriText01'];
    createDate = jsonRes['createDate'];
    eDate = jsonRes['eDate'];
    eName = jsonRes['eName'];
    rNumber = jsonRes['rNumber'];
    remark = jsonRes['remark'];
    reqNumber = jsonRes['reqNumber'];
    sDate = jsonRes['sDate'];
    section = jsonRes['section'];
    status = jsonRes['status'];
    tName = jsonRes['tName'];
    tNumber = jsonRes['tNumber'];
    updateDate = jsonRes['updateDate'];
  }

  @override
  String toString() {
    return '{"attriNumber02": $attriNumber02,"attriText02": $attriText02,"attriNumber01": $attriNumber01,"eTime": $eTime,"id": $id,"rMaxPer": $rMaxPer,"rNowPer": $rNowPer,"sTime": $sTime,"attriText01": ${attriText01 != null?'${json.encode(attriText01)}':'null'},"createDate": ${createDate != null?'${json.encode(createDate)}':'null'},"eDate": ${eDate != null?'${json.encode(eDate)}':'null'},"eName": ${eName != null?'${json.encode(eName)}':'null'},"rNumber": ${rNumber != null?'${json.encode(rNumber)}':'null'},"remark": ${remark != null?'${json.encode(remark)}':'null'},"reqNumber": ${reqNumber != null?'${json.encode(reqNumber)}':'null'},"sDate": ${sDate != null?'${json.encode(sDate)}':'null'},"section": ${section != null?'${json.encode(section)}':'null'},"status": ${status != null?'${json.encode(status)}':'null'},"tName": ${tName != null?'${json.encode(tName)}':'null'},"tNumber": ${tNumber != null?'${json.encode(tNumber)}':'null'},"updateDate": ${updateDate != null?'${json.encode(updateDate)}':'null'}}';
  }
}

