import 'package:flutter/material.dart';
import 'package:myapp/common/index.dart';
/**
 * 常规按钮
 */
class ColorBlock  extends StatelessWidget {
  const ColorBlock({
    Key key,
    this.width,
    this.margin,
    this.padding,
    this.child,
    this.color,
    this.style
  }) : super(key: key);

  final double width;

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  final Widget child;

  final String color;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.bottomCenter,
      margin: margin??EdgeInsets.only(top: 2),
      height: double.infinity,
      width: double.infinity,
      child: Container(
        // height: width??28.0,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.bottomCenter,
        child: new Text(' '),
        decoration: BoxDecoration(
          border: new Border.all(color: Colors.white, width: 2), // 边色与边宽度
          color: Color(materialColor[color]),
          boxShadow: [BoxShadow(color: Colors.grey[200], offset: Offset(2.0, 2.0),blurRadius: 30.0, spreadRadius: 2.0)]
        )
      ),
    );
  }
}