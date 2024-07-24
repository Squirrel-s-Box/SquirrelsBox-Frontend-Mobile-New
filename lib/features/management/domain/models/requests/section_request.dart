import 'dart:convert';

import '../section.dart';

class SectionRequest {
  final int boxId;
  final Section section;

  const SectionRequest({
    required this.boxId,
    required this.section,
  });

  factory SectionRequest.fromJson(String str) => SectionRequest.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory SectionRequest.fromMap(Map<String, dynamic> map) {
    return SectionRequest(
      boxId: map['boxId'],
      section: map['section'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'boxId': boxId,
      'section': section.toMap(),
    };
  }
}