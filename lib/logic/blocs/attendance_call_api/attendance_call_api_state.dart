part of 'attendance_call_api_bloc.dart';


@immutable
abstract class AttendanceCallApiState {}

/// สถานะเริ่มต้น ก่อนกด Check-in
class AttendanceCallApiInitial extends AttendanceCallApiState {}

/// กำลังส่งข้อมูลไปตรวจเช็คอิน
class AttendanceCallApiLoading extends AttendanceCallApiState {}

/// เช็คอินสำเร็จ พร้อมข้อมูลชื่อและเวลา
class AttendanceCallApiSuccess extends AttendanceCallApiState {
  final String message;
  final String name;
  final DateTime checkInTime;

  AttendanceCallApiSuccess({
    required this.message,
    required this.name,
    required this.checkInTime,
  });
}

/// เกิดข้อผิดพลาดขณะเช็คอิน
class AttendanceCallApiFailure extends AttendanceCallApiState {
  final String error;

  AttendanceCallApiFailure(this.error);
}

