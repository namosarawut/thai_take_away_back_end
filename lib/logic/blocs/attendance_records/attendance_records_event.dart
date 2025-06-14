part of 'attendance_records_bloc.dart';

@immutable
abstract class AttendanceRecordsEvent {}

/// Trigger fetching attendance records with filters
class FetchAttendanceRecords extends AttendanceRecordsEvent {
  final int page;
  final int limit;
  final String startDate;
  final String endDate;
  final String employeeID;

  FetchAttendanceRecords({
    this.page = 1,
    this.limit = 5,
    required this.startDate,
    required this.endDate,
    required this.employeeID,
  });
}

