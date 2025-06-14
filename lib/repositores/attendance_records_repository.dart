// repositores/attendance_records_repository.dart

import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/data/model/attendance_records_response.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class AttendanceRecordsRepository {
  final ApiService apiService;
  AttendanceRecordsRepository(this.apiService);

  /// GET /api/employees?type=attendance&page=&limit=&startDate=&endDate=&employeeID=
  Future<AttendanceRecordsResponse> getAttendanceRecords({
    required int page,
    required int limit,
    required String startDate,
    required String endDate,
    required String employeeID,
  }) async {
    try {
      final response = await apiService.get(
        '/api/employees',
        query: {
          'type': 'attendance',
          'page': page.toString(),
          'limit': limit.toString(),
          'startDate': startDate,
          'endDate': endDate,
          'employeeID': employeeID,
        },
      );
      return AttendanceRecordsResponse.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Unknown server error';
      throw Exception('Server Error: $msg');
    } catch (e) {
      throw Exception('Failed to load attendance records: $e');
    }
  }
}
