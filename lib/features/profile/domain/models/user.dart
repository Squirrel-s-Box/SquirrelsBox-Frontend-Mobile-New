import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String? username;
  final String? name;
  final String? lastname;
  final String? email;
  final String? photo;
  final String? code;

  const User({
    this.username,
    this.name,
    this.lastname,
    this.email,
    this.photo,
    this.code,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> map) => User(
    username: map['username'],
    name: map['name'],
    lastname: map['lastname'],
    email: map['email'],
    photo: map['userPhoto'],
    code: map['userCode'],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'username': username,
    'name': name,
    'lastname': lastname,
    'email': email,
    'userPhoto': photo,
    'userCode': code,
  };

  User copyWith({
    String? username,
    String? name,
    String? lastname,
    String? email,
    String? photo,
    String? code,
  }) {
    return User(
      username: username ?? this.username,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [email, code];
}