import 'package:flutter/material.dart';
import 'package:myapp/common/index.dart';
import 'package:myapp/utils/index.dart';
import 'package:myapp/components/inputs/loginItem.dart';
import 'package:myapp/components/buttons/index.dart';
import 'package:myapp/components/color_block.dart';
import 'package:myapp/store/index.dart';
import 'package:myapp/network/api.dart';
import 'package:myapp/utils/loading.dart';
final Api _api = Api();


class UserLoginPage extends StatefulWidget {
  UserLoginPage({Key key}) : super(key: key);


  @override
  _UserLoginState createState() => new _UserLoginState();
}
class _UserLoginState extends State<UserLoginPage> {

  @override
  Widget build(BuildContext context) {
    Loading.ctx = context; // 注入context
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

TextEditingController _controllerName = new TextEditingController();
TextEditingController _controllerPwd = new TextEditingController();
TextEditingController _controllerCode = new TextEditingController();

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {  
    
    //登录
    void _userLogin() async{
      String username = _controllerName.text;
      String password = _controllerPwd.text;
      String code = _controllerCode.text;
      if (username.isEmpty || username.length < 6) {
        Utils.showSnackBar(context, username.isEmpty ? DemoLocalizations.of(context).getString('user_name') : DemoLocalizations.of(context).getString('login_username_tip'));
        return;
      }
      if (password.isEmpty || password.length < 6) {
        Utils.showSnackBar(context, username.isEmpty ? DemoLocalizations.of(context).getString('user_pwd') : DemoLocalizations.of(context).getString('login_pwd_tip'));
        return;
      }
      if (code.isEmpty || code.length < 4) {
        Utils.showSnackBar(context, username.isEmpty ? DemoLocalizations.of(context).getString('user_code') : DemoLocalizations.of(context).getString('login_code_tip'));
        return;
      }
      var returnData = await _api.login({
        'phone': username,
        'code': code
      });
      if(returnData != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
    
    //发送验证码
    void sendCode() {
      String username = _controllerName.text;
      if (username.isEmpty || username.length < 6) {
        Utils.showSnackBar(context, username.isEmpty ? DemoLocalizations.of(context).getString('user_name') : DemoLocalizations.of(context).getString('login_username_tip'));
        return;
      }
      _api.getPhoneLoginCode({'phone': username});
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
                prefixIcon: Icons.phone_iphone,
                hintText: DemoLocalizations.of(context).getString('user_name'),
              ),
              Gaps.vGap15,
              LoginItem(
                controller: _controllerPwd,
                prefixIcon: Icons.lock,
                hasSuffixIcon: true,
                hintText: DemoLocalizations.of(context).getString('user_pwd'),
              ),
              Gaps.vGap15,
              LoginItem(
                controller: _controllerCode,
                prefixIcon: Icons.message,
                hasRightBtn: true,
                hintText: DemoLocalizations.of(context).getString('user_code'),
                onPressed: () {
                  //发送验证码
                  sendCode();
                },
                onSubmitted: () {
                  _userLogin();
                }
                
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
                    child: new Text(DemoLocalizations.of(context).getString('span_register'),textAlign: TextAlign.left),
                  ),
                  new Expanded(
                    child: new Text(DemoLocalizations.of(context).getString('span_forget_password'),textAlign: TextAlign.right)
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
