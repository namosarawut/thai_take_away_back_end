// lib/data/model/order_detail_model.dart

import 'order_item_model.dart';

class OrderDetailModel {
  final int orderID;
  final String phoneNumber;
  final String orderStatus;
  final double totalPrice;
  final DateTime createdAt;
  final List<OrderItemModel> orderDetails;

  OrderDetailModel({
    required this.orderID,
    required this.phoneNumber,
    required this.orderStatus,
    required this.totalPrice,
    required this.createdAt,
    required this.orderDetails,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      orderID: json['data']['orderID'] as int,
      phoneNumber: json['data']['phoneNumber'] as String,
      orderStatus: json['data']['orderStatus'] as String,
      totalPrice: double.parse(json['data']['totalPrice'].toString()),
      createdAt: DateTime.parse(json['data']['createdAt'] as String),
      orderDetails: (json['data']['orderDetails'] as List)
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
