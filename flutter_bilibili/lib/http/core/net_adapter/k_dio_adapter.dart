

import 'package:dio/dio.dart';
import 'package:flutter_bilibili/http/core/k_error.dart';
import 'package:flutter_bilibili/http/core/net_adapter/k_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class KDioAdapter implements KNetAdapter {
  @override
  Future<KNetResponse<T>> send<T>(BaseRequest request)  async{
    Response? response;
    var error;
    var option = Options(headers: request.header);

    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: option);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(request.url(), options: option);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(request.url(), options: option);
      }
    } on DioException catch(e) {
      error = e;
      response = e.response!;
    }

    KNetResponse<T> res = KNetResponse(
        data: response?.data,
        statusCode: response?.statusCode ?? -1,
        request: request,
        statusMessage: response?.statusMessage
    );
    if (error != null) {
      throw KNetError(response?.statusCode, error.toString(), data:res);
    }
    return res;
  }
}