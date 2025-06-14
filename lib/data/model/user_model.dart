// data/model/user_model.dart

class UserModel {
  final String employeeID;
  final String name;
  final String position;

  UserModel({
    required this.employeeID,
    required this.name,
    required this.position,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      employeeID: json['employeeID'] as String,
      name: json['name'] as String,
      position: json['position'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeID': employeeID,
      'name': name,
      'position': position,
    };
  }
}
