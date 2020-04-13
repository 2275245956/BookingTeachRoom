import 'dart:convert' show json;
//
//class SubscribeInfo{
//  List<CheckPlan> checks;
//  List<CheckPlan> plans;
//  List<CheckPlan> emails;
//}
//class CheckPlan {
//
//  String attribute3;
//  String attribute4;
//  String attribute5;
//  int createDate;
//  int id;
//  String attribute1;
//  String attribute2;
//  String msgType;
//  String orgCode;
//  String userId;
//  String userName;
//
//  CheckPlan.fromParams({this.attribute3, this.attribute4, this.attribute5, this.createDate, this.id, this.attribute1, this.attribute2, this.msgType, this.orgCode, this.userId, this.userName});
//
//  factory CheckPlan(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CheckPlan.fromJson(json.decode(jsonStr)) : new CheckPlan.fromJson(jsonStr);
//
//  CheckPlan.fromJson(jsonRes) {
//    attribute3 = jsonRes['attribute3'];
//    attribute4 = jsonRes['attribute4'];
//    attribute5 = jsonRes['attribute5'];
//    createDate = jsonRes['createDate'];
//    id = jsonRes['id'];
//    attribute1 = jsonRes['attribute1'];
//    attribute2 = jsonRes['attribute2'];
//    msgType = jsonRes['msgType'];
//    orgCode = jsonRes['orgCode'];
//    userId = jsonRes['userId'];
//    userName = jsonRes['userName'];
//  }
//
//  @override
//  String toString() {
//    return '{"attribute3": ${attribute3 != null?'${json.encode(attribute3)}':'null'},"attribute4": ${attribute4 != null?'${json.encode(attribute4)}':'null'},"attribute5": ${attribute5 != null?'${json.encode(attribute5)}':'null'},"createDate": $createDate,"id": $id,"attribute1": ${attribute1 != null?'${json.encode(attribute1)}':'null'},"attribute2": ${attribute2 != null?'${json.encode(attribute2)}':'null'},"msgType": ${msgType != null?'${json.encode(msgType)}':'null'},"orgCode": ${orgCode != null?'${json.encode(orgCode)}':'null'},"userId": ${userId != null?'${json.encode(userId)}':'null'},"userName": ${userName != null?'${json.encode(userName)}':'null'}}';
//  }
//}
//
//class ItemInfo {
//
//  String code;
//  String message;
//  String ower;
//
//  ItemInfo.fromParams({this.code, this.message, this.ower});
//
//  factory ItemInfo(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ItemInfo.fromJson(json.decode(jsonStr)) : new ItemInfo.fromJson(jsonStr);
//
//  ItemInfo.fromJson(jsonRes) {
//    code = jsonRes['code'];
//    message = jsonRes['message'];
//    ower = jsonRes['ower'];
//  }
//
//  @override
//  String toString() {
//    return '{"code": ${code != null?'${json.encode(code)}':'null'},"message": ${message != null?'${json.encode(message)}':'null'},"ower": ${ower != null?'${json.encode(ower)}':'null'}}';
//  }
//}



class SubscribeInfo {

  List<SubItem> check;
  List<SubItem> plan;
  List<SubItem> email;

  SubscribeInfo.fromParams({this.check,this.plan,this.email});

  factory SubscribeInfo(jsonStr) => jsonStr == null ? null : jsonStr is String ? new SubscribeInfo.fromJson(json.decode(jsonStr)) : new SubscribeInfo.fromJson(jsonStr);

  SubscribeInfo.fromJson(jsonRes) {
    check  = jsonRes['check'] == null ? null : [];

    for (var checkItem in check == null ? [] : jsonRes['check']){
      check.add(checkItem == null ? null : new SubItem.fromJson(checkItem));
    }

    plan  = jsonRes['plan'] == null ? null : [];

    for (var planItem in plan == null ? [] : jsonRes['plan']){
      plan.add(planItem == null ? null : new SubItem.fromJson(planItem));
    }

    email = jsonRes['email'] == null ? null : [];

    for (var emailItem in email == null ? [] : jsonRes['email']){
      email.add(emailItem == null ? null : new SubItem.fromJson(emailItem));
    }
  }

  @override
  String toString() {
    return '{"check": $check}';
  }
}

class SubItem {

  int createDate;
  int id;
  String attribute1;
  String attribute2;
  String attribute3;
  String attribute4;
  String attribute5;
  String msgType;
  String orgCode;
  String userId;
  String userName;

  SubItem.fromParams({this.createDate, this.id, this.attribute1, this.attribute2, this.attribute3, this.attribute4, this.attribute5, this.msgType, this.orgCode, this.userId, this.userName});

  SubItem.fromJson(jsonRes) {
    createDate = jsonRes['createDate'];
    id = jsonRes['id'];
    attribute1 = jsonRes['attribute1'];
    attribute2 = jsonRes['attribute2'];
    attribute3 = jsonRes['attribute3'];
    attribute4 = jsonRes['attribute4'];
    attribute5 = jsonRes['attribute5'];
    msgType = jsonRes['msgType'];
    orgCode = jsonRes['orgCode'];
    userId = jsonRes['userId'];
    userName = jsonRes['userName'];
  }

  @override
  String toString() {
    return '{"createDate": $createDate,"id": $id,"attribute1": ${attribute1 != null?'${json.encode(attribute1)}':'null'},"attribute2": ${attribute2 != null?'${json.encode(attribute2)}':'null'},"attribute3": ${attribute3 != null?'${json.encode(attribute3)}':'null'},"attribute4": ${attribute4 != null?'${json.encode(attribute4)}':'null'},"attribute5": ${attribute5 != null?'${json.encode(attribute5)}':'null'},"msgType": ${msgType != null?'${json.encode(msgType)}':'null'},"orgCode": ${orgCode != null?'${json.encode(orgCode)}':'null'},"userId": ${userId != null?'${json.encode(userId)}':'null'},"userName": ${userName != null?'${json.encode(userName)}':'null'}}';
  }
}

class MessageModel {

  Object attriText01;
  Object attriText02;
  Object attriText03;
  Object reason;
  int id;
  bool readed;
  String createdBy;
  String createdDate;
  String message;
  String messagetype;
  String receiver;
  String reqnumber;
  String role;
  String updatedDate;

  MessageModel.fromParams({this.attriText01, this.attriText02, this.attriText03, this.reason, this.id, this.readed, this.createdBy, this.createdDate, this.message, this.messagetype, this.receiver, this.reqnumber, this.role, this.updatedDate});

  factory MessageModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MessageModel.fromJson(json.decode(jsonStr)) : new MessageModel.fromJson(jsonStr);

  MessageModel.fromJson(jsonRes) {
    attriText01 = jsonRes['attriText01'];
    attriText02 = jsonRes['attriText02'];
    attriText03 = jsonRes['attriText03'];
    reason = jsonRes['reason'];
    id = jsonRes['id'];
    readed = jsonRes['readed'];
    createdBy = jsonRes['createdBy'];
    createdDate = jsonRes['createdDate'];
    message = jsonRes['message'];
    messagetype = jsonRes['messagetype'];
    receiver = jsonRes['receiver'];
    reqnumber = jsonRes['reqnumber'];
    role = jsonRes['role'];
    updatedDate = jsonRes['updatedDate'];
  }

  @override
  String toString() {
    return '{"attriText01": $attriText01,"attriText02": $attriText02,"attriText03": $attriText03,"reason": $reason,"id": $id,"readed": $readed,"createdBy": ${createdBy != null?'${json.encode(createdBy)}':'null'},"createdDate": ${createdDate != null?'${json.encode(createdDate)}':'null'},"message": ${message != null?'${json.encode(message)}':'null'},"messagetype": ${messagetype != null?'${json.encode(messagetype)}':'null'},"receiver": ${receiver != null?'${json.encode(receiver)}':'null'},"reqnumber": ${reqnumber != null?'${json.encode(reqnumber)}':'null'},"role": ${role != null?'${json.encode(role)}':'null'},"updatedDate": ${updatedDate != null?'${json.encode(updatedDate)}':'null'}}';
  }
}

