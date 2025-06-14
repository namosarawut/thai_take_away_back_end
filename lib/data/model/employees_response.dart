// data/model/employees_response.dart

import 'employee_model.dart';
import 'pagination_model.dart';

class EmployeesResponse {
  final List<EmployeeModel> data;
  final PaginationModel pagination;

  EmployeesResponse({
    required this.data,
    required this.pagination,
  });

  factory EmployeesResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List)
        .map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return EmployeesResponse(
      data: list,
      pagination: PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }
}
