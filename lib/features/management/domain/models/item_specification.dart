import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ItemSpecification extends Equatable  {
  final int? id;
  final int? itemId;
  final String? name;
  final String? value;
  final String? type;
  final String? creationDate;
  final String? lastUpdateDate;
  final TextEditingController controller = TextEditingController(); // to FormFields

  ItemSpecification({
    this.id,
    this.itemId,
    this.name,
    this.value,
    this.type,
    this.creationDate,
    this.lastUpdateDate,
  });

  factory ItemSpecification.fromJson(String str) => ItemSpecification.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory ItemSpecification.fromMap(Map<String, dynamic> map) {
    return ItemSpecification(
      id: map['id'],
      name: map['headerName'],
      value: map['value'],
      type: map['valueType'],
      creationDate: map['creationDate'],
      lastUpdateDate: map['lastUpdateDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'itemId': itemId,
      'headerName': name,
      'value': value,
      'valueType': type,
    };
  }

  ItemSpecification copyWith({
    int? id,
    int? itemId,
    String? name,
    String? value,
    String? type,
    String? creationDate,
    String? lastUpdateDate,
  }) {
    return ItemSpecification(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      value: value ?? this.value,
      type: type ?? this.type,
      creationDate: creationDate ?? this.creationDate,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
    );
  }

  @override
  List<Object?> get props => [id, itemId, name, value, type, creationDate];
}