import 'dart:convert';

class BaseResponse {
  BaseResponse({this.success, this.message});

  final bool? success;
  final String? message;

  factory BaseResponse.fromJson(String str) => BaseResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory BaseResponse.fromMap(Map<String, dynamic> json) => BaseResponse(
    success: json['success'],
    message: json['message'],
  );
  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
  };

}