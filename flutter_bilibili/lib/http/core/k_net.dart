import 'package:flutter_bilibili/http/core/k_error.dart';
import 'package:flutter_bilibili/http/core/net_adapter/k_dio_adapter.dart';
import 'package:flutter_bilibili/http/core/net_adapter/k_mock_adapter.dart';
import 'package:flutter_bilibili/http/core/net_adapter/k_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class KNet {
  KNet._();

  static KNet? _instance;
  static KNet getInstance() {
    return _instance ??= KNet._();
  }

  // 对发送请求的封装：发送请求以及处理response
  Future fire(BaseRequest request) async {
    KNetResponse? res;
    var error;

    // 发送请求，获取 response
    try {
      res = await send(request);
    } on KNetError catch (e) {
      error = e;
      res = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }

    if (res == null) {
      print(error);
    }

    // 得到 response.data
    var result = res?.data;

    // 判断状态码
    switch (res?.statusCode) {
      case 200:
        return result;
      case 401:
        throw LoginError();
      case 403:
        throw AuthError(result.toString(), data: result);
      default:
        throw KNetError(res?.statusCode, res.toString(), data: result);
    }
  }

  // 发送请求
  Future<KNetResponse<T>> send<T>(BaseRequest request) async {
    printLog("method = ${request.httpMethod()}");
    return KDioAdapter().send(request);
  }

  void printLog(log) {
    print("k_net: ${log.toString()}");
  }
}
