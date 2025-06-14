// data/model/employee_model.dart

class EmployeeModel {
  final String employeeID;
  final String name;
  final String position;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmployeeModel({
    required this.employeeID,
    required this.name,
    required this.position,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      employeeID: json['EmployeeID'] as String,
      name: json['Name'] as String,
      position: json['Position'] as String,
      status: json['Status'] as String,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      updatedAt: DateTime.parse(json['UpdatedAt'] as String),
    );
  }
}
