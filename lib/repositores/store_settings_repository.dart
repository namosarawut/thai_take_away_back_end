// repositores/store_settings_repository.dart

import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/data/model/store_settings_model.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class StoreSettingsRepository {
  final ApiService apiService;

  StoreSettingsRepository(this.apiService);

  /// GET /api/store-settings
  Future<StoreSettingsModel> getStoreSettings() async {
    try {
      final response = await apiService.get('/api/store-settings');
      return StoreSettingsModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Unknown server error';
      throw Exception('Server Error: $msg');
    } catch (e) {
      throw Exception('Failed to load store settings: $e');
    }
  }
  /// POST /api/store-settings (update)
  Future<String> updateStoreSettings(StoreSettingsModel settings) async {
    final body = {
      'latitude': settings.latitude,
      'longitude': settings.longitude,
      'serviceRadius': settings.serviceRadius * 1000, // km → meters
    };
    final response = await apiService.post('/api/store-settings', data: body);
    return response.data['message'] as String;
  }
}
