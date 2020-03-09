import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:myapp/network/api.dart';
import 'package:myapp/utils/localStorage.dart';
import 'package:myapp/utils/loading.dart';

class HttpRequest {
  static HttpRequest instance;
  static Dio dio;
  static BaseOptions baseoptions;

  CancelToken cancelToken = CancelToken();

  static HttpRequest getInstance() {
    if (null == instance) instance = HttpRequest();
    return instance;
  }

  /*
   * config it and create
   */
  HttpRequest() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    baseoptions = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: Api.BASE_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      //Http请求头.
      headers: {
        "Accept-Language": "zh-CN,zh;q=0.9",
        "version": "1.0.0"
      },
      extra: {
        "noCache": true, //本接口禁用缓存
      },
      //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
      contentType: ContentType.parse("application/x-www-form-urlencoded"),//ContentType.json,
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );

    dio = Dio(baseoptions);

    //Cookie管理
    dio.interceptors.add(CookieManager(CookieJar()));

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {   
      print("请求之前");
      // Do something before request is sent
      return options; //continue
    }, onResponse: (Response response) {
      print("响应之前");
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      print("错误之前");
      // Do something with response error
      return e; //continue
    }));
  }

  /*
   * get请求
   */
  Future<dynamic> get(url, {data, options, cancelToken}) async {
    Response response;
    try {
      //授权码
      if(options == null) {
        options = Options(
          headers: {},
        );
      }
      if (options.headers["token"] == null) {
        await getAuthorization(options.headers);
      }
      print('get request---------${url}');
      print('get request---------${data}');
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      print('get success---------${response.statusCode}');
      print('get success---------${response.data}');

    } on DioError catch (e) {
      print('get error---------$e');
      formatError(e);
    }
    return response;
  }

  /*
   * post请求
   */
  Future<dynamic> post(url, {data, options, cancelToken, isNeedLoading}) async {
    Response response;
    try {
      //授权码
      if(options == null) {
        options = Options(
          headers: {},
        );
      }
      if (options.headers["token"] == null) {
        await getAuthorization(options.headers);
      }
      print('post request---------${url}');
      print('post request---------${data}');
      if(isNeedLoading) {
        Loading.start(url, '正在加载...');
      }
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.request(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      print('post success---------${response.statusCode}');
      print('post success---------${response.data}');
      if(isNeedLoading) {
        Loading.complete(url);
      }
    } on DioError catch (e) {
      print('post error---------$e');
      formatError(e);
      if(isNeedLoading) {
        Loading.complete(url);
      }
    }
    return response;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  ///清除授权
  static clearAuthorization(optionParams) {
    optionParams["token"] = null;
    LocalStorage.remove('token');
  }

  ///获取授权token
  static getAuthorization(optionParams) async {
    String token = await LocalStorage.get('token');
    if (token == null) {
      String basic = await LocalStorage.get('basic');
      if (basic == null) {
        //提示输入账号密码
      } else {
        //通过 basic 去获取token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      optionParams["token"] = token;
      return token;
    }
  }

}