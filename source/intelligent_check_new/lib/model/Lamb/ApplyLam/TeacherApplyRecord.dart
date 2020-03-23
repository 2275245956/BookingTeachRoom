import 'dart:convert' show json;

class TeacherApplyRecord {

  Object attriNumber01;
  Object attriNumber02;
  Object attriText02;
  int id;
  int rMaxPer;
  int rNowPer;
  String attriText01;
  String createDate;
  String eDate;
  String eName;
  String rNumber;
  String remark;
  String reqNumber;
  String section;
  String status;
  String tName;
  String tNumber;
  String updateDate;

  TeacherApplyRecord.fromParams({this.attriNumber01, this.attriNumber02, this.attriText02, this.id, this.rMaxPer, this.rNowPer, this.attriText01, this.createDate, this.eDate, this.eName, this.rNumber, this.remark, this.reqNumber, this.section, this.status, this.tName, this.tNumber, this.updateDate});

  factory TeacherApplyRecord(jsonStr) => jsonStr == null ? null : jsonStr is String ? new TeacherApplyRecord.fromJson(json.decode(jsonStr)) : new TeacherApplyRecord.fromJson(jsonStr);

  TeacherApplyRecord.fromJson(jsonRes) {
    attriNumber01 = jsonRes['attriNumber01'];
    attriNumber02 = jsonRes['attriNumber02'];
    attriText02 = jsonRes['attriText02'];
    id = jsonRes['id'];
    rMaxPer = jsonRes['rMaxPer'];
    rNowPer = jsonRes['rNowPer'];
    attriText01 = jsonRes['attriText01'];
    createDate = jsonRes['createDate'];
    eDate = jsonRes['eDate'];
    eName = jsonRes['eName'];
    rNumber = jsonRes['rNumber'];
    remark = jsonRes['remark'];
    reqNumber = jsonRes['reqNumber'];
    section = jsonRes['section'];
    status = jsonRes['status'];
    tName = jsonRes['tName'];
    tNumber = jsonRes['tNumber'];
    updateDate = jsonRes['updateDate'];
  }

  @override
  String toString() {
    return '{"attriNumber01": $attriNumber01,"attriNumber02": $attriNumber02,"attriText02": $attriText02,"id": $id,"rMaxPer": $rMaxPer,"rNowPer": $rNowPer,"attriText01": ${attriText01 != null?'${json.encode(attriText01)}':'null'},"createDate": ${createDate != null?'${json.encode(createDate)}':'null'},"eDate": ${eDate != null?'${json.encode(eDate)}':'null'},"eName": ${eName != null?'${json.encode(eName)}':'null'},"rNumber": ${rNumber != null?'${json.encode(rNumber)}':'null'},"remark": ${remark != null?'${json.encode(remark)}':'null'},"reqNumber": ${reqNumber != null?'${json.encode(reqNumber)}':'null'},"section": ${section != null?'${json.encode(section)}':'null'},"status": ${status != null?'${json.encode(status)}':'null'},"tName": ${tName != null?'${json.encode(tName)}':'null'},"tNumber": ${tNumber != null?'${json.encode(tNumber)}':'null'},"updateDate": ${updateDate != null?'${json.encode(updateDate)}':'null'}}';
  }
}

