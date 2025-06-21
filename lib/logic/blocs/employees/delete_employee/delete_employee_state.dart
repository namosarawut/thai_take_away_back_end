part of 'delete_employee_bloc.dart';

@immutable
abstract class DeleteEmployeeState {}

class DeleteEmployeeInitial extends DeleteEmployeeState {}

class DeleteEmployeeLoading extends DeleteEmployeeState {}

/// Success: the employee was deleted
class DeleteEmployeeSuccess extends DeleteEmployeeState {
  final String message;

  DeleteEmployeeSuccess(this.message);
}

class DeleteEmployeeFailure extends DeleteEmployeeState {
  final String error;

  DeleteEmployeeFailure(this.error);
}
