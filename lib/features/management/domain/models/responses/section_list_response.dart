import 'dart:convert';

import '../section.dart';

class SectionListResponse {
  SectionListResponse({
    this.sectionList,
  });

  final List<Section>? sectionList;

  factory SectionListResponse.fromJson(String str) => SectionListResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory SectionListResponse.fromMap(Map<String, dynamic> map) => SectionListResponse(
    sectionList: List<Section>.from(
        (map['sectionList'] as List).map<Section>(
                (section) => Section.fromMap(section as Map<String, dynamic>))
    ),
  );
  Map<String, dynamic> toMap() => {
    'sectionList': sectionList,
  };

}