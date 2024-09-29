import 'package:dio/dio.dart';
import 'package:squirrels_box_2/features/management/services/management_api_service.dart';

import '../../util/constants/strings.dart';
import '../../util/domain/models/response/base_response.dart';
import '../../util/logger/app_logger.dart';
import '../domain/models/box.dart';
import '../domain/models/responses/box_list_response.dart';
import 'interceptors/box_interceptor.dart';

class BoxService {
  final ManagementApiService _dio;
  final String boxApi = '$baseUrlWebService/Box';

  BoxService() : _dio = ManagementApiService();

  Future<BaseResponse> addBox(Box box, String userCode) async {
    final url = '$boxApi/$userCode';

    try {
      AppLogger.info(box);
      final resp = await _dio.postRequest(url, box.toJson());
      AppLogger.info(resp);

      final data = BaseResponse.fromMap(resp);

      return data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      if (e.response != null) {
        AppLogger.error(
            'Title: ${e.response?.data['title']} \n'
                'Status: ${e.response?.data['status']} \n'
                'Errors: ${e.response?.data['errors']}');
      }
      rethrow;

    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw DioException(requestOptions: RequestOptions(path: url), error: 'Unexpected error occurred.');
    }


  }

  Future<List<Box>> getBoxList(String userCode) async {
    final url = '$boxApi/boxlist/$userCode';
    final resp = await _dio.getRequest(url);
    final data = BoxListResponse.fromMap(resp);

    return data.boxList!;
  }

  Future<BaseResponse> updateBox(Box box) async {
    final url = '$boxApi/${box.id}';
    final resp = await _dio.putRequest(url, box.toJson());
    final data = BaseResponse.fromMap(resp);

    return data;
  }

  Future<BaseResponse> deleteBox(int boxId, {bool cascade = false}) async {
    final url = '$boxApi/$boxId/$cascade';
    final resp = await _dio.deleteRequest(url);
    final data = BaseResponse.fromMap(resp);

    return data;
  }

}