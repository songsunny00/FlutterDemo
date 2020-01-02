import 'package:flutter/material.dart';
import 'package:myapp/common/index.dart';
import 'package:myapp/utils/index.dart';
import 'package:myapp/components/inputs/loginItem.dart';
import 'package:myapp/components/buttons/index.dart';
import 'package:myapp/components/color_block.dart';
import 'package:myapp/store/index.dart';


class UserLoginPage extends StatefulWidget {
  UserLoginPage({Key key}) : super(key: key);


  @override
  _UserLoginState createState() => new _UserLoginState();
}
class _UserLoginState extends State<UserLoginPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: new Container(
        color: Colors.white,
        child: new Stack(
        children: <Widget>[
          new Container(
            padding:EdgeInsets.only(top:10),
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("resources/images/bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            height: 80,
            right: 10,
            top: 20,
            child: new Row(
              children: <Widget>[
                new InkWell(
                  child: new Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: new Text(DemoLocalizations.of(context).getString('span_language')),
                  ),
                  onTap: () {
                    // 修改语言
                    String lang = DemoLocalizations.of(context).getString('span_language');
                    if(lang=='CH') {
                      Store.value<ConfigModel>(context).setLanguage('en');
                    }else {
                      Store.value<ConfigModel>(context).setLanguage('zh');
                    }
                  },
                ),
                new Text('|'),
                new InkWell(
                  child: new Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: PopupMenuButton(
                      child: Text(DemoLocalizations.of(context).getString('span_skin')),
                      // initialValue: "red",
                      offset: Offset(0, 20),
                      padding: EdgeInsets.all(0),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuItem<String>>[
                          PopupMenuItem<String>(child: ColorBlock(color:"red"), value: "red", height: 32,),
                          PopupMenuItem<String>(child: ColorBlock(color:"green"), value: "green", height: 32,),
                        ];
                      },
                      onSelected: (String action) {
                        Store.value<ConfigModel>(context).setTheme(action);
                      },
                      onCanceled: () {
                        print("onCanceled");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            height: 100,
            left: 10,
            right: 10,
            top: 100,
            child: Image.asset('resources/images/logo.png'),
          ),
          new LoginBody()
        ],
        )
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
        Utils.showSnackBar(context, username.isEmpty ? "请输入用户名～" : "用户名至少6位～");
        return;
      }
      if (password.isEmpty || password.length < 6) {
        Utils.showSnackBar(context, username.isEmpty ? "请输入密码～" : "密码至少6位～");
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
          margin: EdgeInsets.only(left: 20, top: 250, right: 20),
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
              new CommonRaisedButton (
                text: DemoLocalizations.of(context).getString('btn_login'),
                type: Store.value<ConfigModel>(context).theme,
                margin: EdgeInsets.only(top: 20),
                onPressed: () {
                  _userLogin();
                },
              ),
              Gaps.vGap30,
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new Text('去注册',textAlign: TextAlign.left),
                  ),
                  new Expanded(
                    child: new Text('忘记密码？',textAlign: TextAlign.right)
                  ),
                ],
              )
            ],
          ),
        )
        ),
      ],
    );
  }
}
