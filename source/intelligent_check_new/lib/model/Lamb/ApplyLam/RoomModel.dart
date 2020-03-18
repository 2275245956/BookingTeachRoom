import 'dart:convert' show json;

class RoomModel {

  Object attriNumber01;
  Object attriNumber02;
  int id;
  int rMaxPer;
  String attriText01;
  String attriText02;
  String createDate;
  String rName;
  String rNumber;
  String updateDate;

  RoomModel.fromParams({this.attriNumber01, this.attriNumber02, this.id, this.rMaxPer, this.attriText01, this.attriText02, this.createDate, this.rName, this.rNumber, this.updateDate});

  factory RoomModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RoomModel.fromJson(json.decode(jsonStr)) : new RoomModel.fromJson(jsonStr);

  RoomModel.fromJson(jsonRes) {
    attriNumber01 = jsonRes['attriNumber01'];
    attriNumber02 = jsonRes['attriNumber02'];
    id = jsonRes['id'];
    rMaxPer = jsonRes['rMaxPer'];
    attriText01 = jsonRes['attriText01'];
    attriText02 = jsonRes['attriText02'];
    createDate = jsonRes['createDate'];
    rName = jsonRes['rName'];
    rNumber = jsonRes['rNumber'];
    updateDate = jsonRes['updateDate'];
  }

  @override
  String toString() {
    return '{"attriNumber01": $attriNumber01,"attriNumber02": $attriNumber02,"id": $id,"rMaxPer": $rMaxPer,"attriText01": ${attriText01 != null?'${json.encode(attriText01)}':'null'},"attriText02": ${attriText02 != null?'${json.encode(attriText02)}':'null'},"createDate": ${createDate != null?'${json.encode(createDate)}':'null'},"rName": ${rName != null?'${json.encode(rName)}':'null'},"rNumber": ${rNumber != null?'${json.encode(rNumber)}':'null'},"updateDate": ${updateDate != null?'${json.encode(updateDate)}':'null'}}';
  }
}

