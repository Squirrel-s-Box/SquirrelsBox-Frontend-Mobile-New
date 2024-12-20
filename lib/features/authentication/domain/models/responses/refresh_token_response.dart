import 'dart:convert';

class RefreshTokenResponse {
  final String token;
  final String refreshToken;

  const RefreshTokenResponse({
    required this.token,
    required this.refreshToken,
  });

  factory RefreshTokenResponse.fromJson(String str) => RefreshTokenResponse.fromMap(json.decode(str));

  factory RefreshTokenResponse.fromMap(Map<String, dynamic> map) => RefreshTokenResponse(
    token: map['token'],
    refreshToken: map['refreshToken']
  );
}