// lib/data/model/customer_orders_response.dart

import 'package:thai_take_away_back_end/data/model/order_model.dart';

class CustomerOrdersResponse {
  final List<OrderModel> data;
  final double totalPrice;

  CustomerOrdersResponse({
    required this.data,
    required this.totalPrice,
  });

  factory CustomerOrdersResponse.fromJson(Map<String, dynamic> json) {
    return CustomerOrdersResponse(
      data: (json['data'] as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: double.parse(json['totalPrice'].toString()),
    );
  }
}
