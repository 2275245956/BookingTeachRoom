import 'dart:convert' show json;

class StuApplyModel {

  Object attriNumber01;
  Object attriNumber02;
  Object attriText01;
  Object attriText02;
  int id;
  String createDate;
  String eEndtime;
  String eName;
  String eNumber;
  String eStarttime;
  String eTName;
  String remark;
  String reqNumber;
  String sMajor;
  String sName;
  String sNumber;
  String status;
  String updateDate;


  StuApplyModel.fromParams({this.attriNumber01, this.attriNumber02, this.attriText01, this.attriText02, this.id, this.createDate, this.eEndtime, this.eName, this.eNumber, this.eStarttime, this.eTName, this.remark, this.reqNumber, this.sMajor, this.sName, this.sNumber, this.status, this.updateDate});

  factory StuApplyModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new StuApplyModel.fromJson(json.decode(jsonStr)) : new StuApplyModel.fromJson(jsonStr);

  StuApplyModel.fromJson(jsonRes) {
    attriNumber01 = jsonRes['attriNumber01'];
    attriNumber02 = jsonRes['attriNumber02'];
    attriText01 = jsonRes['attriText01'];
    attriText02 = jsonRes['attriText02'];
    id = jsonRes['id'];
    createDate = jsonRes['createDate'];
    eEndtime = jsonRes['eEndtime'];
    eName = jsonRes['eName'];
    eNumber = jsonRes['eNumber'];
    eStarttime = jsonRes['eStarttime'];
    eTName = jsonRes['eTName'];
    remark = jsonRes['remark'];
    reqNumber = jsonRes['reqNumber'];
    sMajor = jsonRes['sMajor'];
    sName = jsonRes['sName'];
    sNumber = jsonRes['sNumber'];
    status = jsonRes['status'];
    updateDate = jsonRes['updateDate'];
  }

  @override
  String toString() {
    return '{"attriNumber01": $attriNumber01,"attriNumber02": $attriNumber02,"attriText01": $attriText01,"attriText02": $attriText02,"id": $id,"createDate": ${createDate != null?'${json.encode(createDate)}':'null'},"eEndtime": ${eEndtime != null?'${json.encode(eEndtime)}':'null'},"eName": ${eName != null?'${json.encode(eName)}':'null'},"eNumber": ${eNumber != null?'${json.encode(eNumber)}':'null'},"eStarttime": ${eStarttime != null?'${json.encode(eStarttime)}':'null'},"eTName": ${eTName != null?'${json.encode(eTName)}':'null'},"remark": ${remark != null?'${json.encode(remark)}':'null'},"reqNumber": ${reqNumber != null?'${json.encode(reqNumber)}':'null'},"sMajor": ${sMajor != null?'${json.encode(sMajor)}':'null'},"sName": ${sName != null?'${json.encode(sName)}':'null'},"sNumber": ${sNumber != null?'${json.encode(sNumber)}':'null'},"status": ${status != null?'${json.encode(status)}':'null'},"updateDate": ${updateDate != null?'${json.encode(updateDate)}':'null'}}';
  }
}

