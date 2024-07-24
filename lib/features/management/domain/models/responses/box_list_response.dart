import 'dart:convert';

import '../box.dart';

class BoxListResponse {
  BoxListResponse({
    this.boxList,
  });

  final List<Box>? boxList;

  factory BoxListResponse.fromJson(String str) => BoxListResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory BoxListResponse.fromMap(Map<String, dynamic> map) => BoxListResponse(
    boxList: List<Box>.from(
        (map['boxList'] as List).map<Box>(
                (box) => Box.fromMap(box as Map<String, dynamic>))
    ),
  );
  Map<String, dynamic> toMap() => {
    'boxList': boxList,
  };

}