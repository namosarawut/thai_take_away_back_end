// lib/logic/blocs/attendance_records/attendance_records_event.dart

part of 'attendance_records_bloc.dart';

@immutable
abstract class AttendanceRecordsEvent {}

class FetchAttendanceRecords extends AttendanceRecordsEvent {
  final int page;
  final int limit;
  final DateTime startDate;
  final DateTime endDate;
  final String employeeID;
  final DateTime? startDateForFilter;
  final DateTime? endDateForFilter;

  FetchAttendanceRecords({
    this.page = 1,
    this.limit = 5,
    required this.startDate,
    required this.endDate,
    this.employeeID = '',
    this.startDateForFilter,
    this.endDateForFilter,
  });
}
