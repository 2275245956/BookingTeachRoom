import 'dart:convert' show json;

class ContractInfo {

  String id;
  String key;
  String value;
  String writeable;
  String attributes;
  String desc;
  String label;
  String name;
  String state;
  String title;
  String type;
  String telephone;
  String departmentName;
  String email;
  List<ChildInfo> children;
  String mobile;
  String parentId;

  ContractInfo();
  ContractInfo.fromParams({this.parentId,this.id, this.key, this.value, this.writeable, this.attributes, this.desc, this.label, this.name, this.state, this.title, this.type,this.telephone,this.departmentName,this.email,this.mobile});

//  factory ContractInfo(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ContractInfo.fromJson(json.decode(jsonStr)) : new ContractInfo.fromJson(jsonStr);

  ContractInfo.fromJson(jsonRes) {
    id = jsonRes['id'];
    key = jsonRes['key'];
    value = jsonRes['value'];
    writeable = jsonRes['writeable'];
    attributes = jsonRes['attributes'];
    desc = jsonRes['desc'];
    label = jsonRes['label'];
    name = jsonRes['name'];
    state = jsonRes['state'];
    title = jsonRes['title'];
    type = jsonRes['type'];
    departmentName = jsonRes['departmentName'];
    email = jsonRes['email'];
    telephone = jsonRes['telephone'];
    mobile = jsonRes['mobile'];
    parentId=jsonRes["parentId"];
  }

  @override
  String toString() {
    return '{"id": $id,"key": $key,"value": $value,"writeable": $writeable,"attributes": ${attributes != null?'${json.encode(attributes)}':'null'},"desc": ${desc != null?'${json.encode(desc)}':'null'},"label": ${label != null?'${json.encode(label)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"state": ${state != null?'${json.encode(state)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'},"telephone": ${telephone != null?'${json.encode(telephone)}':'null'}}';
  }
}

class ChildInfo {

  String id;
  String key;
  String value;
  String writeable;
  bool checked;
  String desc;
  String label;
  String name;
  String state;
  String title;
  String type;
  String userName;
  String departmentName;
  String telephone;
  String email;
  String mobile;
  List<ChildInfo> children;
  String parentId;

  bool isSelected=false;

  ChildInfo.fromParams({this.parentId,this.id, this.key, this.value, this.writeable, this.checked, this.desc, this.label, this.name, this.state, this.title, this.type, this.userName,this.telephone,this.departmentName,this.email,this.mobile,this.isSelected=false,this.children});

  factory ChildInfo(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ChildInfo.fromJson(json.decode(jsonStr)) : new ChildInfo.fromJson(jsonStr);

  ChildInfo.fromJson(jsonRes) {
    id = jsonRes['id'];
    key = jsonRes['key'];
    value = jsonRes['value'];
    writeable = jsonRes['writeable'];
    checked = jsonRes['checked'];
    desc = jsonRes['desc'];
    label = jsonRes['label'];
    name = jsonRes['name'];
    state = jsonRes['state'];
    title = jsonRes['title'];
    type = jsonRes['type'];
    userName = jsonRes['userName'];
    departmentName = jsonRes['departmentName'];
    email = jsonRes['email'];
    telephone = jsonRes['telephone'];
    mobile = jsonRes['mobile'];
    parentId=jsonRes["parentId"];
  }

  @override
  String toString() {
    return '{"id": $id,"key": $key,"value": $value,"writeable": $writeable,"checked": $checked,"desc": ${desc != null?'${json.encode(desc)}':'null'},"label": ${label != null?'${json.encode(label)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"state": ${state != null?'${json.encode(state)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'},"userName": ${userName != null?'${json.encode(userName)}':'null'},"telephone": ${telephone != null?'${json.encode(telephone)}':'null'},"mobile": ${mobile != null?'${json.encode(mobile)}':'null'},"isSelected":$isSelected}';
  }
}