import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
class DemoLocalizations {
  final Locale locale;

  DemoLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      //登录界面
      'span_language': 'EN',
      'span_skin': 'SKIN',
      'btn_login': 'Login',
      'span_register': 'Register',
      'span_forget_password': 'Forget Password?',
      'user_name': 'please input phone number',
      'user_pwd': 'please input password',
      'user_code': 'please input code',
      'login_username_tip': 'The format of phone number is incorrect',
      'login_pwd_tip': 'The length of password can not be less than 6',
      'login_code_tip': 'The length of code can not be less than 4',

    },
    'zh': {
      //登录界面
      'span_language': 'CH',
      'span_skin': '皮肤',
      'btn_login': '登  录',
      'span_register': '去注册',
      'span_forget_password': '忘记密码？',
      'user_name': '请输入手机号',
      'user_pwd': '请输入用户密码',
      'user_code': '请输入验证码',
      'login_username_tip': '手机格式不正确',
      'login_pwd_tip': '密码长度不能小于6位',
      'login_code_tip': '验证码长度不能小于4位',

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