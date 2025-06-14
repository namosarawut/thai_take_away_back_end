part of 'attendance_records_bloc.dart';


@immutable
abstract class AttendanceRecordsState {}

class AttendanceRecordsInitial extends AttendanceRecordsState {}
class AttendanceRecordsLoading extends AttendanceRecordsState {}

class AttendanceRecordsLoaded extends AttendanceRecordsState {
  final List<AttendanceRecordModel> records;
  final PaginationModel pagination;

  AttendanceRecordsLoaded({
    required this.records,
    required this.pagination,
  });
}

class AttendanceRecordsError extends AttendanceRecordsState {
  final String message;
  AttendanceRecordsError(this.message);
}
