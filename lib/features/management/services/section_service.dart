import 'package:dio/dio.dart';

import '../../util/constants/strings.dart';
import '../../util/domain/models/response/base_response.dart';
import '../domain/models/requests/section_request.dart';
import '../domain/models/responses/section_list_response.dart';
import '../domain/models/section.dart';
import 'interceptors/section_interceptor.dart';

class SectionService {
  final Dio _dio;
  final String sectionApi = '$baseUrlWebService/Section';

  SectionService() : _dio = Dio()..interceptors.add(SectionInterceptor());

  Future<BaseResponse> addSection(SectionRequest section) async {
    final url = sectionApi;
    final resp = await _dio.post(url, data: section.toJson());
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

  Future<List<Section>> getSectionList(int boxId) async {
    final url = '$sectionApi/sectionlist/$boxId';
    final resp = await _dio.get(url);
    final data = SectionListResponse.fromMap(resp.data);

    return data.sectionList!;
  }

  Future<BaseResponse> updateSection(SectionRequest section) async {
    final url = '$sectionApi/${section.section.id}';
    final resp = await _dio.put(url, data: section.toJson());
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

  Future<BaseResponse> deleteSection(int sectionId) async {
    final url = '$sectionApi/$sectionId';
    final resp = await _dio.delete(url);
    final data = BaseResponse.fromMap(resp.data);

    return data;
  }

}