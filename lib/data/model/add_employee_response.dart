// data/model/add_employee_response.dart

class AddEmployeeResponse {
  final String message;
  final String employeeID;

  AddEmployeeResponse({
    required this.message,
    required this.employeeID,
  });

  factory AddEmployeeResponse.fromJson(Map<String, dynamic> json) {
    return AddEmployeeResponse(
      message: json['message'] as String,
      employeeID: json['employeeID'] as String,
    );
  }
}
