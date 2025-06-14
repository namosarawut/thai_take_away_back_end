// repositores/auth_repository.dart

import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/data/local_storage_helper.dart';
import 'package:thai_take_away_back_end/data/model/login_response.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class AuthRepository {
  final ApiService apiService;
  AuthRepository(this.apiService);

  Future<LoginResponse> loginEmployee({ required String employeeID }) async {
    final resp = await apiService.post(
      "/api/login",
      data: {"employeeID": employeeID},
    );
    // เก็บ access + refresh token
    await LocalStorageHelper.saveToken(resp.data['accessToken']);
    await LocalStorageHelper.saveRefreshToken(resp.data['refreshToken']);
    return LoginResponse.fromJson(resp.data);
  }

  Future<String> refreshToken() async {
    final refresh = await LocalStorageHelper.getRefreshToken();
    if (refresh == null) throw Exception("No refresh token");
    final resp = await apiService.post(
      "/api/login/refresh",
      data: {"refreshToken": refresh},
    );
    final newToken = resp.data['accessToken'] as String;
    await LocalStorageHelper.saveToken(newToken);
    return newToken;
  }

  Future<void> logout() async {
    await LocalStorageHelper.clearAll();
  }
}
