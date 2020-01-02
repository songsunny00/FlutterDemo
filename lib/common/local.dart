import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
class DemoLocalizations {
  final Locale locale;

  DemoLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'span_language': 'EN',
      'span_skin': 'SKIN',
      'btn_login': 'Login',
      'span_register': 'Register',
      'span_forget_password': 'Forget Password?',
      'task title': 'Flutter Demo',
      'titlebar title': 'Flutter Demo Home Page',

    },
    'zh': {
      'span_language': 'CH',
      'span_skin': '皮肤',
      'btn_login': '登  录',
      'span_register': '去注册',
      'span_forget_password': '忘记密码？',
      'task title': 'Flutter 示例',
      'titlebar title': 'Flutter 示例主页面',
    }
  };

  getString (attr) {
    print(locale.languageCode);
    return _localizedValues[locale.languageCode][attr];
  }

  get taskTitle{
    return _localizedValues[locale.languageCode]['task title'];
  }

  static DemoLocalizations of(BuildContext context){
    return Localizations.of(context, DemoLocalizations);
  }
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations>{

  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','zh'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return new SynchronousFuture<DemoLocalizations>(new DemoLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) {
    return false;
  }

  static DemoLocalizationsDelegate delegate = const DemoLocalizationsDelegate();
}