// repositores/employees_repository.dart

import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/data/model/add_employee_response.dart';
import 'package:thai_take_away_back_end/data/model/delete_employee_response.dart';
import 'package:thai_take_away_back_end/data/model/employees_response.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class EmployeesRepository {
  final ApiService apiService;

  EmployeesRepository(this.apiService);

  /// GET /api/employees?type=all&page=1&limit=10
  Future<EmployeesResponse> getAllEmployees({
    required String type,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await apiService.get(
        '/api/employees',
        query: {
          'type': type,
          'page': page.toString(),
          'limit': limit.toString(),
        },
      );
      return EmployeesResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Unknown server error';
      throw Exception('Server Error: $msg');
    } catch (e) {
      throw Exception('Failed to load employees: $e');
    }
  }

  /// POST /api/employees
  Future<AddEmployeeResponse> addEmployee({
    required String name,
    required String position,
  }) async {
    try {
      final response = await apiService.post(
        '/api/employees',
        data: {
          'name': name,
          'position': position,
        },
      );
      return AddEmployeeResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Unknown server error';
      throw Exception('Server Error: $msg');
    } catch (e) {
      throw Exception('Failed to add employee: $e');
    }
  }
  /// DELETE /api/employees/{employeeID}
  Future<DeleteEmployeeResponse> deleteEmployee({
    required String employeeID,
  }) async {
    try {
      final response = await apiService.delete('/api/employees/$employeeID');
      return DeleteEmployeeResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Unknown server error';
      throw Exception('Server Error: $msg');
    } catch (e) {
      throw Exception('Failed to delete employee: $e');
    }
  }

}
