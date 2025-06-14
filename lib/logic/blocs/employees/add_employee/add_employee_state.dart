part of 'add_employee_bloc.dart';


@immutable
abstract class AddEmployeeState {}

class AddEmployeeInitial extends AddEmployeeState {}
class AddEmployeeLoading extends AddEmployeeState {}

/// Success: message + new ID
class AddEmployeeSuccess extends AddEmployeeState {
  final String message;
  final String employeeID;

  AddEmployeeSuccess({
    required this.message,
    required this.employeeID,
  });
}

class AddEmployeeFailure extends AddEmployeeState {
  final String error;
  AddEmployeeFailure(this.error);
}

