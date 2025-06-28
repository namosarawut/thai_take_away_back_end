class BanCustomerResponse {
  final String message;

  BanCustomerResponse({required this.message});

  factory BanCustomerResponse.fromJson(Map<String, dynamic> json) {
    return BanCustomerResponse(
      message: json['message'] as String,
    );
  }
}
