// lib/data/model/order_item_model.dart

class OrderItemModel {
  final String name;
  final int quantity;
  final double price;
  final String additionalInfo;

  OrderItemModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.additionalInfo,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: double.parse(json['price'].toString()),
      // ถ้า additionalInfo เป็น null หรือไม่ถูกส่งมา จะใช้ค่าว่างแทน
      additionalInfo: (json['additionalInfo'] as String?) ?? '',
    );
  }
}
