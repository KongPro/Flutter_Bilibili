import 'dart:convert';

import 'package:flutter_bilibili/http/request/base_request.dart';

// 创建 adapter
abstract class KNetAdapter {
  Future<KNetResponse<T>> send<T>(BaseRequest request);
}

// 网络请求返回格式
class KNetResponse<T> {
  T data;
  int statusCode;
  BaseRequest? request;
  String? status;
  dynamic extra;

  KNetResponse({
    required this.data,
    required this.statusCode,
    this.request,
    this.status,
    this.extra
  });

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
