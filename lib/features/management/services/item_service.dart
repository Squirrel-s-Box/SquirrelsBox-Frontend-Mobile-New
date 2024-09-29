import 'package:dio/dio.dart';

import '../../util/constants/strings.dart';
import '../../util/domain/models/response/base_response.dart';
import '../../util/logger/app_logger.dart';
import '../domain/models/item.dart';
import '../domain/models/requests/item_request.dart';
import '../domain/models/responses/item_list_response.dart';
import 'interceptors/item_interceptor.dart';

class ItemService {
  final Dio _dio;
  final String api = '$baseUrlWebService/Item';

  ItemService() : _dio = Dio()..interceptors.add(ItemInterceptor());

  Future<BaseResponse> addItem(ItemRequest item, String filePath) async {
    final url = api;

    try {
      _dio.options.headers['content-type'] = 'multipart/form-data';

      final imagePart = filePath.isEmpty ? null : await MultipartFile.fromFile(filePath);

      FormData formData = FormData.fromMap({
        'SectionId': item.sectionId,
        'Item.Name': item.item.name,
        'Item.Description': item.item.description,
        'Item.Amount': item.item.amount,
        'Item.ItemPhoto': item.item.itemPhoto,
        'Image': imagePart,
      });

      AppLogger.info(formData);
      final resp = await _dio.post(url, data: formData);
      AppLogger.info(resp);

      final data = BaseResponse.fromMap(resp.data);
      return data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      rethrow;

    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw DioException(requestOptions: RequestOptions(path: url), error: 'Unexpected error occurred.');
    }
  }

  Future<List<Item>> getItemsList(int sectionId) async {
    final url = '$api/sectionlist/$sectionId';

    try {
      _dio.options.headers['content-type'] = 'application/json';

      final resp = await _dio.get(url);
      AppLogger.info(resp);

      final data = ItemListResponse.fromMap(resp.data);
      return data.itemList!;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      rethrow;

    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw DioException(requestOptions: RequestOptions(path: url), error: 'Unexpected error occurred.');
    }

  }

  Future<BaseResponse> updateItem(ItemRequest item, String filePath) async {
    final url = '$api/${item.item.id}';

    try {
      _dio.options.headers['content-type'] = 'multipart/form-data';

      final imagePart = filePath.isEmpty ? null : await MultipartFile.fromFile(filePath);

      FormData formData = FormData.fromMap({
        'SectionId': item.sectionId,
        'Item.Name': item.item.name,
        'Item.Description': item.item.description,
        'Item.Amount': item.item.amount,
        'Item.ItemPhoto': item.item.itemPhoto,
        'Image': imagePart,
      });

      AppLogger.info(formData);
      final resp = await _dio.put(url, data: formData);
      AppLogger.info(resp);

      _dio.options.headers['content-type'] = 'application/json';
      final data = BaseResponse.fromMap(resp.data);
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

  Future<BaseResponse> deleteItem(int itemId) async {
    final url = '$api/$itemId';

    try {
      final resp = await _dio.delete(url);
      AppLogger.info(resp);

      final data = BaseResponse.fromMap(resp.data);
      return data;

    } on DioException catch (e) {
      AppLogger.error('DioException: ${e.message}');
      rethrow;

    } catch (e) {
      AppLogger.error('Unexpected error: $e');
      throw DioException(requestOptions: RequestOptions(path: url), error: 'Unexpected error occurred.');
    }

  }

}