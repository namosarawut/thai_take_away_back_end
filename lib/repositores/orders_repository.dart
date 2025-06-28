import 'package:dio/dio.dart';
import 'package:thai_take_away_back_end/data/model/order_detail_model.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class OrdersRepository {
  final ApiService apiService;

  OrdersRepository(this.apiService);

  /// GET /api/orders/{orderId}
  Future<OrderDetailModel> getOrderDetail(int orderId) async {
    try {
      final response = await apiService.get('/api/orders/$orderId');
      return OrderDetailModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Unknown server error';
      throw Exception('Server Error: $msg');
    } catch (e) {
      throw Exception('Failed to fetch order detail: $e');
    }
  }
}
