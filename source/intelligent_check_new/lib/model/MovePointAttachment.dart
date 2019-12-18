import 'dart:convert';
import 'dart:io';

class Attachment{
  int itemId;
  File file;
  String filePath;
  String name;

  Attachment.fromParams({
    this.itemId,this.file, this.name,this.filePath
  });

  @override
  String toString() {
    return '{"itemId": $itemId,"name":${name != null?'${json.encode(name)}':'null'},"file":$file,"filePath":${filePath != null?'${json.encode(filePath)}':'null'}}';
  }
}