
import 'package:flutter/widgets.dart';
import 'package:myapp/utils/localStorage.dart' show LocalStorage;
import 'package:flutter/foundation.dart' show ChangeNotifier;

class UserInfo {
  dynamic info;
  String phone = '';
  String token = '';
}

class UserModel extends UserInfo with ChangeNotifier {

  Future getInfo() async {
    info = await LocalStorage.getJSON('userinfo');
    return info;
  }

  Future setInfo(payload) async {
    info = payload;
    LocalStorage.setJSON('userinfo', payload);
    notifyListeners();
  }

  Future getPhone() async {
    phone = await LocalStorage.get('phone');
    return phone;
  }

  Future setPhone(payload) async {
    phone = payload;
    LocalStorage.set('phone', payload);
    notifyListeners();
  }

  Future getToken() async {
    token = await LocalStorage.get('token');
    print('config get Theme ${token}');
    return token;
  }

  Future setToken(payload) async {
    token = payload;
    LocalStorage.set('token', payload);
    notifyListeners();
  }


}
