import 'package:dio/dio.dart';

import '../../authentication/services/authentication_api_service.dart';
import '../../util/constants/strings.dart';
import '../../util/domain/models/response/base_response.dart';
import '../../util/logger/app_logger.dart';
import '../domain/models/item_specification.dart';
import '../domain/models/requests/item_specification_request.dart';
import '../domain/models/responses/item_specification_list_response.dart';

class ItemSpecificationService {
  final AuthenticationApiService _dio;
  final String specApi = '$baseUrlWebService/Spec';

  ItemSpecificationService() : _dio = AuthenticationApiService();

  Future<BaseResponse> addItemSpec(ItemSpecificationRequest spec) async {
    final url = '$specApi/PostMassiveAsync';

    try {
      AppLogger.info(spec.toJson());
      final resp = await _dio.postRequest(url, spec.toJson());

      /*if (resp == null) {
        throw DioException(requestOptions: resp.requestOptions, error: 'No data received from the server.');
      }*/

      final data = BaseResponse.fromMap(resp);

      return data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      rethrow;

    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw DioException(requestOptions: RequestOptions(path: url), error: 'Unexpected error occurred.');
    }
  }

  Future<List<ItemSpecification>> getItemSpecList(int itemId) async {
    final url = '$specApi/itemlist/$itemId';
    final resp = await _dio.getRequest(url);
    final data = ItemSpecificationListResponse.fromMap(resp);

    return data.specList!;
  }

  Future<BaseResponse> updateItemSpec(ItemSpecificationRequest spec) async {
    final url = specApi;
    final resp = await _dio.putRequest(url, spec.toJson());
    final data = BaseResponse.fromMap(resp);

    return data;
  }

  Future<BaseResponse> deleteItemSpec(List<int> specsId) async {
    final url = specApi;
    final resp = await _dio.deleteRequest(url, data: {'ids': specsId});
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

}