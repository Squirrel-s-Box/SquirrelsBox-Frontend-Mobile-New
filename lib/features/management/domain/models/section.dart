import 'dart:convert';

import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final int? id;
  final String? name;
  final String? color;
  final String? creationDate;
  final String? lastUpdateDate;

  const Section({
    this.id,
    this.name,
    this.color,
    this.creationDate,
    this.lastUpdateDate,
  });

  factory Section.fromJson(String str) => Section.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory Section.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> sectionMap = map['section'];
    return Section(
      id: sectionMap['id'],
      name: sectionMap['name'],
      color: sectionMap['color'],
      creationDate: sectionMap['creationDate'],
      lastUpdateDate: sectionMap['lastUpdateDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'color': color,
    };
  }

  Section copyWith({
    int? id,
    String? name,
    String? color,
    String? creationDate,
    String? lastUpdateDate,
  }) {
    return Section(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      creationDate: creationDate ?? this.creationDate,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
    );
  }

  @override
  List<Object?> get props => [id, name, creationDate];
}