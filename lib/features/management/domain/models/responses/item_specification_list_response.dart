import 'dart:convert';

import '../item_specification.dart';

class ItemSpecificationListResponse {
  ItemSpecificationListResponse({
    this.specList,
  });

  final List<ItemSpecification>? specList;

  factory ItemSpecificationListResponse.fromJson(String str) =>
      ItemSpecificationListResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory ItemSpecificationListResponse.fromMap(Map<String, dynamic> map) => ItemSpecificationListResponse(
    specList: List<ItemSpecification>.from(
        (map['specList'] as List).map<ItemSpecification>(
                (spec) => ItemSpecification.fromMap(spec as Map<String, dynamic>))
    ),
  );
  Map<String, dynamic> toMap() => {
    'itemList': specList,
  };

}