import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page/first_page.dart';
import 'package:myapp/pages/home_page/second_page.dart';
import 'package:myapp/pages/home_page/third_page.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
}
