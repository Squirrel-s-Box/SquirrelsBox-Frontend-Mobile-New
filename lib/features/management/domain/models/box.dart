import 'dart:convert';

import 'package:equatable/equatable.dart';

class Box extends Equatable{
  final int? id;
  final String? name;
  final String? creationDate;
  final String? lastUpdateDate;
  final bool? favorite;

  const Box({this.id, this.name, this.creationDate, this.lastUpdateDate, this.favorite});

  factory Box.fromJson(String str) => Box.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory Box.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> boxMap = map['box'];
    return Box(
    id: boxMap['id'],
    name: boxMap['name'],
    creationDate: boxMap['creationDate'],
    lastUpdateDate: boxMap['lastUpdateDate'],
    favorite: boxMap['favorite'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'favorite': favorite,
    };
  }

  Box copyWith({
    int? id,
    String? name,
    String? creationDate,
    String? lastUpdateDate,
    bool? favorite,
  }) {
    return Box(
      id: id ?? this.id,
      name: name ?? this.name,
      creationDate: creationDate ?? this.creationDate,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      favorite: favorite ?? this.favorite,
    );
  }

  @override
  List<Object?> get props => [id, name, creationDate];

}