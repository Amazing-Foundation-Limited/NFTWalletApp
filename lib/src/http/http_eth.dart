import 'dart:convert';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kingloryapp/generated/l10n.dart';

class RequestETH {
  static String baseUrl="https://api-cn.etherscan.com/api?apikey=ZUBXBXGF3ZEVUSCPKI2A63Z5V4ZBR7ABFW&";
  static String baseUrl_test="https://api-testnet.bscscan.com/api?";
  // 配置 Dio 实例
  /*static final BaseOptions _options = BaseOptions(
    baseUrl: 'https://api-cn.etherscan.com/api?apikey=ZUBXBXGF3ZEVUSCPKI2A63Z5V4ZBR7ABFW&',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );*/


  static BaseOptions _options = setBaseOptions();

  //重设dio连接
  static reSetDio(bool isTest){
    _options=setBaseOptions(isTest: isTest);
    _dio=Dio(_options);
  }
  static setBaseOptions({bool isTest=false}){
    return BaseOptions(
      baseUrl: isTest?baseUrl_test:baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
  }
  // 创建 Dio 实例
  static Dio _dio = Dio(_options);

  // _request 是核心函数，所有的请求都会走这里
  static Future<T> _request<T>(String path,
      {required String method, required Map params, data}) async {
    // restful 请求处理
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        if (path.contains(key)) {
          path = path.replaceAll(":$key", value.toString());
        }
      });
    }
    LogUtil.v(data, tag: '发送的数据为：');
    try {
      Response response = await _dio.request(path,
          data: data, options: Options(method: method));
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          LogUtil.v(response.data, tag: '响应的数据为：');
          if (response.data is Map || response.data is List) {
            return response.data;
          } else {
            return json.decode(response.data.toString());
          }
        } catch (e) {
          LogUtil.v(e, tag: '解析响应数据异常');
          return Future.error(S.current.g_key_error_1);
        }
      } else {
        LogUtil.v(response.statusCode, tag: 'HTTP错误，状态码为：');
        // EasyLoading.showInfo('HTTP错误，状态码为：${response.statusCode}');
        _handleHttpError(response.statusCode);
        return Future.error(S.current.g_key_error_2);
      }
    } on DioError catch (e, s) {
      LogUtil.v(_dioError(e), tag: '请求异常');
      // EasyLoading.showInfo(_dioError(e));
      return Future.error(_dioError(e));
    } catch (e, s) {
      LogUtil.v(e, tag: '未知异常');
      return Future.error(S.current.g_key_error_3);
    }
  }

  // 处理 Dio 异常
  static String _dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return S.current.g_key_error_4;
        break;
      case DioErrorType.receiveTimeout:
        return S.current.g_key_error_5;
        break;
      case DioErrorType.sendTimeout:
        return S.current.g_key_error_6;
        break;
      case DioErrorType.response:
        return S.current.g_key_error_7;
        break;
      case DioErrorType.cancel:
        return S.current.g_key_error_8;
        break;
      case DioErrorType.other:
        return S.current.g_key_error_9;
        break;
      default:
        return S.current.g_key_error_10;
    }
  }

  // 处理 Http 错误码
  static void _handleHttpError(int? errorCode) {
    String message;
    switch (errorCode) {
      case 400:
        message = S.current.g_key_error_11;
        break;
      case 401:
        message = S.current.g_key_error_12;
        break;
      case 403:
        message = S.current.g_key_error_13;
        break;
      case 404:
        message = S.current.g_key_error_14;
        break;
      case 408:
        message = S.current.g_key_error_15;
        break;
      case 500:
        message = S.current.g_key_error_16;
        break;
      case 501:
        message = S.current.g_key_error_17;
        break;
      case 502:
        message = S.current.g_key_error_18;
        break;
      case 503:
        message = S.current.g_key_error_19;
        break;
      case 504:
        message = S.current.g_key_error_20;
        break;
      case 505:
        message = S.current.g_key_error_21;
        break;
      default:
        message = '${S.current.g_key_error_22}$errorCode';
    }
    EasyLoading.showError(message);
  }

  static Future<T> get<T>(String path, {required Map params}) {
    return _request(path, method: 'get', params: params);
  }

  static Future<T> post<T>(String path, {required Map params, data}) {
    return _request(path, method: 'post', params: params, data: data);
  }

// 这里只写了 get 和 post，其他的别名大家自己手动加上去就行
}
