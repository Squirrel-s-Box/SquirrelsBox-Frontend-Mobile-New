import 'package:dio/dio.dart';

import '../../util/constants/strings.dart';
import '../../util/domain/models/response/base_response.dart';
import '../domain/models/item_specification.dart';
import '../domain/models/requests/item_specification_request.dart';
import '../domain/models/responses/item_specification_list_response.dart';
import 'interceptors/item_specification_interceptor.dart';

class ItemSpecificationService {
  final Dio _dio;
  final String specApi = '$baseUrlWebService/Spec';

  ItemSpecificationService() : _dio = Dio()..interceptors.add(ItemSpecificationInterceptor());

  Future<BaseResponse> addItemSpec(ItemSpecificationRequest spec) async {
    final url = '$specApi/PostMassiveAsync';

    try {
      final resp = await _dio.post(url, data: spec.toJson());
      final data = BaseResponse.fromMap(resp.data);

      return data;
    } on DioException {
      rethrow;
    }
  }

  Future<List<ItemSpecification>> getItemSpecList(int itemId) async {
    final url = '$specApi/itemlist/$itemId';
    final resp = await _dio.get(url);
    final data = ItemSpecificationListResponse.fromMap(resp.data);

    return data.specList!;
  }

  Future<BaseResponse> updateItemSpec(ItemSpecificationRequest spec) async {
    final url = specApi;
    final resp = await _dio.put(url, data: spec.toJson());
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

  Future<BaseResponse> deleteItemSpec(List<int> specsId) async {
    final url = specApi;
    final resp = await _dio.delete(url, data: {'ids': specsId});
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

}