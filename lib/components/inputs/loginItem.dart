import 'package:myapp/common/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class LoginItem extends StatefulWidget {
  const LoginItem({
    Key key,
    this.prefixIcon,
    this.hasSuffixIcon = false,
    this.hasRightBtn = false,
    this.hintText,
    this.controller,
  }) : super(key: key);

  final IconData prefixIcon;
  final bool hasSuffixIcon;
  final bool hasRightBtn;
  final String hintText;
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() {
    return LoginItemState();
  }
}

class LoginItemState extends State<LoginItem> {
  bool _obscureText;
  //获取验证码
  int _time = 60;
  Timer _timer; // 倒计时的计时器
  int _seconds = 60; // 当前倒计时的秒数
  bool _rightShowBtn = false;
  bool _gettingCode = false;
  String _verifyStr = '获取验证码';

  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
    _rightShowBtn = widget.hasRightBtn;
  }

  _getToggleChild() {
    if (_rightShowBtn) {
      return Expanded(
          child: RaisedButton(
            color: Colours.app_main,
            textColor: Colours.white_1,
            onPressed: () {
              if(!_gettingCode) {
                _startTimer();
              }
            }, 
            child: Text(_verifyStr)
          )
      );
    } else {
      return Text('');
    }
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
      _gettingCode = true;
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds--;
      _verifyStr = '已发送$_seconds'+'s';
      setState(() {});
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
    _seconds = _time;
    _gettingCode = false;
    _verifyStr = '重新发送';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new IconButton(
          iconSize: 28,
          icon: new Icon(
            widget.prefixIcon,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {}
        ),
        Gaps.hGap5,
        new Expanded(
          child: new TextField(
              obscureText: _obscureText,//是否是密码
              controller: widget.controller,
              style: new TextStyle(color: Colours.gray_66, fontSize: Dimens.font14),
              decoration: new InputDecoration(
                hintText: widget.hintText,
                hintStyle: new TextStyle(color: Colours.gray_99, fontSize: Dimens.font14),
                suffixIcon: widget.hasSuffixIcon
                    ? new IconButton(
                        icon: new Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colours.gray_66,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        })
                    : null,
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colours.green_1)),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colours.green_1)),
              )),
        ),
        _getToggleChild()
      ],
    );
  }
}
