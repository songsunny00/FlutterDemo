import 'package:myapp/common/index.dart';
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
  bool _rightShowBtn = false;
  bool _gettingCode = false;
  String _rightText = '获取验证码';

  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
    _rightShowBtn = widget.hasRightBtn;
  }

  _getToggleChild() {
    if (_rightShowBtn) {
      return Text('');
    } else {
      return RaisedButton(
        onPressed: () {
          _gettingCode = !_gettingCode;
          if(_gettingCode) {
            
          }
        }, 
        child: Text(_rightText)
      );
    }
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
        new Expanded(
          child: _getToggleChild(),
        )
      ],
    );
  }
}
