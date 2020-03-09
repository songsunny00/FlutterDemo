import 'package:flutter/material.dart';

Set dict = Set();
bool loadingStatus = false;
class Loading {
  static dynamic ctx;

  static void start(uri, text) {
    dict.add(uri); // 放入set变量中
    // 已有弹窗，则不再显示弹窗, dict.length >= 2 保证了有一个执行弹窗即可，
    if (loadingStatus == true || dict.length >= 2) {
      return ;
    }
    loadingStatus = true; // 修改状态
    // 请求前显示弹窗
    showDialog(
      context: ctx,
      builder: (context) {
        return ContentDialog(text: text);
      },
    );
  }

  static void complete(uri) {
    dict.remove(uri);
    // 所有接口接口返回并有弹窗
    if (dict.length == 0 && loadingStatus == true) {
      loadingStatus = false; // 修改状态
      // 完成后关闭loading窗口
      Navigator.of(ctx, rootNavigator: true).pop();
    }
  }
}

// 弹窗内容
class ContentDialog extends StatelessWidget {
  final String text;

  ContentDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // 设置透明背影
      elevation: 0,
      insetAnimationDuration: Duration(milliseconds: 1000),
      insetAnimationCurve: Curves.fastLinearToSlowEaseIn,
      child: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          height: 140,
          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(4.0)),
          child: Column(
            // 定义垂直布局
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ), //
            ],
          ),
        )
      ),
    );
  }
}