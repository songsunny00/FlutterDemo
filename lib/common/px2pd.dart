/*
 * @Author: songsunny
 * @GitHub: https://github.com/songsunny00
 * @Date: 2019-06-26 14:52:09
 * @LastEditors: songsunny
 * @LastEditTime: 2019-09-26 15:35:59
 * @Description: 处理屏幕自适应和字体-基于750
 */

import 'package:flutter/material.dart';
import 'dart:ui';

class Px2pd {
    static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    static double _width = mediaQuery.size.width;
    static double _height = mediaQuery.size.height;
    static double _topbarH = mediaQuery.padding.top;
    static double _botbarH = mediaQuery.padding.bottom;
    static double _pixelRatio = mediaQuery.devicePixelRatio;
    static var _ratio;
    static init(int number){
        int uiwidth = number is int ? number : 750;
        _ratio = _width / uiwidth;
    }
    static px(number){
        if(!(_ratio is double || _ratio is int)){Px2pd.init(750);}
        return number * _ratio;
    }
    static onepx(){
        return 1/_pixelRatio;
    }
    static screenW(){
        return _width;
    }
    static screenH(){
        return _height;
    }
    static padTopH(){
        return _topbarH;
    }
    static padBotH(){
        return _botbarH;
    }
    static double fontSize(double size) {
      if (_pixelRatio == 2) {
        // iphone 5s and older Androids
        if (_width < 360) {
            return size * 0.95;
        }
        // iphone 5
        if (_width < 667) {
            return size;
            // iphone 6-6s
        } else if (_width >= 667 && _width <= 735) {
            return size * 1.15;
        }
        // older phablets
        return size * 1.25;
      }
      if (_pixelRatio == 3) {
          // catch Android font scaling on small machines
          if (_width <= 360) {
              return size;
          }
          if (_width < 667) {
              return size * 1.15;
          }
          if (_width >= 667 && _width <= 735) {
              return size * 1.2;
          }
          // ie iphone 6s plus / 7 plus / mi note 等等
          return size * 1.27;
      }
      if (_pixelRatio == 3.5) {
          if (_width <= 360) {
              return size;
          }
          if (_width < 667) {
              return size * 1.20;
          }
          if(_width >= 667 && _width <= 735) {
              return size * 1.25;
          }
          return size * 1.40;
      }
      return size;
    }
}