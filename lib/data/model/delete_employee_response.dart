// data/model/delete_employee_response.dart

class DeleteEmployeeResponse {
  final String message;

  DeleteEmployeeResponse({ required this.message });

  factory DeleteEmployeeResponse.fromJson(Map<String, dynamic> json) {
    return DeleteEmployeeResponse(
      message: json['message'] as String,
    );
  }
}
