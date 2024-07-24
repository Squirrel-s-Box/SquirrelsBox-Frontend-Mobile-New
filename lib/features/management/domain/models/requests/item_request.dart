import 'dart:convert';

import '../item.dart';

class ItemRequest {
  final int sectionId;
  final Item item;

  const ItemRequest({
    required this.sectionId,
    required this.item,
  });

  factory ItemRequest.fromJson(String str) => ItemRequest.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory ItemRequest.fromMap(Map<String, dynamic> map) {
    return ItemRequest(
      sectionId: map['sectionId'],
      item: map['item'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sectionId': sectionId,
      'item': item.toMap(),
    };
  }
}