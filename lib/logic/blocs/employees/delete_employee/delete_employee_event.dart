part of 'delete_employee_bloc.dart';

@immutable
abstract class DeleteEmployeeEvent {}

/// Triggered when user requests deletion
class DeleteEmployeeRequested extends DeleteEmployeeEvent {
  final String employeeID;

  DeleteEmployeeRequested(this.employeeID);
}
