import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Singleton pattern
  static final SecureStorage _instance = SecureStorage._internal();

  factory SecureStorage() {
    return _instance;
  }

  SecureStorage._internal();

  // Save data securely
  Future<void> saveSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read secure data
  Future<String?> getSecureData(String key) async {
    return await _storage.read(key: key);
  }

  // Delete secure data
  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }

  // Hash a string (for comparing passwords etc.)
  String hashString(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}