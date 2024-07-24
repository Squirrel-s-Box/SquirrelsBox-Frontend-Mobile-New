import 'dart:convert';

import '../item_specification.dart';

class ItemSpecificationRequest {
  final List<ItemSpecification> specs;

  const ItemSpecificationRequest({
    required this.specs,
  });

  factory ItemSpecificationRequest.fromJson(String str) => ItemSpecificationRequest.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory ItemSpecificationRequest.fromMap(Map<String, dynamic> map) {
    return ItemSpecificationRequest(
      specs: List<ItemSpecification>.from(
        (map['specList'] as List).map<ItemSpecification>(
            (spec) => ItemSpecification.fromMap(spec as Map<String, dynamic>)),
      )
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'specs': specs.map((spec) => spec.toMap()).toList(),
    };
  }
}