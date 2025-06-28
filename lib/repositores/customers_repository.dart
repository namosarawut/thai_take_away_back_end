// lib/repositores/customers_repository.dart

import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/data/model/ban_customer_response.dart';
import 'package:thai_take_away_back_end/data/model/customer_orders_response.dart';
import 'package:thai_take_away_back_end/data/model/customers_response.dart';
import 'package:thai_take_away_back_end/data/model/unban_customer_response.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class CustomersRepository {
  final ApiService apiService;

  CustomersRepository(this.apiService);

  /// GET /api/customers?page=&limit=
  Future<CustomersResponse> getCustomers({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await apiService.get(
        '/api/customers',
        query: {
          'page': page.toString(),
          'limit': limit.toString(),
        },
      );
      return CustomersResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Unknown server error';
      throw Exception('Server Error: $msg');
    } catch (e) {
      throw Exception('Failed to load customers: $e');
    }

  }

  /// PUT /api/customers/{id}/ban
  Future<BanCustomerResponse> banCustomer(int customerId) async {
    try {
      final response = await apiService.put('/api/customers/$customerId/ban');
      return BanCustomerResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final m = e.response?.data?['message'] ?? 'Unknown server error';
      throw Exception('Server Error: $m');
    } catch (e) {
      throw Exception('Failed to ban customer: $e');
    }
  }

  /// PUT /api/customers/{id}/unban
  Future<UnbanCustomerResponse> unbanCustomer(int customerId) async {
    try {
      final response = await apiService.put('/api/customers/$customerId/unban');
      return UnbanCustomerResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final m = e.response?.data?['message'] ?? 'Unknown server error';
      throw Exception('Server Error: $m');
    } catch (e) {
      throw Exception('Failed to unban customer: $e');
    }
  }

  /// GET /api/customers/{id}/orders?startDate=&endDate=
  Future<CustomerOrdersResponse> getCustomerOrders({
    required int customerId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await apiService.get(
      '/api/customers/$customerId/orders',
      query: {
        'startDate': startDate.toIso8601String().split('T').first,
        'endDate': endDate.toIso8601String().split('T').first,
      },
    );
    return CustomerOrdersResponse.fromJson(response.data as Map<String, dynamic>);
  }

}
