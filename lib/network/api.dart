/*
 * @Author: songsunny
 * @GitHub: https://github.com/songsunny00
 * @Date: 2019-06-28 09:41:32
 * @LastEditors: songsunny
 * @LastEditTime: 2019-06-28 16:42:42
 * @Description: 接口API
 */
import 'dart:convert';
import 'package:myapp/utils/toast.dart';
import 'package:myapp/utils/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:myapp/network/http.dart';
import 'package:myapp/models/response_entity.dart';
import 'package:myapp/models/course_list_entity.dart';

class LoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 10001;
  static const int successCode = 200;
  static const int empty = 2;
}
class Api {
  static const BASE_URL = 'https://m.imooc.com';
  var _request = new HttpRequest();
  // BuildContext _ctx;

  // Api(BuildContext ctx) {
  //   _ctx = ctx;
  // }

  // 获取手机验证码
  Future getPhoneLoginCode(Map<String, dynamic> params) async {
    // String url = "http://120.234.31.44/mybgi/send/sendSms/findUserInfoVerification.do";
    String url = BASE_URL + "/passport/user/getphonelogincode";
    Map<String, dynamic> requestBody = {
      'phone': params['phone'],
      'typecode': '0',
      'type': '1',
      'spras': '1'
    };
    var res = await _request.post(url,data:requestBody,isNeedLoading:true);
    Map userMap = json.decode(res.toString());
    var userEntity = ResponseEntity.fromJson(userMap);
    print('userEntity--------------${userEntity}');
    print(userEntity);
    print(userEntity.status);
    print(userEntity.msg);
    print(userEntity.data);
    if (userEntity.status == LoadStatus.success) {
      return userEntity.data;
    }else {
      
    }
    return null;
  }

  // 登录
  Future login(Map<String, dynamic> params) async {
    String url = BASE_URL + "/passport/user/phonelogin";
    params['referer'] = 'https://m.imooc.com';
    params['remember'] = '0';
    params['auto_register'] = '1';
    var res = await _request.post(url,data:params,isNeedLoading:true);
    Map responseMap = json.decode(res.toString());
    var responseEntity = ResponseEntity.fromJson(responseMap);
    print(responseEntity);
    print(responseEntity.status);
    print(responseEntity.msg);
    print(responseEntity.data);
    if (responseEntity.status == LoadStatus.success) {
      return responseEntity.data;
    }else {
      MyToast.show(responseEntity.msg);
    }
    return null;
  }

  // 获取用户信息
  Future getUserInfo() async {
    String url = BASE_URL + "/api/user/userInfo";
    var res = await _request.get(url);
    Map responseMap = json.decode(res.toString());
    var responseEntity = ResponseEntity.fromJson(responseMap);
    print(responseEntity);
    print(responseEntity.status);
    print(responseEntity.msg);
    print(responseEntity.data);
    if (responseEntity.status == LoadStatus.successCode) {
      // if(responseEntity.data[0] != null) {
      //   LocalStorage.set('phone', responseEntity.data[0].phone);
      //   LocalStorage.set('token', responseEntity.data[0].token);
      //   LocalStorage.setJSON('userinfo', responseEntity.data[0]);
      // }
      return responseEntity.data;
    }else {
      MyToast.show(responseEntity.msg);
    }
    return null;
  }

  // 获取用户搜索信息
  Future searchWordInfo() async {
    String url = BASE_URL + "/api/search/searchword";
    var res = await _request.get(url);
    Map responseMap = json.decode(res.toString());
    var responseEntity = ResponseEntity.fromJson(responseMap);
    print(responseEntity);
    print(responseEntity.status);
    print(responseEntity.msg);
    print(responseEntity.data);
    if (responseEntity.code == LoadStatus.successCode) {
      return responseEntity.data;
    }else {
      MyToast.show(responseEntity.msg);
    }
    return null;
  }

  //课程类别
  Future getTabsList() async {
    List data = [
      {
        'label': '全部',
        'value': '0'
      },
      {
        'label': '前端开发',
        'value': '1'
      },
      {
        'label': '后端开发',
        'value': '2'
      },
      {
        'label': '移动开发',
        'value': '3'
      },
    ];
    return data;
  }


  // 获取课程
  Future loadCourseList(Map<String, dynamic> params) async {
    String url = BASE_URL + "/api/course/loadCourseList";
    params['marking'] = 'all';
    params['course_type'] = '0';
    params['easy_type'] = '';
    params['order'] = '2';
    params['flag'] = ''; //more
    params['ex_learned'] = '0';

    var res = await _request.get(url,data:params);
    Map responseMap = json.decode(res.toString());
    Map data = responseMap['data'];
    var responseEntity = CourseListObjData.fromJson(data);
    return responseEntity;
  }
}