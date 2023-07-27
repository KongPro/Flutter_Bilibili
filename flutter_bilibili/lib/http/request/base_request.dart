enum HttpMethod {GET,POST,DELETE}

abstract class BaseRequest {

  // 初始参数
  var pathParams;
  // 是否为 https 请求，默认为 true
  var useHttps = true;

  // host
  String authority() {
    return "api.devio.org";
  }

  // 抽象方法，由子类实现
  HttpMethod httpMethod();
  String path();

  // 生成 url
  String url() {
    Uri uri;

    var pathStr = path();

    // 拼接 路径 和 参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    // 拼接完整路径
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print('url = ${uri.toString()}');
    return uri.toString();
  }

  // 判断是否需要登录
  bool needLogin();

  // 追加参数
  Map<String, String>params = {};
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // 设置鉴权 header
  Map<String, String>header = {};
  BaseRequest addHeader(String k, String v) {
    header[k] = v.toString();
    return this;
  }

}



