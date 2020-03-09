import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:myapp/common/index.dart';
import 'package:myapp/pages/home_page/first_page.dart';
import 'package:myapp/pages/home_page/second_page.dart';
import 'package:myapp/pages/home_page/third_page.dart';
import 'package:myapp/pages/user_page/user.dart';
import 'package:myapp/network/api.dart';
import 'package:myapp/utils/dialog.dart';
final Api _api = Api();
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
    // 获取用户信息
    _api.getUserInfo();
    
  }

  @override
  Widget build(BuildContext context) {
    MyDialog.ctx = context;
    final List<Widget> _children = [FirstPage(),SecondPage(),ThirdPage()];
    return Scaffold(
      appBar: AppBar(
        title:Text(_titles[_selectedIndex]),
        backgroundColor:Theme.of(context).primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '搜索',
            onPressed: () {},
          ),

        ],
      ),
      drawer: showDrawer(),
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

  Widget showDrawer() {
      return Drawer(
        child: ListView(
          //ListView padding 不为空的时候，Drawer顶部的状态栏就不会有灰色背景
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              //头像
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundImage: new AssetImage(Ids.img_avatar),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                },
              ),
              //其他头像
              otherAccountsPictures: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                    ),
                    onPressed: () {}
                )
              ],
              accountName: Text(
                'songsunny',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              accountEmail: Text('1336555'),
            ),

            ///功能列表
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text("我的课程"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text("切换主题"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("我要分享"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pop();
                Share.share(
                    'https://github.com/songsunny00/FlutterDemo');
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("关于我们"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text("退出"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                showLogoutDialog();
              },
            ),
          ],
        ),
      );
    }

    void showLogoutDialog() {
      MyDialog.showConfirmDialog('确定退出登录？',
        onConfirmPressed: () {
          Navigator.pushNamedAndRemoveUntil(context,"/login",ModalRoute.withName('/login'));
        }
      );
    }

}
