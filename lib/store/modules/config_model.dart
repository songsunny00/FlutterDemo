
import 'package:flutter/widgets.dart';
import 'package:myapp/utils/localStorage.dart' show LocalStorage;
import 'package:flutter/foundation.dart' show ChangeNotifier;

class ConfigInfo {
  bool isPro = true;
  String version = '1.0';
  dynamic env = 'dev';
  String theme = 'red';
  String appVersion = '-';
  Locale locale = Locale('en','US');
  String token = '';
}

const Map langModel = {
  'en': Locale('en','US'),
  'zh': Locale('zh','CH')
};

class ConfigModel extends ConfigInfo with ChangeNotifier {

  Future getTheme() async {
    String _theme = await LocalStorage.get('theme');
    print('config get Theme ${_theme}');
    if (_theme != null) {
      setTheme(_theme);
    }
  }

  Future setTheme(payload) async {
    theme = payload;
    LocalStorage.set('theme', payload);
    notifyListeners();
  }

  Future setLanguage(lang) async {
    locale = langModel[lang];
    LocalStorage.set('locale', lang);
    notifyListeners();
  }

  Future getToken() async {
    token = await LocalStorage.get('token');
    print('config get Theme ${token}');
  }

  Future setToken(payload) async {
    token = payload;
    LocalStorage.set('token', payload);
    notifyListeners();
  }

  Future setIsPro() async {
    isPro = !isPro;
    notifyListeners();
  }

}
