import 'package:flutter/material.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider, Consumer, Provider;
export 'package:provider/provider.dart';
//
import 'package:myapp/models/config_model.dart' show ConfigModel;
import 'package:myapp/models/user_model.dart' show UserModel;
export 'package:myapp/models/config_model.dart' show ConfigModel;
export 'package:myapp/models/user_model.dart' show UserModel;

class Store {
  static BuildContext context;
  static of(BuildContext context) {
    Store.context ??= context;
    return context;
  }

  static init({child,context}) {
    Store.context ??= context;
    return MultiProvider(
      child: child,
      providers: [
        ChangeNotifierProvider(builder: (_) => ConfigModel()),
        ChangeNotifierProvider(builder: (_) => UserModel()),
      ],
    );
  }

  static T value<T>([BuildContext context]) {
    context ??= Store.context;
    return Provider.of<T>(context);
  }


}

