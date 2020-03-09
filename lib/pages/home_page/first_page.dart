import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:myapp/network/api.dart';
import 'package:myapp/components/refresh/my_taurus_footer.dart';
import 'package:myapp/components/refresh/my_taurus_header.dart';
import 'package:myapp/models/course_list_entity.dart';
import 'package:myapp/store/index.dart';
import 'package:myapp/common/index.dart';
final Api _api = Api();
class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  TabController _controller; //tab控制器
  int _currentIndex = 0; //选中下标

  List _tabsDatas = List(); //tab集合
  List<CourseListData> _listDatas = List(); //列表内容集合

  int _page = 1; //看文档时要注意page是从0还是1开始

  @override
  void initState() {
    super.initState();
    //初始化controller
    _controller = TabController(vsync: this, length: 0);
    // loadTabsList();
  }

  void loadTabsList() async {
    try {
      List tabsLists = await _api.getTabsList();
  
      setState(() {
        _tabsDatas = tabsLists;
        _controller = TabController(vsync: this, length: _tabsDatas.length);
      });

      loadList();
      //controller添加监听
      _controller.addListener(() => _onTabChanged());
    } catch (e) {
      print(e);
    }
  }

  /// tab改变监听
  _onTabChanged() {
    if (_controller.index.toDouble() == _controller.animation.value) {
      //赋值 并更新数据
      this.setState(() {
        _currentIndex = _controller.index;
        _page = 1;
      });
      loadList();
    }
  }

  /// 根据tab下标获取数据
  void loadList() async {
    try {
      var courseListObj = await _api.loadCourseList({'pageIndex':_page});
      if(_page<2) {
        setState(() {
          _listDatas = courseListObj.courselist;
        });
      }else {
        setState(() {
          _listDatas.addAll(courseListObj.courselist);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        //控制器
        controller: _controller,
        //选中的颜色
        labelColor: Theme.of(context).primaryColor,
        //选中的样式
        labelStyle: TextStyle(fontSize: 16),
        //未选中的颜色
        unselectedLabelColor: Colors.black87,
        //未选中的样式
        unselectedLabelStyle: TextStyle(fontSize: 14),
        //下划线颜色
        indicatorColor: Theme.of(context).primaryColor,
        //是否可滑动
        isScrollable: true,
        //tab标签
        tabs: _tabsDatas.map((choice) {
          return Tab(
            text: choice['label'],
          );
        }).toList(),
        //点击事件
        onTap: (int i) {
          print(i);
        },
      ),
      body: TabBarView(
        controller: _controller,
        children: _tabsDatas.map((choice) {
          return EasyRefresh.custom(
            header: TaurusHeader(),
            footer: TaurusFooter(),
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  _page = 1;
                });
                loadList();
              });
            },
            onLoad: () async {
              await Future.delayed(Duration(seconds: 1), () async {
                setState(() {
                  _page++;
                });
                loadList();
              });
            },
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return getRow(index);
                  },
                  childCount: _listDatas.length,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(Px2pd.px(5.0)),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Image.network('http:'+_listDatas[i].pic, fit: BoxFit.fill),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(Px2pd.px(20.0),Px2pd.px(5.0),Px2pd.px(20.0),Px2pd.px(5.0)),
                    child:Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _listDatas[i].name,
                          style: TextStyle(
                              fontSize: Dimens.font16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _listDatas[i].short_description,
                          style:
                              TextStyle(fontSize: Dimens.font14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(Px2pd.px(5.0)),
                                  child: Text(
                                    _listDatas[i].level,
                                    style: TextStyle(fontSize: Dimens.font12),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(Px2pd.px(5.0)),
                                child: Icon(
                                  Icons.person,
                                  size: Dimens.font16,
                                  color: Colors.grey,
                                  textDirection: TextDirection.rtl,
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(Px2pd.px(5.0)),
                                child: Text(
                                  _listDatas[i].numbers,
                                  style: TextStyle(fontSize: Dimens.font12),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        //点击item跳转到详情
        
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


}
