part of 'employees_screen_bloc.dart';

abstract class EmployeesScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleEmployeesViewType extends EmployeesScreenEvent {
  final bool isCheckIn;

  ToggleEmployeesViewType(this.isCheckIn);

  @override
  List<Object> get props => [isCheckIn];
}

class SubmitAttendance extends EmployeesScreenEvent {
  final String employeeId;

  SubmitAttendance(this.employeeId);

  @override
  List<Object> get props => [employeeId];
}

class CloseDialog extends EmployeesScreenEvent {}