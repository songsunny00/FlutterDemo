import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/common/index.dart';
import 'package:myapp/pages/home_page/home.dart';
import 'package:myapp/pages/user_page/login.dart';
import 'package:myapp/common/local.dart';

void main() => runApp(MyApp());
const Color ThemeColor = Colours.app_main;//0xFFC91B3A;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'title',
      theme: new ThemeData(
        primaryColor: ThemeColor,
        backgroundColor: Color(0xFFEFEFEF),
        accentColor: Color(0xFF888888),
        textTheme: TextTheme(
          //设置Material的默认字体样式
          body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
        ),
        iconTheme: IconThemeData(
          color: ThemeColor,
          size: 35.0,
        ),
      ),
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        print('deviceLocale: $deviceLocale');
      },
      localizationsDelegates: [                             //此处
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DemoLocalizationsDelegate.delegate,
      ],
      supportedLocales: [                                   //此处
        const Locale('zh','CH'),
        const Locale('en','US'),
      ],
      home: new Builder(builder: (context){
        return new FreeLocalizations(
          key: DemoLocalizations.freeLocalizationStateKey,
          child: new InitPage(),
        );
      }),
      // initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => UserLoginPage(),
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
    // Navigator.of(context).pushReplacementNamed('/login');
    Future.delayed(Duration(milliseconds: 3000)).then((_) {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  int _counter = 0;
  bool flag = true;
  

  void changeLocale(){
    if(flag){
      DemoLocalizations.freeLocalizationStateKey.currentState.changeLocale(const Locale('zh',"CH"));
    }else{
      DemoLocalizations.freeLocalizationStateKey.currentState.changeLocale(const Locale('en',"US"));
    }
    flag = !flag;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(DemoLocalizations.of(context).titleBarTitle),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              DemoLocalizations.of(context).clickTop,
            ),
            new Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: changeLocale,
        tooltip: DemoLocalizations.of(context).inc,
        child: new Icon(Icons.add),
      ),
    );
  }
}
