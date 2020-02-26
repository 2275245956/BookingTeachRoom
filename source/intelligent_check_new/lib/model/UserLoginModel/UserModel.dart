import 'dart:convert' show json;

class UserModel {
  Object attriNumber01;
  Object attriNumber02;
  Object attriNumber03;
  Object attriText01;
  Object attriText02;
  Object attriText03;
  String email;
  String phoneNumber;
  int id;
  String account;
  String createdDate;
  String deptName;
  String employeeNumber;
  String isUsed;
  String major;
  String password;
  String role;
  String sex;
  String uClass;
  String updatedDate;
  String userName;

  UserModel.fromParams(
      {this.attriNumber01,
      this.attriNumber02,
      this.attriNumber03,
      this.attriText01,
      this.attriText02,
      this.attriText03,
      this.email,
      this.phoneNumber,
      this.id,
      this.account,
      this.createdDate,
      this.deptName,
      this.employeeNumber,
      this.isUsed,
      this.major,
      this.password,
      this.role,
      this.sex,
      this.uClass,
      this.updatedDate,
      this.userName});

  factory UserModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new UserModel.fromJson(json.decode(jsonStr))
          : new UserModel.fromJson(jsonStr);

  UserModel.fromJson(jsonRes) {
    attriNumber01 = jsonRes['attriNumber01'];
    attriNumber02 = jsonRes['attriNumber02'];
    attriNumber03 = jsonRes['attriNumber03'];
    attriText01 = jsonRes['attriText01'];
    attriText02 = jsonRes['attriText02'];
    attriText03 = jsonRes['attriText03'];
    email = jsonRes['email'];
    phoneNumber = jsonRes['phoneNumber'];
    id = jsonRes['id'];
    account = jsonRes['account'];
    createdDate = jsonRes['createdDate'];
    deptName = jsonRes['deptName'];
    employeeNumber = jsonRes['employeeNumber'];
    isUsed = jsonRes['isUsed'];
    major = jsonRes['major'];
    password = jsonRes['password'];
    role = jsonRes['role'];
    sex = jsonRes['sex'];
    uClass = jsonRes['uClass'];
    updatedDate = jsonRes['updatedDate'];
    userName = jsonRes['userName'];
  }

  @override
  String toString() {
    return '{"attriNumber01": $attriNumber01,"attriNumber02": $attriNumber02,"attriNumber03": $attriNumber03,"attriText01": $attriText01,"attriText02": $attriText02,"attriText03": $attriText03,"email": ${email != null ? '${json.encode(email)}' : 'null'},"phoneNumber": ${phoneNumber != null ? '${json.encode(phoneNumber)}' : 'null'},"id": $id,"account": ${account != null ? '${json.encode(account)}' : 'null'},"createdDate": ${createdDate != null ? '${json.encode(createdDate)}' : 'null'},"deptName": ${deptName != null ? '${json.encode(deptName)}' : 'null'},"employeeNumber": ${employeeNumber != null ? '${json.encode(employeeNumber)}' : 'null'},"isUsed": ${isUsed != null ? '${json.encode(isUsed)}' : 'null'},"major": ${major != null ? '${json.encode(major)}' : 'null'},"password": ${password != null ? '${json.encode(password)}' : 'null'},"role": ${role != null ? '${json.encode(role)}' : 'null'},"sex": ${sex != null ? '${json.encode(sex)}' : 'null'},"uClass": ${uClass != null ? '${json.encode(uClass)}' : 'null'},"updatedDate": ${updatedDate != null ? '${json.encode(updatedDate)}' : 'null'},"userName": ${userName != null ? '${json.encode(userName)}' : 'null'}}';
  }
}
