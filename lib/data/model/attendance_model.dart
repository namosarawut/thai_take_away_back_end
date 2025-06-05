// data/model/attendance_model.dart

class CheckInData {
  final String name;
  final DateTime checkInTime;

  CheckInData({
    required this.name,
    required this.checkInTime,
  });

  factory CheckInData.fromJson(Map<String, dynamic> json) {
    return CheckInData(
      name: json["name"],
      checkInTime: DateTime.parse(json["checkInTime"]),
    );
  }
}

class CheckInResponse {
  final String message;
  final CheckInData data;

  CheckInResponse({
    required this.message,
    required this.data,
  });

  factory CheckInResponse.fromJson(Map<String, dynamic> json) {
    return CheckInResponse(
      message: json["message"],
      data: CheckInData.fromJson(json["data"]),
    );
  }
}
