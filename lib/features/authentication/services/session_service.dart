import 'package:dio/dio.dart';

import '../../util/constants/strings.dart';
import '../../util/logger/app_logger.dart';
import '../../util/preferences/app_shared_preferences.dart';
import '../domain/models/responses/register_response.dart';
import '../domain/models/session_info.dart';
import '../domain/models/user_login.dart';
import '../util/security.dart';
import 'authentication_api_service.dart';

class SessionService {
  final AuthenticationApiService _dio;
  final String api = '$baseUrlAuthentication/AccessSession';

  SessionService() : _dio = AuthenticationApiService();

  Future<SessionInfo> signUp(UserLogin user) async {
    final url = '$api/Register';

    try {
      final u = user.copyWith(
        password: Security().aesEncryption(user.password!),
      );

      AppLogger.info(u);
      final resp = await _dio.postRequest(url, u.toJson());
      //final resp = await _dio.post(url, data: u.toJson());
      //final resp = await _dio.post(url, data: user.toJson());
      AppLogger.info(resp);

      final data = RegisterResponse.fromMap(resp);
      //final data = RegisterResponse.fromMap(resp.data);
      await setPreference('token', data.info.token);
      await setPreference('userCode', data.info.code);

      return data.info;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      rethrow;

    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw DioException(requestOptions: RequestOptions(path: url), error: 'Unexpected error occurred.');
    }
  }

  Future<SessionInfo> signIn(UserLogin user) async {
    final url = '$api/LogIn';

    try {
      final u = user.copyWith(
          password: Security().aesEncryption(user.password!),
      );

      AppLogger.info(u);
      final resp = await _dio.postRequest(url, u.toJson(), rethrowError: true);
      //final resp = await _dio.post(url, data: u.toJson());
      //final resp = await _dio.post(url, data: user.toJson());
      AppLogger.info(resp);

      final data = RegisterResponse.fromMap(resp);
      //final data = RegisterResponse.fromMap(resp.data);
      await setPreference('token', data.info.token);
      await setPreference('userCode', data.info.code);

      return data.info;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      /*if (e.response != null) {
        AppLogger.error(
            'Title: ${e.response?.data['title']} \n'
                'Status: ${e.response?.data['status']} \n'
                'Errors: ${e.response?.data['errors']}');
      }*/
      rethrow;

    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw DioException(requestOptions: RequestOptions(path: url), error: 'Unexpected error occurred.');
    }
  }

}