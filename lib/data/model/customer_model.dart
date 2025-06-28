// lib/data/model/customer_model.dart

class CustomerModel {
  final int customerID;
  final String phoneNumber;
  final String status;
  final DateTime createdAt;

  CustomerModel({
    required this.customerID,
    required this.phoneNumber,
    required this.status,
    required this.createdAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerID: json['CustomerID'] as int,
      phoneNumber: json['PhoneNumber'] as String,
      status: json['Status'] as String,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
    );
  }
}
