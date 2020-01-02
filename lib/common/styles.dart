/*
 * @Author: songsunny
 * @GitHub: https://github.com/songsunny00
 * @Date: 2019-06-28 16:37:50
 * @LastEditors: songsunny
 * @LastEditTime: 2019-09-26 15:58:14
 * @Description: 常用样式配置
 */
import 'package:flutter/material.dart';
import 'package:myapp/common/dimens.dart';
import 'package:myapp/common/colors.dart';

class ButtonStyle {
  // primary-button
  
}

class TextStyles {
  static TextStyle listTitle = TextStyle(
    fontSize: Dimens.font16,
    color: Colours.text_dark,
    fontWeight: FontWeight.bold,
  );
  static TextStyle listTitle2 = TextStyle(
    fontSize: Dimens.font16,
    color: Colours.text_dark,
  );
  static TextStyle listContent = TextStyle(
    fontSize: Dimens.font14,
    color: Colours.text_normal,
  );
  static TextStyle listContent2 = TextStyle(
    fontSize: Dimens.font14,
    color: Colours.text_gray,
  );
  static TextStyle listExtra = TextStyle(
    fontSize: Dimens.font12,
    color: Colours.text_gray,
  );
  static TextStyle listExtra2 = TextStyle(
    fontSize: Dimens.font12,
    color: Colours.text_normal,
  );
  // static const TextStyle appTitle = TextStyle(
  //   fontSize: Dimens.font18,
  //   color: Colours.text_dark,
  // );
}

class Decorations {
  static Decoration bottom = BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.33, color: Colours.divider)));
}

/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: Dimens.gap5);
  static Widget hGap10 = new SizedBox(width: Dimens.gap10);
  static Widget hGap15 = new SizedBox(width: Dimens.gap15);
  static Widget hGap30 = new SizedBox(width: Dimens.gap30);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: Dimens.gap5);
  static Widget vGap10 = new SizedBox(height: Dimens.gap10);
  static Widget vGap15 = new SizedBox(height: Dimens.gap15);
  static Widget vGap30 = new SizedBox(height: Dimens.gap30);

  static Widget getHGap(double w) {
    return SizedBox(width: w);
  }

  static Widget getVGap(double h) {
    return SizedBox(height: h);
  }
}
