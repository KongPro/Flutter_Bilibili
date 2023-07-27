
import 'package:flutter_bilibili/http/core/k_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class KMockAdapter implements KNetAdapter {
  @override

  Future<KNetResponse<T>> send<T>(BaseRequest request) {
    return Future<KNetResponse<T>>.delayed(const Duration(milliseconds: 1000),() {
      return KNetResponse(data: {"code": 0, "message": "request success"} as T, statusCode: 200);
    });
  }

}