import 'dart:convert';

import 'package:equatable/equatable.dart';

class SessionInfo extends Equatable{
  final String? code;
  final String? refreshToken;
  final String? token;

  const SessionInfo({
    this.code,
    this.refreshToken,
    this.token,
  });

  factory SessionInfo.fromJson(String str) => SessionInfo.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory SessionInfo.fromMap(Map<String, dynamic> map) => SessionInfo(
    code: map['code'],
    refreshToken: map[''],
    token: map['token'],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'code': code,
    'refreshToken': refreshToken,
    'token': token,
  };

  SessionInfo copyWith({
    String? code,
    String? refreshToken,
    String? token,
  }) {
    return SessionInfo(
      code: code ?? this.code,
      refreshToken: refreshToken ?? this.refreshToken,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [code, refreshToken, token];
}