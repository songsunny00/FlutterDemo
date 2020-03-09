import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({this.widget})
    : super(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return widget;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
           );
         }
      );
}
// Navigator.push(context, SlideRightRoute(widget: SampleModify(sample.zsjdlx,sample.zsjdid)));

//跳转到web页pushWeb
// Navigator.push(
//   context,
//   new CupertinoPageRoute<void>(
//     builder: (ctx) => new WebScaffold(
//       title: title,
//       titleId: titleId,
//       url: url,
//     )
//   )
// );