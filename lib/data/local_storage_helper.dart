// data/local_storage_helper.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thai_take_away_back_end/data/model/user_model.dart';

class LocalStorageHelper {
  static const String _tokenKey = "auth_token";
  static const String _refreshKey = "refresh_token";
  static const String _userKey = "auth_user";

  /// บันทึก Access Token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// ดึง Access Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// บันทึก Refresh Token
  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshKey, token);
  }

  /// ดึง Refresh Token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshKey);
  }

  /// บันทึกข้อมูล User
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  /// ดึงข้อมูล User
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_userKey);
    return json == null ? null : UserModel.fromJson(jsonDecode(json));
  }

  /// ลบข้อมูลทั้งหมด (Token, RefreshToken, User) -> ใช้เมื่อล็อกเอาต์
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshKey);
    await prefs.remove(_userKey);
  }
}
