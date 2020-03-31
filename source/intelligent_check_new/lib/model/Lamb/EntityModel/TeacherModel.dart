import 'dart:convert' show json;

class TeachModel {

  Object attriNumber01;
  Object attriNumber02;
  Object attriText02;
  Object tEmail;
  int tId;
  String attriText01;
  String createDate;
  String tName;
  String tNumber;
  String tPass;
  String tRole;
  String updateDate;

  TeachModel.fromParams({this.attriNumber01, this.attriNumber02, this.attriText02, this.tEmail, this.tId, this.attriText01, this.createDate, this.tName, this.tNumber, this.tPass, this.tRole, this.updateDate});

  factory TeachModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new TeachModel.fromJson(json.decode(jsonStr)) : new TeachModel.fromJson(jsonStr);

  TeachModel.fromJson(jsonRes) {
    attriNumber01 = jsonRes['attriNumber01'];
    attriNumber02 = jsonRes['attriNumber02'];
    attriText02 = jsonRes['attriText02'];
    tEmail = jsonRes['tEmail'];
    tId = jsonRes['tId'];
    attriText01 = jsonRes['attriText01'];
    createDate = jsonRes['createDate'];
    tName = jsonRes['tName'];
    tNumber = jsonRes['tNumber'];
    tPass = jsonRes['tPass'];
    tRole = jsonRes['tRole'];
    updateDate = jsonRes['updateDate'];
  }

  @override
  String toString() {
    return '{"attriNumber01": $attriNumber01,"attriNumber02": $attriNumber02,"attriText02": $attriText02,"tEmail": $tEmail,"tId": $tId,"attriText01": ${attriText01 != null?'${json.encode(attriText01)}':'null'},"createDate": ${createDate != null?'${json.encode(createDate)}':'null'},"tName": ${tName != null?'${json.encode(tName)}':'null'},"tNumber": ${tNumber != null?'${json.encode(tNumber)}':'null'},"tPass": ${tPass != null?'${json.encode(tPass)}':'null'},"tRole": ${tRole != null?'${json.encode(tRole)}':'null'},"updateDate": ${updateDate != null?'${json.encode(updateDate)}':'null'}}';
  }
}

