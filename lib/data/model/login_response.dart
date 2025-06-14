// data/model/login_response.dart

import 'package:thai_take_away_back_end/data/model/user_model.dart';

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String role;
  final UserModel employeeData;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
    required this.employeeData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      role: json['role'],
      employeeData: UserModel.fromJson(json['employeeData']),
    );
  }
}
