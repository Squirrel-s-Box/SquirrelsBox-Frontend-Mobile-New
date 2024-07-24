import 'dart:convert';

import 'package:equatable/equatable.dart';

class Item extends Equatable  {
  final int? id;
  final String? name;
  final String? description;
  final String? amount;
  final String? itemPhoto;
  final String? creationDate;
  final String? lastUpdateDate;

  const Item({
    this.id,
    this.name,
    this.description,
    this.amount,
    this.itemPhoto,
    this.creationDate,
    this.lastUpdateDate,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> itemMap = map['item'];
    return Item(
      id: itemMap['id'],
      name: itemMap['name'],
      description: itemMap['description'],
      amount: itemMap['amount'],
      itemPhoto: itemMap['itemPhoto'],
      creationDate: itemMap['creationDate'],
      lastUpdateDate: itemMap['lastUpdateDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'amount': amount,
      'itemPhoto': itemPhoto,
    };
  }

  Item copyWith({
    int? id,
    String? name,
    String? description,
    String? amount,
    String? itemPhoto,
    String? creationDate,
    String? lastUpdateDate,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      itemPhoto: itemPhoto ?? this.itemPhoto,
      creationDate: creationDate ?? this.creationDate,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
    );
  }

  @override
  List<Object?> get props => [id, name, creationDate];
}