import 'package:dio/dio.dart';

import '../../util/constants/strings.dart';
import '../../util/domain/models/response/base_response.dart';
import '../domain/models/responses/register_response.dart';
import '../domain/models/session_info.dart';
import '../domain/models/user_login.dart';
import 'interceptors/session_interceptor.dart';

class SessionService {
  final Dio _dio;
  final String api = '$baseUrlAuthentication/AccessSession';

  SessionService() : _dio = Dio()..interceptors.add(SessionInterceptor())
    ..options.connectTimeout = const Duration(seconds: 5)
    ..options.receiveTimeout = const Duration(seconds: 5);

  Future<BaseResponse> signUp(UserLogin user) async {
    final url = '$api/Register';
    final resp = await _dio.post(url, data: user.toJson());
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

  Future<SessionInfo> signIn(UserLogin user) async {
    final url = '$api/LogIn';
    final resp = await _dio.post(url, data: user.toJson());
    final data = RegisterResponse.fromMap(resp.data);

    return data.info;
  }

}