part of 'employees_bloc.dart';

@immutable
abstract class EmployeesState {}

class EmployeesInitial extends EmployeesState {}
class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final List<EmployeeModel> employees;
  final PaginationModel pagination;

  EmployeesLoaded({
    required this.employees,
    required this.pagination,
  });
}

class EmployeesError extends EmployeesState {
  final String message;
  EmployeesError(this.message);
}

