import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/common/index.dart';
import 'package:myapp/utils/index.dart';
import 'package:myapp/pages/home_page/home.dart';
import 'package:myapp/pages/user_page/login.dart';
import 'package:myapp/store/index.dart';

void main() => runApp(Store.init(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends  State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Store.of(context);
    return Consumer<ConfigModel>(
      builder: (context, configModel, child) {
        return new MaterialApp(
          title: 'title',
          theme: new ThemeData(
            primaryColor: Color(materialColor[
                          Store.value<ConfigModel>(context).theme]),
            backgroundColor: Color(0xFFEFEFEF),
            accentColor: Color(0xFF888888),
            textTheme: TextTheme(
              //设置Material的默认字体样式
              body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
            ),
            iconTheme: IconThemeData(
              color: Color(materialColor[
                          Store.value<ConfigModel>(context).theme]),
              size: 35.0,
            ),
          ),
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            print('deviceLocale: $deviceLocale');
          },
          locale: Store.value<ConfigModel>(context).locale,  //不设置，则默认系统语言
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            DemoLocalizationsDelegate.delegate,  //设置本地化代理
          ],
          supportedLocales: [  //设置支持本地化语言集合
            const Locale('zh','CH'),
            const Locale('en','US'),
          ],
          home: new Builder(builder: (context){
            return  new InitPage();
          }),
          // initialRoute: '/',
          routes: {
            '/home': (context) => HomePage(),
            '/login': (context) => UserLoginPage(),
          },
        );
      },
    );
  }
}

class InitPage extends StatefulWidget {
  InitPage({Key key}) : super(key: key);


  @override
  _InitPageState createState() => new _InitPageState();
}

class _InitPageState extends State<InitPage> {

  @override
  void initState() {
    super.initState();
    // 检查登录是否有效
    Future.delayed(Duration.zero, () async {
      String token = await Store.value<ConfigModel>().getToken();
      if(Utils.isEmpty(token)) {
        Navigator.of(context).pushReplacementNamed('/home');
        // Navigator.of(context).pushReplacementNamed('/login');
      }else {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(DemoLocalizations.of(context).getString('task title')),
      ),
      body: new Center(
        
      ),
    );
  }
}
