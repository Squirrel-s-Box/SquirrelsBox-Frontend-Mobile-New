import 'dart:convert';

import '../../../../util/domain/models/response/base_response.dart';
import '../session_info.dart';

class RegisterResponse{
  final BaseResponse itemResource;
  final SessionInfo info;

  const RegisterResponse({
    required this.itemResource,
    required this.info,
  });

  factory RegisterResponse.fromJson(String str) => RegisterResponse.fromMap(json.decode(str));

  factory RegisterResponse.fromMap(Map<String, dynamic> map) => RegisterResponse(
    itemResource: BaseResponse.fromMap(map['itemResource']),
    info: SessionInfo(
      code: map['code'],
      token: map['token'],
      refreshToken: map['refreshToken']
    ),
  );
}