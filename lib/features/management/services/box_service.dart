import 'package:dio/dio.dart';

import '../../util/constants/strings.dart';
import '../../util/domain/models/response/base_response.dart';
import '../domain/models/box.dart';
import '../domain/models/responses/box_list_response.dart';
import 'interceptors/box_interceptor.dart';

class BoxService {
  final Dio _dio;
  final String boxApi = '$baseUrlWebService/Box';

  BoxService() : _dio = Dio()..interceptors.add(BoxInterceptor())
    ..options.connectTimeout = const Duration(seconds: 5)
    ..options.receiveTimeout = const Duration(seconds: 5);

  Future<BaseResponse> addBox(Box box, String userCode) async {
    final url = '$boxApi/$userCode';
    final resp = await _dio.post(url, data: box.toJson());
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

  Future<List<Box>> getBoxList(String userCode) async {
    final url = '$boxApi/boxlist/$userCode';
    final resp = await _dio.get(url);
    final data = BoxListResponse.fromMap(resp.data);

    return data.boxList!;
  }

  Future<BaseResponse> updateBox(Box box) async {
    final url = '$boxApi/${box.id}';
    final resp = await _dio.put(url, data: box.toJson());
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

  Future<BaseResponse> deleteBox(int boxId, {bool cascade = false}) async {
    final url = '$boxApi/$boxId/$cascade';
    final resp = await _dio.delete(url);
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

}