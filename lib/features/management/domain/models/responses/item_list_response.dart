import 'dart:convert';

import '../item.dart';

class ItemListResponse {
  ItemListResponse({
    this.itemList,
  });

  final List<Item>? itemList;

  factory ItemListResponse.fromJson(String str) => ItemListResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory ItemListResponse.fromMap(Map<String, dynamic> map) => ItemListResponse(
    itemList: List<Item>.from(
        (map['sectionList'] as List).map<Item>(
                (item) => Item.fromMap(item as Map<String, dynamic>))
    ),
  );
  Map<String, dynamic> toMap() => {
    'itemList': itemList,
  };

}