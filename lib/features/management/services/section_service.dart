import '../../util/constants/strings.dart';
import '../../util/domain/models/response/base_response.dart';
import '../domain/models/requests/section_request.dart';
import '../domain/models/responses/section_list_response.dart';
import '../domain/models/section.dart';
import 'management_api_service.dart';

class SectionService {
  final ManagementApiService _dio;
  final String sectionApi = '$baseUrlWebService/Section';

  SectionService() : _dio = ManagementApiService();

  Future<BaseResponse> addSection(SectionRequest section) async {
    final url = sectionApi;
    final resp = await _dio.postRequest(url, section.toJson());
    final data = BaseResponse.fromMap(resp);

    return data;
  }

  Future<List<Section>> getSectionList(int boxId) async {
    final url = '$sectionApi/sectionlist/$boxId';
    final resp = await _dio.getRequest(url);
    final data = SectionListResponse.fromMap(resp);

    return data.sectionList!;
  }

  Future<BaseResponse> updateSection(SectionRequest section) async {
    final url = '$sectionApi/${section.section.id}';
    final resp = await _dio.putRequest(url, section.toJson());
    final data = BaseResponse.fromMap(resp);

    return data;
  }

  Future<BaseResponse> deleteSection(int sectionId) async {
    final url = '$sectionApi/$sectionId';
    final resp = await _dio.deleteRequest(url);
    final data = BaseResponse.fromMap(resp);

    return data;
  }

}