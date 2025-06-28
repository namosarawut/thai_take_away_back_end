// lib/data/model/order_model.dart

class OrderModel {
  final int orderID;
  final int customerID;
  final String phoneNumber;
  final String orderStatus;
  final double totalPrice;
  final DateTime createdAt;

  OrderModel({
    required this.orderID,
    required this.customerID,
    required this.phoneNumber,
    required this.orderStatus,
    required this.totalPrice,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderID: json['OrderID'] as int,
      customerID: json['CustomerID'] as int,
      phoneNumber: json['PhoneNumber'] as String,
      orderStatus: json['OrderStatus'] as String,
      totalPrice: double.parse(json['TotalPrice'].toString()),
      createdAt: DateTime.parse(json['CreatedAt'] as String),
    );
  }
}
