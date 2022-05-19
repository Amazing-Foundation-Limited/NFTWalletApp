import 'package:dio/dio.dart';

BaseOptions options = BaseOptions(
    baseUrl: "https://api.coingecko.com/api/v3",
    connectTimeout: 15000,
    receiveTimeout: 13000,
    method: "GET");
var dio = Dio(options);

// void initDio() async {
//   dio.interceptors
//     ..add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
//       // print("REQUEST[${options?.method}] => PATH: ${options?.path}");
//       return options;
//     }, onResponse: (Response response) async {
//       // print(
//       // "RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
//       return response;
//     }, onError: (DioError err) async {
//       // print(
//       // "ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
//       return err;
//     }));
//   // ..add(LogInterceptor(responseBody: true));
// }