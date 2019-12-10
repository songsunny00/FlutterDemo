import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page/first_page.dart';
import 'package:myapp/pages/home_page/second_page.dart';
import 'package:myapp/pages/home_page/third_page.dart';
import 'package:myapp/pages/user_page/login.dart';
import 'package:myapp/routers/navigators.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<String> _titles = ['首页','发现','我的'];
  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _incrementCounter() {
    showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 30)),
        lastDate: new DateTime.now().add(new Duration(days: 30))).then((v) {});
  }

  @override
  void initState() {
    super.initState();
    // 检查登录是否有效
    // Navigator.of(context).pushReplacementNamed('/login');
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    // 检查登录是否有效
    // NavigatorUtil.pushPage(context, new UserLoginPage());
    final List<Widget> _children = [FirstPage(),SecondPage(),ThirdPage()];
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(_titles[0]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text(_titles[1]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text(_titles[2]),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onTabTapped,
      ),
    );
  }

  Future<bool> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
