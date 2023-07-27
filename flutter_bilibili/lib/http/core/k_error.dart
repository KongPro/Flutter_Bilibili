// 登录异常
class LoginError extends KNetError {
  LoginError({int code = 401, String message = "请先登录"}) : super(code, message);
}

// 授权异常
class AuthError extends KNetError {
  AuthError(String message, {int code = 403, dynamic data})
      : super(code, message, data: data);
}

class KNetError implements Exception {
  late final int code;
  late final String message;
  late final dynamic data;

  KNetError(this.code, this.message, {this.data});
}
