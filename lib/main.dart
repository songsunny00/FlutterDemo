import 'package:flutter/material.dart';
import 'package:myapp/common/index.dart';
import 'package:myapp/pages/home_page/home.dart';
import 'package:myapp/pages/user_page/login.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => UserLoginPage(),
      },
    );
  }
}
