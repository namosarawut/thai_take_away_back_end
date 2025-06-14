// repositores/attendance_repository.dart

import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/data/model/attendance_model.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class AttendanceRepository {
  final ApiService apiService;

  AttendanceRepository(this.apiService);

  /// ตรวจเช็คอินพนักงาน (Check-in)
  Future<CheckInResponse> checkInEmployee({ required String employeeID }) async {
    try {
      final requestBody = {
        "employeeID": employeeID,
      };

      final response = await apiService.post(
        "/api/attendance/checkin",
        data: requestBody,
      );
      // response.data จะเป็น Map<String, dynamic> ของ JSON ข้างล่าง
      // {
      //   "message": "Check-in successful",
      //   "data": {
      //     "name": "Somsri",
      //     "checkInTime": "2025-06-03T14:56:43.725Z"
      //   }
      // }
      return CheckInResponse.fromJson(response.data);
    } on DioException catch (e) {
      // ถ้ามีโค้ดสถานะ 4xx/5xx หรือ network error
      final serverMessage = e.response?.data?["message"] ?? "Unknown server error";
      throw Exception("Server Error: $serverMessage");
    } catch (e) {
      throw Exception("Failed to check-in: $e");
    }
  }
  /// ตรวจเช็คเอาท์พนักงาน (Check-out)

  Future<CheckOutResponse> checkOutEmployee({ required String employeeID }) async {
    try {
      final requestBody = {
        "employeeID": employeeID,
      };

      final response = await apiService.post(
        "/api/attendance/checkout",
        data: requestBody,
      );
      return CheckOutResponse.fromJson(response.data);
    } on DioException catch (e) {
      final serverMessage = e.response?.data?["message"] ?? "Unknown server error";
      throw Exception("Server Error: $serverMessage");
    } catch (e) {
      throw Exception("Failed to check-in: $e");
    }
  }

}
