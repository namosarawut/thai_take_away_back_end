// repositores/attendance_records_repository.dart

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:thai_take_away_back_end/data/model/attendance_records_response.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class AttendanceRecordsRepository {
  final ApiService apiService;
  AttendanceRecordsRepository(this.apiService);

  /// GET /api/employees?type=attendance&page=&limit=&startDate=&endDate=&employeeID=
  Future<AttendanceRecordsResponse> getAttendanceRecords({
    required int page,
    required int limit,
    required DateTime startDate,
    required DateTime endDate,
    required String employeeID,
  }) async {
    try {
      final formatter = DateFormat('yyyy-MM-dd');
      final response = await apiService.get(
        '/api/employees',
        query: {
          'type': 'attendance',
          'page': page.toString(),
          'limit': limit.toString(),
          'startDate': formatter.format(startDate),
          'endDate':   formatter.format(endDate),
          'employeeID': employeeID,
        },
      );
log("[namo log] : Attendance Records Response: ${response.data}");
      return AttendanceRecordsResponse.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Unknown server error';
      log("[namo log] : Error fetching attendance records: $msg");
      throw Exception('Server Error: $msg');
    } catch (e) {
      log("[namo log] : Error fetching attendance records: $e");
      throw Exception('Failed to load attendance records: $e');
    }
  }
}
