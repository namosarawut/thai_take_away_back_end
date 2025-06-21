// lib/logic/blocs/attendance_records/attendance_records_state.dart

part of 'attendance_records_bloc.dart';

@immutable
abstract class AttendanceRecordsState {
  final DateTime? startDateForFilter;
  final DateTime? endDateForFilter;
  final String employeeIDForFilter;

  const AttendanceRecordsState({
    this.startDateForFilter,
    this.endDateForFilter,
    this.employeeIDForFilter = '',
  });
}

class AttendanceRecordsInitial extends AttendanceRecordsState {
  const AttendanceRecordsInitial()
      : super(
    startDateForFilter: null,
    endDateForFilter: null,
    employeeIDForFilter: '',
  );
}

class AttendanceRecordsLoading extends AttendanceRecordsState {
  const AttendanceRecordsLoading({
    DateTime? startDateForFilter,
    DateTime? endDateForFilter,
    String employeeIDForFilter = '',
  }) : super(
    startDateForFilter: startDateForFilter,
    endDateForFilter: endDateForFilter,
    employeeIDForFilter: employeeIDForFilter,
  );
}

class AttendanceRecordsLoaded extends AttendanceRecordsState {
  final List<AttendanceRecordModel> records;
  final PaginationModel pagination;

  const AttendanceRecordsLoaded({
    required this.records,
    required this.pagination,
    DateTime? startDateForFilter,
    DateTime? endDateForFilter,
    String employeeIDForFilter = '',
  }) : super(
    startDateForFilter: startDateForFilter,
    endDateForFilter: endDateForFilter,
    employeeIDForFilter: employeeIDForFilter,
  );
}

class AttendanceRecordsError extends AttendanceRecordsState {
  final String message;

  const AttendanceRecordsError(
      this.message, {
        DateTime? startDateForFilter,
        DateTime? endDateForFilter,
        String employeeIDForFilter = '',
      }) : super(
    startDateForFilter: startDateForFilter,
    endDateForFilter: endDateForFilter,
    employeeIDForFilter: employeeIDForFilter,
  );
}
