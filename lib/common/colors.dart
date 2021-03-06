/*
 * @Author: songsunny
 * @GitHub: https://github.com/songsunny00
 * @Date: 2019-06-28 09:41:32
 * @LastEditors: songsunny
 * @LastEditTime: 2019-06-28 16:42:42
 * @Description: 颜色配置
 */

import 'package:flutter/material.dart';

class Colours {
  static const Color app_main = Color(0xFFF20D0D);
  static const Color app_main_100 = Color(0xFFf33434);

  static const Color app_main_green = Color(0xFF239f9b);
  static const Color app_main_green_100 = Color(0xFF02a19b);

  static const Color transparent_80 = Color(0x80000000); 

  static const Color text_dark = Color(0xFF333333);
  static const Color text_normal = Color(0xFF666666);
  static const Color text_gray = Color(0xFF999999);

  static const Color divider = Color(0xffe5e5e5);

  static const Color gray_33 = Color(0xFF333333); 
  static const Color gray_66 = Color(0xFF666666); 
  static const Color gray_99 = Color(0xFF999999); 
  static const Color common_orange = Color(0XFFFC9153); 
  static const Color gray_ef = Color(0XFFEFEFEF); 

  static const Color gray_f0 = Color(0xfff0f0f0); 
  static const Color gray_f5 = Color(0xfff5f5f5); 
  static const Color gray_cc = Color(0xffcccccc); 
  static const Color gray_ce = Color(0xffcecece); 
  static const Color green_1 = Color(0xff009688); 
  static const Color green_62 = Color(0xff626262); 
  static const Color green_e5 = Color(0xffe5e5e5); 

  static const Color white_1 = Color(0xFFFFFFFF);    

}
/**
 * 皮肤颜色配置
 */
Map materialColor = {
  'red': 0xFFF20D0D,
  'green': 0xFF239f9b,
};

/**
 * 按钮类型
 */
Map buttonType = {
  "red": {
    "color": Colours.app_main,
    "textColor": Colors.white,
    "splashColor": Colours.app_main_100,
    "borderColor": Colours.app_main,
  },
  "red plain": {
    "color": Colors.white70,
    "textColor": Colours.app_main,
    "splashColor": Colors.white54,
    "borderColor": Colours.app_main,
  },
  "green": {
    "color": Colours.app_main_green,
    "textColor": Colors.white,
    "splashColor": Colours.app_main_green_100,
    "borderColor": Colours.app_main_green,
  },
  "green plain": {
    "color": Colors.white70,
    "textColor": Colours.app_main_green,
    "splashColor": Colors.white54,
    "borderColor": Colours.app_main_green,
  }
};