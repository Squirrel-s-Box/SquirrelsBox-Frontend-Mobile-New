import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserLogin extends Equatable{
  final String? username;
  final String? password;

  const UserLogin({
    this.username,
    this.password,
  });

  factory UserLogin.fromJson(String str) => UserLogin.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory UserLogin.fromMap(Map<String, dynamic> map) => UserLogin(
    username: map['username'],
    password: map['password'],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'username': username,
    'password': password,
  };

  UserLogin copyWith({
    String? username,
    String? password,
  }) {
    return UserLogin(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [username, password];
}