import 'package:dio/dio.dart';

class SessionInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    /*options.queryParameters.addAll({
      'access_token': accessToken //TODO: implement access_token
    });*/

    super.onRequest(options, handler);
  }
}