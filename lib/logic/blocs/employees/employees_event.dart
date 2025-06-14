part of 'employees_bloc.dart';


@immutable
abstract class EmployeesEvent {}

/// Fetch the list of employees with pagination
class FetchEmployees extends EmployeesEvent {
  final String type;
  final int page;
  final int limit;

  FetchEmployees({
    this.type = 'all',
    this.page = 1,
    this.limit = 10,
  });
}

