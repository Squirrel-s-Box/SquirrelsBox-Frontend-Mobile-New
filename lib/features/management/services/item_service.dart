import 'package:dio/dio.dart';

import '../../util/constants/strings.dart';
import '../../util/domain/models/response/base_response.dart';
import '../domain/models/item.dart';
import '../domain/models/requests/item_request.dart';
import '../domain/models/responses/item_list_response.dart';
import 'interceptors/item_interceptor.dart';

class ItemService {
  final Dio _dio;
  final String sectionApi = '$baseUrlWebService/Item';

  ItemService() : _dio = Dio()..interceptors.add(ItemInterceptor());

  Future<BaseResponse> addItem(ItemRequest item) async {
    final url = sectionApi;

    try {
      final resp = await _dio.post(url, data: item.toJson());
      final data = BaseResponse.fromMap(resp.data);

      return data;
    } on DioException {
      rethrow;
    }
  }

  Future<List<Item>> getItemsList(int sectionId) async {
    final url = '$sectionApi/sectionlist/$sectionId';
    final resp = await _dio.get(url);
    final data = ItemListResponse.fromMap(resp.data);

    return data.itemList!;
  }

  Future<BaseResponse> updateItem(ItemRequest item) async {
    final url = '$sectionApi/${item.item.id}';
    final resp = await _dio.put(url, data: item.toJson());
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

  Future<BaseResponse> deleteItem(int itemId) async {
    final url = '$sectionApi/$itemId';
    final resp = await _dio.delete(url);
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

}