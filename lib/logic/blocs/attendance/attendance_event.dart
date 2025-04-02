part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleCheckInMode extends AttendanceEvent {
  final bool isCheckIn;

  ToggleCheckInMode(this.isCheckIn);

  @override
  List<Object> get props => [isCheckIn];
}

class SubmitAttendance extends AttendanceEvent {
  final String employeeId;

  SubmitAttendance(this.employeeId);

  @override
  List<Object> get props => [employeeId];
}

class CloseDialog extends AttendanceEvent {}