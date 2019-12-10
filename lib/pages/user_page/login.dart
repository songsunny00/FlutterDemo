import 'package:flutter/material.dart';
import 'package:myapp/common/common.dart';
import 'package:myapp/common/index.dart';
import 'package:myapp/utils/util.dart';
import 'package:myapp/components/inputs/loginItem.dart';

class UserLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: new Stack(
        children: <Widget>[
          new Image.asset(
            Util.getImgPath("ic_login_bg"),
            package: BaseConstant.packageBase,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          new LoginBody()
        ],
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerName = new TextEditingController();
    TextEditingController _controllerPwd = new TextEditingController();
    TextEditingController _controllerCode = new TextEditingController();

    void _userLogin() {
      String username = _controllerName.text;
      String password = _controllerPwd.text;
      if (username.isEmpty || username.length < 6) {
        Util.showSnackBar(context, username.isEmpty ? "请输入用户名～" : "用户名至少6位～");
        return;
      }
      if (password.isEmpty || password.length < 6) {
        Util.showSnackBar(context, username.isEmpty ? "请输入密码～" : "密码至少6位～");
        return;
      }
    }

    void _incrementCounter() {
      showDatePicker(context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime.now().subtract(new Duration(days: 30)),
          lastDate: new DateTime.now().add(new Duration(days: 30))).then((v) {});
    }

    return new Column(
      children: <Widget>[
        new Expanded(
            child: new Container(
          margin: EdgeInsets.only(left: 20, top: 15, right: 20),
          child: new Column(
            children: <Widget>[
              LoginItem(
                controller: _controllerName,
                prefixIcon: Icons.person,
                hintText: Ids.user_name,
              ),
              Gaps.vGap15,
              LoginItem(
                controller: _controllerPwd,
                prefixIcon: Icons.lock,
                hasSuffixIcon: true,
                hintText: Ids.user_pwd,
              ),
              Gaps.vGap15,
              LoginItem(
                controller: _controllerCode,
                prefixIcon: Icons.code,
                hasRightBtn: true,
                hintText: Ids.user_pwd,
              ),
            ],
          ),
        )
        ),
        new FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'tip',
          child: new Icon(Icons.add),
        ),
      ],
    );
  }
}
