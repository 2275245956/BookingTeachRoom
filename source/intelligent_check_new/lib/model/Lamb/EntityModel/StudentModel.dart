import 'dart:convert' show json;

class StuModel {

  Object attriNumber01;
  Object attriNumber02;
  Object attriText02;
  Object sEmail;
  int sId;
  String attriText01;
  String createDate;
  String sMajor;
  String sName;
  String sNumber;
  String sPass;
  String sRole;
  String updateDate;

  StuModel.fromParams({this.attriNumber01, this.attriNumber02, this.attriText02, this.sEmail, this.sId, this.attriText01, this.createDate, this.sMajor, this.sName, this.sNumber, this.sPass, this.sRole, this.updateDate});

  factory StuModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new StuModel.fromJson(json.decode(jsonStr)) : new StuModel.fromJson(jsonStr);

  StuModel.fromJson(jsonRes) {
    attriNumber01 = jsonRes['attriNumber01'];
    attriNumber02 = jsonRes['attriNumber02'];
    attriText02 = jsonRes['attriText02'];
    sEmail = jsonRes['sEmail'];
    sId = jsonRes['sId'];
    attriText01 = jsonRes['attriText01'];
    createDate = jsonRes['createDate'];
    sMajor = jsonRes['sMajor'];
    sName = jsonRes['sName'];
    sNumber = jsonRes['sNumber'];
    sPass = jsonRes['sPass'];
    sRole = jsonRes['sRole'];
    updateDate = jsonRes['updateDate'];
  }

  @override
  String toString() {
    return '{"attriNumber01": $attriNumber01,"attriNumber02": $attriNumber02,"attriText02": $attriText02,"sEmail": $sEmail,"sId": $sId,"attriText01": ${attriText01 != null?'${json.encode(attriText01)}':'null'},"createDate": ${createDate != null?'${json.encode(createDate)}':'null'},"sMajor": ${sMajor != null?'${json.encode(sMajor)}':'null'},"sName": ${sName != null?'${json.encode(sName)}':'null'},"sNumber": ${sNumber != null?'${json.encode(sNumber)}':'null'},"sPass": ${sPass != null?'${json.encode(sPass)}':'null'},"sRole": ${sRole != null?'${json.encode(sRole)}':'null'},"updateDate": ${updateDate != null?'${json.encode(updateDate)}':'null'}}';
  }
}

