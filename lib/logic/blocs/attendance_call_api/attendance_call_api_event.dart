part of 'attendance_call_api_bloc.dart';

@immutable
abstract class AttendanceCallApiEvent {}

/// Event เรียกเมื่อผู้ใช้กดปุ่ม Check-in
class CheckInRequested extends AttendanceCallApiEvent {
  final String employeeID;

  CheckInRequested(this.employeeID);
}

/// เพิ่ม event สำหรับ check-out
class CheckOutRequested extends AttendanceCallApiEvent {
  final String employeeID;
  CheckOutRequested(this.employeeID);
}
