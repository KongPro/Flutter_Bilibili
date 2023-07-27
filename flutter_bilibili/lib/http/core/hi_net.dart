import 'package:flutter_bilibili/http/request/base_request.dart';

class HiNet {
  HiNet._();

  static HiNet? _instance;
  static HiNet getInstance() {
    return _instance ??= HiNet._();
  }

  Future fire(BaseRequest request) async {
    var res = await send(request);
    var result = res["data"];
    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog("url = ${request.url()}");
    printLog("method = ${request.httpMethod()}");
    request.addHeader("token", "123");
    printLog("header = ${request.header}");
    return Future.value({
      "statusCode": "200",
      "data": {"code": 0, "message": "success"}
    });
  }

  void printLog(String str) {
    print("hi_net: ${str.toString()}");
  }
}
