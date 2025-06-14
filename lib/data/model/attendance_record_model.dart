// data/model/attendance_record_model.dart

class AttendanceRecordModel {
  final int recordID;
  final String name;
  final DateTime checkIn;
  final DateTime checkOut;
  final double workHours;

  AttendanceRecordModel({
    required this.recordID,
    required this.name,
    required this.checkIn,
    required this.checkOut,
    required this.workHours,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      recordID: json['recordID'] as int,
      name: json['name'] as String,
      checkIn: DateTime.parse(json['checkIn'] as String),
      checkOut: DateTime.parse(json['checkOut'] as String),
      workHours: double.parse(json['workHours'] as String),
    );
  }
}
