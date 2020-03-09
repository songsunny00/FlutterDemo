import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Toast 简单封装
class MyToast {
  //显示
  static show(
    @required String msg,
    {
      Toast toastLength,
      int timeInSecForIos = 1,
      double fontSize = 16.0,
      ToastGravity gravity,
      Color backgroundColor,
      Color textColor,
    }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  //消失
  static hide () {
    Fluttertoast.cancel();
  }
}