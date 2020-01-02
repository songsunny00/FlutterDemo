import 'package:flutter/material.dart';
import 'package:myapp/common/colors.dart';
import 'package:myapp/utils/index.dart';
class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
    this.width,
    this.height = 50,
    this.margin,
    this.radius,
    this.bgColor,
    this.highlightColor,
    this.splashColor,
    this.child,
    this.text,
    this.style,
    this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry margin;

  final double radius;
  final Color bgColor;
  final Color highlightColor;
  final Color splashColor;

  final Widget child;

  final String text;
  final TextStyle style;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Color _bgColor = bgColor ?? Theme.of(context).primaryColor;
    BorderRadius _borderRadius = BorderRadius.circular(radius ?? (height / 2));
    return new Container(
      width: width,
      height: height,
      margin: margin,
      child: new Material(
        borderRadius: _borderRadius,
        color: _bgColor,
        elevation: 10,
        child: new InkWell(
          borderRadius: _borderRadius,
          onTap: () => onPressed(),
          child: child ??
              new Center(
                child: new Text(
                  text,
                  style:
                      style ?? new TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
        ),
      ),
    );
  }
}

/**
 * 常规按钮
 */
class CommonRaisedButton  extends StatelessWidget {
  const CommonRaisedButton({
    Key key,
    this.width,
    this.margin,
    this.padding,
    this.child,
    this.text,
    this.style,
    this.onPressed,
    this.type,
    this.shape,
    this.icon
  }) : super(key: key);

  final double width;

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  final Widget child;

  final String text;
  final TextStyle style;

  final VoidCallback onPressed;

  final String type; //按钮类型
  final ShapeBorder shape;//按钮形状
  final IconData icon; //按钮图标

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: width,
      margin: margin,
      child: new RaisedButton(
        onPressed: () => onPressed(),
        child: child ??
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  !Utils.isEmpty(icon)?new Icon(
                    icon,
                    size: 20,//设置图标大小
                  ):new Text(''),
                  new Text(
                    text,
                    style:
                        style ?? new TextStyle(fontSize: 16),
                  ),
              ]),
        color: buttonType[type]["color"],
        textColor: buttonType[type]["textColor"],
        splashColor: buttonType[type]["splashColor"],
        elevation: 2,
        padding: padding?? EdgeInsets.fromLTRB(20,10,20,10),
        shape: shape??StadiumBorder(side: new BorderSide(
          color: buttonType[type]["borderColor"],
        ),),
      )
    );
  }
}