import 'package:dio/dio.dart';

import '../../authentication/domain/models/responses/refresh_token_response.dart';
import '../../util/constants/strings.dart';
import '../../util/logger/app_logger.dart';
import '../../util/preferences/app_shared_preferences.dart';

class ManagementApiService {
  final Dio _dio = Dio();
  final List<String> _endpointsWithToken = [
    // add endpoints that require token
  ];

  ManagementApiService() {
    _dio
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1);

    // interceptors configuration
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_requiresToken(options.path)) {
            String? token = await getPreference('token');
            if (token != null) { options.headers['Authorization'] = 'Bearer $token';}
          }
          //options.headers[ocpHeader] = ocp; // something like: ocp-subscription-key
          return handler.next(options); /// Continue with original request
        },
        onResponse: (response, handler) {
          return handler.next(response); /// Continue with original respond
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            String? userCode = await getPreference('userCode');
            String? newAccessToken = await refreshToken(userCode!, e.requestOptions.headers["Authorization"]);

            if (newAccessToken != null) {
              e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
              return handler.resolve(await _dio.fetch(e.requestOptions));

            } else { /// return to login when refreshToken fail
              //authState.isLoggedIn.value = false;
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,
                  response: Response(
                      requestOptions: e.requestOptions,
                      statusCode: 403,
                      statusMessage: 'Forbidden'
                  ),
                  error: 'Unauthorized'
                )
              );
            }
          }

          if (_shouldRetry(e)) {
            try {
              final response = await _retry(e.requestOptions);
              return handler.resolve(response);
            } on DioException  catch (ex) {
              return handler.reject(ex);
            }
          } else {
            return handler.reject(e);
          }
        },
      ),
    );
  }

  bool _requiresToken(String path) {
    return !_endpointsWithToken.any((endpoint) => path.contains(endpoint));
  }

  Future<String?> refreshToken(String userCode, String token) async {
    try {
      Response response = await _dio.post(urlRefreshToken, data: {"refreshToken":token, "code":userCode});
      RefreshTokenResponse refreshTokenResponse = RefreshTokenResponse.fromMap(response.data);

      await setPreference('token', refreshTokenResponse.token!);
      return refreshTokenResponse.token;
      /*if (refreshRequest.validation!) {
        await setPreference('token', refreshTokenResponse.token!);
        return refreshTokenResponse.token;
      } else {
        return null;
      }
      return null;*/
    } on DioException {
      return null;
    }
  }

  /// Function to determine whether to retry based on error type
  bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout
        || e.type == DioExceptionType.sendTimeout
        || e.type == DioExceptionType.receiveTimeout ;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    const retries = 3; // Maximum number of retries
    const interval = Duration(seconds: 2); // Interval between retries
    for (int retry = 0; retry < retries; retry++) {
      try {
        if (retry > 0) {
          await Future.delayed(interval);
        }

        Options options = Options(
          method: requestOptions.method,
          headers: requestOptions.headers,
          extra: requestOptions.extra,
          responseType: requestOptions.responseType,
          contentType: requestOptions.contentType,
          validateStatus: requestOptions.validateStatus,
          receiveTimeout: requestOptions.receiveTimeout,
          sendTimeout: requestOptions.sendTimeout,
          followRedirects: requestOptions.followRedirects,
          maxRedirects: requestOptions.maxRedirects,
        );

        // Make request using '_dio'
        Response<dynamic> response = await _dio.request(
          requestOptions.path,
          options: options,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
        );

        // Check if the response was successful and return it
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return response;
        } else {
          throw DioException(
            requestOptions: requestOptions,
            response: response,
            error: 'Failed with status code ${response.statusCode}',
          );
        }
      } catch (e) {
        if (retry == retries - 1) { // If this is the last attempt and it fails, throw an exception
          throw DioException(
            requestOptions: requestOptions,
            error: 'Failed to retry request after $retries attempts',
          );
        }
      }
    }

    // In theory, the flow should not reach here, since errors are handled inside the loop
    throw DioException(
      requestOptions: requestOptions,
      error: 'Unexpected flow: Failed to retry request after $retries attempts',
    );
  }

  Future<dynamic> getRequest(String path) async {
    try {
      _dio.options.headers['content-type'] = 'application/json';
      Response response = await _dio.get(path);
      return response.data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      if (e.response != null) {
        AppLogger.error(
            'Title: ${e.response?.data['title']} \n'
                'Status: ${e.response?.data['status']} \n'
                'Errors: ${e.response?.data['errors']}'
        );
      }
      throw DioException(error: 'Failed to get data', requestOptions: e.requestOptions);
    }
  }

  Future<dynamic> postRequest(String path, dynamic data) async {
    try {
      _dio.options.headers['content-type'] = 'application/json';
      Response response = await _dio.post(path, data: data);
      return response.data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      if (e.response != null) {
        AppLogger.error(
            'Title: ${e.response?.data['title']} \n'
                'Status: ${e.response?.data['status']} \n'
                'Errors: ${e.response?.data['errors']}'
        );
      }
      throw DioException(error: 'Failed to post data', requestOptions: e.requestOptions);
    }
  }

  Future<dynamic> postRequestFormData(String path, FormData data) async {
    try {
      _dio.options.headers['content-type'] = 'multipart/form-data';
      Response response = await _dio.post(path, data: data);
      return response.data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      if (e.response != null) {
        AppLogger.error(
            'Title: ${e.response?.data['title']} \n'
                'Status: ${e.response?.data['status']} \n'
                'Errors: ${e.response?.data['errors']}'
        );
      }
      throw DioException(error: 'Failed to post data', requestOptions: e.requestOptions);
    }
  }

  Future<dynamic> putRequest(String path, dynamic data) async {
    try {
      _dio.options.headers['content-type'] = 'application/json';
      Response response = await _dio.put(path, data: data);
      return response.data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      if (e.response != null) {
        AppLogger.error(
            'Title: ${e.response?.data['title']} \n'
                'Status: ${e.response?.data['status']} \n'
                'Errors: ${e.response?.data['errors']}'
        );
      }
      throw DioException(error: 'Failed to put data', requestOptions: e.requestOptions);
    }
  }

  Future<dynamic> putRequestFormData(String path, FormData data) async {
    try {
      _dio.options.headers['content-type'] = 'multipart/form-data';
      Response response = await _dio.put(path, data: data);
      return response.data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      if (e.response != null) {
        AppLogger.error(
            'Title: ${e.response?.data['title']} \n'
                'Status: ${e.response?.data['status']} \n'
                'Errors: ${e.response?.data['errors']}'
        );
      }
      throw DioException(error: 'Failed to put data', requestOptions: e.requestOptions);
    }
  }

  Future<dynamic> deleteRequest(String path) async {
    try {
      _dio.options.headers['content-type'] = 'application/json';
      Response response = await _dio.delete(path);
      return response.data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      if (e.response != null) {
        AppLogger.error(
            'Title: ${e.response?.data['title']} \n'
                'Status: ${e.response?.data['status']} \n'
                'Errors: ${e.response?.data['errors']}'
        );
      }
      throw DioException(error: 'Failed to delete data', requestOptions: e.requestOptions);
    }
  }

}