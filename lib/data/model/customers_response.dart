// lib/data/model/customers_response.dart

import 'package:thai_take_away_back_end/data/model/customer_model.dart';
import 'package:thai_take_away_back_end/data/model/pagination_model.dart';

class CustomersResponse {
  final List<CustomerModel> data;
  final PaginationModel pagination;

  CustomersResponse({
    required this.data,
    required this.pagination,
  });

  factory CustomersResponse.fromJson(Map<String, dynamic> json) {
    return CustomersResponse(
      data: (json['data'] as List)
          .map((e) => CustomerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
      PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }
}
