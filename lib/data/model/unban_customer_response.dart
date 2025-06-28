// lib/data/model/unban_customer_response.dart

class UnbanCustomerResponse {
  final String message;

  UnbanCustomerResponse({ required this.message });

  factory UnbanCustomerResponse.fromJson(Map<String, dynamic> json) {
    return UnbanCustomerResponse(
      message: json['message'] as String,
    );
  }
}
