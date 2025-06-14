part of 'add_employee_bloc.dart';


@immutable
abstract class AddEmployeeEvent {}

/// Triggered when the user submits the add form
class AddEmployeeRequested extends AddEmployeeEvent {
  final String name;
  final String position;

  AddEmployeeRequested({
    required this.name,
    required this.position,
  });
}

