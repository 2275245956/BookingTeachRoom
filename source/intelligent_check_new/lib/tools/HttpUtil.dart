//import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intelligent_check_new/services/api_address.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:xfzb_manage/model/login_user.dart';
//import 'package:xfzb_manage/utils/token_util.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  Options options;

//  String serverUrl="";

  static HttpUtil getInstance() {
    print('getInstance');
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    print('dio赋值');
    // 或者通过传递一个 `options`来创建dio实例
    options = Options(
      // 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: "",
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 10000,
      headers: {},
    );
    dio = new Dio(options);
  }

  get(url, {data, options, cancelToken, isAuth = false}) async {
//    final pref = await SharedPreferences.getInstance();
//    String serverUrl = pref.getString("serverUrl");
//    String token = await new TokenUtil().getToken();

    final pref = await SharedPreferences.getInstance();
    String serverUrl;
    if (isAuth) {
      serverUrl = pref.getString("authServerUrl")??ApiAddress.DEFAULT_AUTH_API_URL; //ApiAddress.AUTH_API_URL;
    } else {
      serverUrl = pref.getString("bizServerUrl")??ApiAddress.DEFAULT_BIZ_API_URL; //ApiAddress.BIZ_API_URL;
    }
    print('get请求启动! serverUrl：' + serverUrl + url + ',body: $data');
    String token = pref.get("user_token");
    print(token);
    Response response;
    try {
      response = await dio.get(
          serverUrl + url,
          data: data,
          cancelToken: cancelToken,
          options: Options(
              headers: {"X-From-Service": true, "X-Access-Token": token})
      );
      print('get请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
//        Fluttertoast.showToast(
//          msg: '数据请求被取消! ',
//          toastLength: Toast.LENGTH_LONG,
//        );
      }
      print('get请求发生错误：$e');
//      Fluttertoast.showToast(
//        msg: '数据请求发生错误！',
//        toastLength: Toast.LENGTH_LONG,
//      );
      throw e;
    }
    return response.data;
  }

  getForUpdate(url, {data, options, cancelToken,useLocalUrl=true}) async {

    final pref = await SharedPreferences.getInstance();
    String serverUrl = "";
    if(useLocalUrl){
      serverUrl = pref.getString("serverUrl");
    }
    String token = pref.get("user_token");

    print('get请求启动! serverUrl：'+serverUrl+url+',body: $data');

    Response response;
    try {
      response = await dio.get(
          serverUrl + url,
          data: data,
          cancelToken: cancelToken,
          options:Options(headers: {"Authentication":token})
      );
      print('get请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
//        Fluttertoast.showToast(
//          msg: '数据请求被取消! ',
//          toastLength: Toast.LENGTH_LONG,
//        );
      }
//      print('get请求发生错误：$e');
//      Fluttertoast.showToast(
//        msg: '数据请求发生错误！',
//        toastLength: Toast.LENGTH_LONG,
//      );
      throw e;
    }
    return response.data;
  }

  post(url, {data, options, cancelToken, isAuth = false}) async {

    final pref = await SharedPreferences.getInstance();
    String serverUrl;
    if (isAuth) {
      serverUrl = pref.getString("authServerUrl")??ApiAddress.DEFAULT_AUTH_API_URL; //ApiAddress.AUTH_API_URL;
    } else {
      serverUrl = pref.getString("bizServerUrl")??ApiAddress.DEFAULT_BIZ_API_URL; //ApiAddress.BIZ_API_URL;
    }
    print('post请求启动! serverUrl：' + serverUrl + url + ',body: $data');

//    print('post请求启动! url：$url ,body: $data');

    String token = pref.get("user_token");
    print(token);
    Response response;
    try {
      response = await dio.post(
          serverUrl + url,
          data: data,
          cancelToken: cancelToken,
          options: Options(headers: {"X-From-Service": true, "X-Access-Token": token})
      );
      if(response==null)
        print("请求不成功 response为null");
      print('post请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return response.data;
  }

  put(url, {data, options, cancelToken, isAuth = false}) async {
//    final pref = await SharedPreferences.getInstance();
//    String serverUrl = pref.getString("serverUrl");
//    LoginUser user = LoginUser.fromJson(json.decode(pref.getString("localUserInfo")));
//    String token = user == null?"":user.userToken;
//    print('get请求启动! token is：'+token);

    final pref = await SharedPreferences.getInstance();
    String serverUrl;
    if (isAuth) {
      serverUrl = pref.getString("authServerUrl")??ApiAddress.DEFAULT_AUTH_API_URL; //ApiAddress.AUTH_API_URL;
    } else {
      serverUrl = pref.getString("bizServerUrl")??ApiAddress.DEFAULT_BIZ_API_URL; //ApiAddress.BIZ_API_URL;
    }
//    String serverUrl = ApiAddress.API_URL;
    //print('get请求启动! serverUrl：' + serverUrl + url + ',body: $data');

    print('post请求启动! url：$url ,body: $data');
    String token = pref.get("user_token");
    Response response;
    try {
      response = await dio.put(
//        serverUrl + url +"?Authentication="+token,
          serverUrl + url,
          data: data,
          cancelToken: cancelToken,
          options: Options(
              headers: {"X-From-Service": true, "X-Access-Token": token})
      );
      print('put请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('put请求取消! ' + e.message);
      }
      print('put请求发生错误：$e');
    }
    return response.data;
  }

  delete(url, {data, options, cancelToken, isAuth = false}) async {
//    final pref = await SharedPreferences.getInstance();
//    String serverUrl = pref.getString("serverUrl");
//    LoginUser user = LoginUser.fromJson(json.decode(pref.getString("localUserInfo")));
//    String token = user == null?"":user.userToken;
//    print('get请求启动! token is：'+token);

//    String serverUrl = ApiAddress.API_URL;
    final pref = await SharedPreferences.getInstance();
    String serverUrl;
    if (isAuth) {
      serverUrl = pref.getString("authServerUrl")??ApiAddress.DEFAULT_AUTH_API_URL; //ApiAddress.AUTH_API_URL;
    } else {
      serverUrl = pref.getString("bizServerUrl")??ApiAddress.DEFAULT_BIZ_API_URL; //ApiAddress.BIZ_API_URL;
    }
    //print('get请求启动! serverUrl：' + serverUrl + url + ',body: $data');

//    print('post请求启动! url：$url ,body: $data');
    String token = pref.get("user_token");
    Response response;
    try {
      response = await dio.delete(
//        serverUrl + url +"?Authentication="+token,
          serverUrl + url,
          data: data,
          cancelToken: cancelToken,
          options: Options(
              headers: {"X-From-Service": true, "X-Access-Token": token})
      );
      print('delete请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('delete请求取消! ' + e.message);
      }
      print('delete请求发生错误：$e');
    }
    return response.data;
  }

  getOptional(url, {data, options, cancelToken, isAuth = false}) async {
//    final pref = await SharedPreferences.getInstance();
//    String serverUrl = pref.getString("serverUrl");
//    String token = await new TokenUtil().getToken();

    final pref = await SharedPreferences.getInstance();
    String serverUrl;
    if (isAuth) {
      serverUrl = pref.getString("authServerUrl")??ApiAddress.DEFAULT_AUTH_API_URL; //ApiAddress.AUTH_API_URL;
    } else {
      serverUrl = pref.getString("bizServerUrl")??ApiAddress.DEFAULT_BIZ_API_URL; //ApiAddress.BIZ_API_URL;
    }
    print('get请求启动! serverUrl：' + serverUrl + url + ',body: $data');
    String token = pref.get("user_token");
    Response response;
    Options myoptions = options;
    try {
      print("options"+myoptions.headers.toString());
      response = await dio.get(
          serverUrl + url,
          data: data,
          cancelToken: cancelToken,
          options: myoptions );
      print('get请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
//        Fluttertoast.showToast(
//          msg: '数据请求被取消! ',
//          toastLength: Toast.LENGTH_LONG,
//        );
      }
      print('get请求发生错误：$e');
//      Fluttertoast.showToast(
//        msg: '数据请求发生错误！',
//        toastLength: Toast.LENGTH_LONG,
//      );
      throw e;
    }
    return response.data;
  }
}