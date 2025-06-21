// data/model/attendance_record_model.dart

class AttendanceRecordModel {
  final int recordID;
  final String name;
  final DateTime checkIn;
  final DateTime? checkOut;    // now nullable
  final double workHours;      // always a double

  AttendanceRecordModel({
    required this.recordID,
    required this.name,
    required this.checkIn,
    required this.checkOut,
    required this.workHours,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    // parse checkIn: assume always valid ISO
    final checkInStr = json['checkIn'] as String;
    final checkIn = DateTime.parse(checkInStr);

    // parse checkOut: may be a non-date string like "Haven't checked out yet"
    DateTime? checkOut;
    final rawOut = json['checkOut'];
    if (rawOut is String) {
      try {
        checkOut = DateTime.parse(rawOut);
      } catch (_) {
        // not a valid ISO date → leave as null
        checkOut = null;
      }
    }

    // parse workHours: may be null
    double workHours;
    final rawWork = json['workHours'];
    if (rawWork == null) {
      workHours = 0.0;
    } else {
      workHours = double.tryParse(rawWork.toString()) ?? 0.0;
    }

    return AttendanceRecordModel(
      recordID: json['recordID'] as int,
      name: json['name'] as String,
      checkIn: checkIn,
      checkOut: checkOut,
      workHours: workHours,
    );
  }
}
