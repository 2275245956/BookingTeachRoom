import 'dart:convert' show json;
import 'dart:convert' show json;

class UserModel {
  bool DeleteFlag;
  bool userLock;
  bool userSex;
  int userType;
  String CreateTime;
  String CreateUserId;
  String LastUpdateTime;
  String LastUpdateUserId;
  String userAccount;
  String userBelongTo;
  String userGrade;
  String userId;
  String userMajor;
  String userMobile;
  String userName;
  String userNumber;
  String userPassword;

  UserModel.fromParams(
      {this.DeleteFlag,
      this.userLock,
      this.userSex,
      this.userType,
      this.CreateTime,
      this.CreateUserId,
      this.LastUpdateTime,
      this.LastUpdateUserId,
      this.userAccount,
      this.userBelongTo,
      this.userGrade,
      this.userId,
      this.userMajor,
      this.userMobile,
      this.userName,
      this.userNumber,
      this.userPassword});

  factory UserModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new UserModel.fromJson(json.decode(jsonStr))
          : new UserModel.fromJson(jsonStr);

  UserModel.fromJson(jsonRes) {
    DeleteFlag = jsonRes['DeleteFlag'];
    userLock = jsonRes['userLock'];
    userSex = jsonRes['userSex'];
    userType = jsonRes['userType'];
    CreateTime = jsonRes['CreateTime'];
    CreateUserId = jsonRes['CreateUserId'];
    LastUpdateTime = jsonRes['LastUpdateTime'];
    LastUpdateUserId = jsonRes['LastUpdateUserId'];
    userAccount = jsonRes['userAccount'];
    userBelongTo = jsonRes['userBelongTo'];
    userGrade = jsonRes['userGrade'];
    userId = jsonRes['userId'];
    userMajor = jsonRes['userMajor'];
    userMobile = jsonRes['userMobile'];
    userName = jsonRes['userName'];
    userNumber = jsonRes['userNumber'];
    userPassword = jsonRes['userPassword'];
  }

  @override
  String toString() {
    return '{"DeleteFlag": $DeleteFlag,"userLock": $userLock,"userSex": $userSex,"userType": $userType,"CreateTime": ${CreateTime != null ? '${json.encode(CreateTime)}' : 'null'},"CreateUserId": ${CreateUserId != null ? '${json.encode(CreateUserId)}' : 'null'},"LastUpdateTime": ${LastUpdateTime != null ? '${json.encode(LastUpdateTime)}' : 'null'},"LastUpdateUserId": ${LastUpdateUserId != null ? '${json.encode(LastUpdateUserId)}' : 'null'},"userAccount": ${userAccount != null ? '${json.encode(userAccount)}' : 'null'},"userBelongTo": ${userBelongTo != null ? '${json.encode(userBelongTo)}' : 'null'},"userGrade": ${userGrade != null ? '${json.encode(userGrade)}' : 'null'},"userId": ${userId != null ? '${json.encode(userId)}' : 'null'},"userMajor": ${userMajor != null ? '${json.encode(userMajor)}' : 'null'},"userMobile": ${userMobile != null ? '${json.encode(userMobile)}' : 'null'},"userName": ${userName != null ? '${json.encode(userName)}' : 'null'},"userNumber": ${userNumber != null ? '${json.encode(userNumber)}' : 'null'},"userPassword": ${userPassword != null ? '${json.encode(userPassword)}' : 'null'}}';
  }
}

class StudentsInfo {
  Object attriNumber01;
  Object attriNumber02;
  Object attriText02;
  String sEmail;
  int sId;
  String attriText01;
  String createDate;
  String sMajor;
  String sName;
  String sNumber;
  String sPass;
  String sRole;
  String updateDate;

  StudentsInfo.fromParams(
      {this.attriNumber01,
      this.attriNumber02,
      this.attriText02,
      this.sEmail,
      this.sId,
      this.attriText01,
      this.createDate,
      this.sMajor,
      this.sName,
      this.sNumber,
      this.sPass,
      this.sRole,
      this.updateDate});

  factory StudentsInfo(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new StudentsInfo.fromJson(json.decode(jsonStr))
          : new StudentsInfo.fromJson(jsonStr);

  StudentsInfo.fromJson(jsonRes) {
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
    return '{"attriNumber01": $attriNumber01,"attriNumber02": $attriNumber02,"attriText02": $attriText02,"sEmail": $sEmail,"sId": $sId,"attriText01": ${attriText01 != null ? '${json.encode(attriText01)}' : 'null'},"createDate": ${createDate != null ? '${json.encode(createDate)}' : 'null'},"sMajor": ${sMajor != null ? '${json.encode(sMajor)}' : 'null'},"sName": ${sName != null ? '${json.encode(sName)}' : 'null'},"sNumber": ${sNumber != null ? '${json.encode(sNumber)}' : 'null'},"sPass": ${sPass != null ? '${json.encode(sPass)}' : 'null'},"sRole": ${sRole != null ? '${json.encode(sRole)}' : 'null'},"updateDate": ${updateDate != null ? '${json.encode(updateDate)}' : 'null'}}';
  }
}
