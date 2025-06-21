import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositores/employees_repository.dart';

part 'delete_employee_event.dart';
part 'delete_employee_state.dart';


class DeleteEmployeeBloc extends Bloc<DeleteEmployeeEvent, DeleteEmployeeState> {
  final EmployeesRepository repository;

  DeleteEmployeeBloc(this.repository) : super(DeleteEmployeeInitial()) {
    on<DeleteEmployeeRequested>((event, emit) async {
      emit(DeleteEmployeeLoading());
      try {
        final resp = await repository.deleteEmployee(employeeID: event.employeeID);
        emit(DeleteEmployeeSuccess(resp.message));
      } catch (e) {
        emit(DeleteEmployeeFailure(e.toString()));
      }
    });
  }
}
