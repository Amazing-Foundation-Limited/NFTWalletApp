import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:dio/adapter.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/src/platform_check/platform_check.dart';
import 'package:pointycastle/asn1/object_identifiers.dart';
import 'package:pointycastle/src/utils.dart';
//import 'package:pointycastle/asn1/object_identifiers.dart';
import 'package:basic_utils/basic_utils.dart' as basic;

class RequestCC {
  static String baseUrl="https://192.168.0.196:2390";
  static String baseUrl_test="https://192.168.0.196:2390";//"https://70.25.53.166:9000";//"https://192.168.0.196:2390";
  static String privateKey='''-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDBxWZeiN8bq3EZUhJzn6p47IlkfrPNh7Ro8rWpPIJ2OsiwYWoRHvSu7lw+a0qTpda4I+250SrJpjfVixsC3t6igqdVntJfVThBIZQ2+RifO7h/B4p71wKEcV6ZL0UVhPw5WvAPbHS3CrwKraIhs/fNriQxjTQBzwiayHSJIV/iNQIDAQABAoGASMdCrskLu1HGNfNseL8EgUyeQf+QuuZ4bV6Tuo++lHd5vz2nX+zXjAh83vjfVttX7WuZM0yLnJdwqyUHLSnWRl3f5syflRsBGkLJfT4hP+pqsj2mcuDhEq+hpSZGK2Z9dV1V80I+LxfW+j/U6BQTsBhFGHlXZz5Z/RY2B0ielcECQQDsXtDU/MoQHib+O1YHA4iLXFzwb3n3GqjRlsvKya8433CYF6pefIdun8Aa+XXR79YfZ3+jAfdBRFP76/5aQ5eRAkEA0dzusr3yQxeyaHLOVVN1OteThW8Dq6KORVOqfYsI0FTHu8+++5Z5E4jricaH/f07de5Dyxmq5UgaveYuFbS2ZQJAeLVC+EHP/sMnLpWmrRZE2MZmP/Lt2h8nL0FO+VRdwzF4EnOjcXUuxHOYay4R2RAdzRPRvrD2T8JREUnHLtltwQJANSP/oW0tskWG3KHtk3edoLfD2C7jPAvegLmN21pgcfh11x3k22of4I10LyABgZQlAVjC++PU/VgDxYBKvR5UbQJBANMxbb6hiYXTS6fue0NDSq7ETUjMzYBjmmIWc/aKKC2vLmvSyd8hkBLXvhX4zo5kQIbz+INwRgT5H+hLNqdJurY=
-----END RSA PRIVATE KEY-----''';
  static String privateKey1='''MIICXAIBAAKBgQDBxWZeiN8bq3EZUhJzn6p47IlkfrPNh7Ro8rWpPIJ2OsiwYWoRHvSu7lw+a0qTpda4I+250SrJpjfVixsC3t6igqdVntJfVThBIZQ2+RifO7h/B4p71wKEcV6ZL0UVhPw5WvAPbHS3CrwKraIhs/fNriQxjTQBzwiayHSJIV/iNQIDAQABAoGASMdCrskLu1HGNfNseL8EgUyeQf+QuuZ4bV6Tuo++lHd5vz2nX+zXjAh83vjfVttX7WuZM0yLnJdwqyUHLSnWRl3f5syflRsBGkLJfT4hP+pqsj2mcuDhEq+hpSZGK2Z9dV1V80I+LxfW+j/U6BQTsBhFGHlXZz5Z/RY2B0ielcECQQDsXtDU/MoQHib+O1YHA4iLXFzwb3n3GqjRlsvKya8433CYF6pefIdun8Aa+XXR79YfZ3+jAfdBRFP76/5aQ5eRAkEA0dzusr3yQxeyaHLOVVN1OteThW8Dq6KORVOqfYsI0FTHu8+++5Z5E4jricaH/f07de5Dyxmq5UgaveYuFbS2ZQJAeLVC+EHP/sMnLpWmrRZE2MZmP/Lt2h8nL0FO+VRdwzF4EnOjcXUuxHOYay4R2RAdzRPRvrD2T8JREUnHLtltwQJANSP/oW0tskWG3KHtk3edoLfD2C7jPAvegLmN21pgcfh11x3k22of4I10LyABgZQlAVjC++PU/VgDxYBKvR5UbQJBANMxbb6hiYXTS6fue0NDSq7ETUjMzYBjmmIWc/aKKC2vLmvSyd8hkBLXvhX4zo5kQIbz+INwRgT5H+hLNqdJurY=''';
  //static String privateKey="MIHcAgEBBEIBRlhtdjeHoTLrhWP6Z6glUqJpHikTX/e5gCENlgK2hGboPSOVuYj2J+Pqfk1qD0QzRlGv527J2wgQtdI/84hOss+gBwYFK4EEACOhgYkDgYYABACY5UZzjA7qlNZAWEe0cux/Fig075mi+Xe9wvO3WOhvt5YonL0dlBMtzPK3/Pbgr479SJUgRVkni1vU0t8bl0Sx3AFyiqvCoRNueUyB8ePciglE1RRV3UJl7N75UQaiPlKT13diuspHfKpC6EpjuRLT9YtsTHP/a389id/QAtPFHGeR3w==";
  /*static String privateKey='''-----BEGIN PRIVATE KEY-----
  MIHcAgEBBEIBRlhtdjeHoTLrhWP6Z6glUqJpHikTX/e5gCENlgK2hGboPSOVuYj2
  J+Pqfk1qD0QzRlGv527J2wgQtdI/84hOss+gBwYFK4EEACOhgYkDgYYABACY5UZz
  jA7qlNZAWEe0cux/Fig075mi+Xe9wvO3WOhvt5YonL0dlBMtzPK3/Pbgr479SJUg
  RVkni1vU0t8bl0Sx3AFyiqvCoRNueUyB8ePciglE1RRV3UJl7N75UQaiPlKT13di
  uspHfKpC6EpjuRLT9YtsTHP/a389id/QAtPFHGeR3w==
  -----END PRIVATE KEY-----''';*/
  static String publicKey='''-----BEGIN EC public Key-----
MIGbMBAGByqGSM49AgEGBSuBBAAjA4GGAAQAmOVGc4wO6pTWQFhHtHLsfxYoNO+Z
ovl3vcLzt1job7eWKJy9HZQTLczyt/z24K+O/UiVIEVZJ4tb1NLfG5dEsdwBcoqr
wqETbnlMgfHj3IoJRNUUVd1CZeze+VEGoj5Sk9d3YrrKR3yqQuhKY7kS0/WLbExz
/2t/PYnf0ALTxRxnkd8=
-----END EC public Key-----''';
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
      //contentType: 'application/x-www-form-urlencoded',
    );
  }
  // 创建 Dio 实例
  static Dio _dio = Dio(_options);
  // _request 是核心函数，所有的请求都会走这里
  static Future<T> _request<T>(String path,
      {required String method, required Map params, required Map<String,dynamic> data}) async {
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


      String dataStr="";
      List<String> dataKeys=data.keys.toList();
      for(String key in dataKeys){
        dataStr+='$key=${data[key]}&';
      }
      dataStr=dataStr.substring(0,dataStr.length-1);
      basic.ASN1Parser asn1=basic.ASN1Parser(Uint8List.fromList(base64Decode(privateKey1)));
      var asn1NextProject=asn1.nextObject();
      print(asn1.bytes);

      RSAPrivateKey rsaPrivateKey= basic.CryptoUtils.rsaPrivateKeyFromPem(privateKey);

      FortunaRandom secureRandom = FortunaRandom(); // Get directly

      secureRandom.seed(
          KeyParameter(Platform.instance.platformEntropySource().getBytes(32)));

      RSAKeyGenerator rsaKeyGenerator=RSAKeyGenerator();
      rsaKeyGenerator.init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.from(65537),1024,64),
        secureRandom,
      ));
      final pair = rsaKeyGenerator.generateKeyPair();

      // Cast the generated key pair into the RSA key types

      final myPublic = pair.publicKey as RSAPublicKey;
      RSAPrivateKey myPrivate = pair.privateKey as RSAPrivateKey;
      print(myPrivate);

      AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> asymmetricKeyPair= AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(myPublic, myPrivate);

      //Digest digest=Digest('SHA-256');
      RSASigner rsaSigner=RSASigner(SHA256Digest(),'0609608648016503040201');

      //KeyParameter akp=KeyParameter(rsaPrivateKey);
      rsaSigner.init(true, PrivateKeyParameter<RSAPrivateKey>(myPrivate));
      //PrivateKeyParameter pkp=PrivateKeyParameter(rsaPrivateKey);

      /*Signer rsaSigner=Signer('SHA-256/RSA');

      //RSAAsymmetricKey keyParameter=RSAAsymmetricKey(rsaPrivateKey.modulus,rsaPrivateKey.exponent);
      KeyParameter keyParameter=KeyParameter(rsaPrivateKey);
      rsaSigner.init(true,pkp);*/

      List<int> list = dataStr.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      RSASignature signature=rsaSigner.generateSignature(bytes);
      String signStr=String.fromCharCodes(signature.bytes);
      data['sign']=signStr;



      RSASigner rsaSigner1=RSASigner(SHA256Digest(),'0609608648016503040201');

      //KeyParameter akp=KeyParameter(rsaPrivateKey);
      rsaSigner1.init(false, PublicKeyParameter<RSAPublicKey>(myPublic));
      final sig = RSASignature(signature.bytes);
      bool isOk=rsaSigner1.verifySignature(bytes, sig);
      print('isOK:$isOk');

/*
      var keyParameter=()=>PrivateKeyParameter<RSAPrivateKey>(rsaPrivateKey);
      AsymmetricBlockCipher cipher=AsymmetricBlockCipher("RSA/PKCS1");
      cipher.reset();
      cipher.init(true, keyParameter());
*/

      /*
      var ecPeivateKey=basic.CryptoUtils.ecPrivateKeyFromPem(privateKey);
      //ECPrivateKey ecpk=basic.CryptoUtils.ecPrivateKeyFromDerBytes(ecPeivateKey.batys)
      Uint8List bytes = Uint8List.fromList(base64Decode(privateKey));

      basic.ECPrivateKey ecp=basic.CryptoUtils.ecPrivateKeyFromDerBytes(bytes,pkcs8: true);

      String curveName="";
      var x;
      ASN1Set asn1s=ASN1Set.fromBytes(bytes);
      ASN1Parser asn1=ASN1Parser(bytes);
      ASN1Sequence topLevelSeq=asn1.nextObject() as ASN1Sequence;

      //ASN1Sequence innerSeq = topLevelSeq.elements!.elementAt(1) as ASN1Sequence;
      ASN1OctetString innerSeq = topLevelSeq.elements!.elementAt(1) as ASN1OctetString;
      var b2 = innerSeq.elements!.elementAt(1) as ASN1ObjectIdentifier;
      var b2Data = b2.objectIdentifierAsString;
      var b2Curvedata = ObjectIdentifiers.getIdentifierByIdentifier(b2Data);
      if (b2Curvedata != null) {
        curveName = b2Curvedata['readableName'];
      }
      var octetString = topLevelSeq.elements!.elementAt(2) as ASN1OctetString;
      asn1 = ASN1Parser(octetString.valueBytes);
      var octetStringSeq = asn1.nextObject() as ASN1Sequence;
      var octetStringKeyData =
      octetStringSeq.elements!.elementAt(1) as ASN1OctetString;
      x = octetStringKeyData.valueBytes!;

*/
      FormData fm=FormData.fromMap(data);
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
        client.badCertificateCallback=(X509Certificate cert, String host, int port){
          return true;
        };
      };
      Response response = await _dio.request(path,
          data: fm, options: Options(method: method));
      print(response);
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
      print(e.toString());
      LogUtil.v(_dioError(e), tag: '请求异常');
      // EasyLoading.showInfo(_dioError(e));
      return Future.error(_dioError(e));
    } catch (e, s) {
      print(e.toString());
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
    return _request(path, method: 'get', params: params,data: {});
  }

  static Future<T> post<T>(String path, {required Map params, data}) {
    return _request(path, method: 'post', params: params, data: data);
  }

// 这里只写了 get 和 post，其他的别名大家自己手动加上去就行
}
