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

