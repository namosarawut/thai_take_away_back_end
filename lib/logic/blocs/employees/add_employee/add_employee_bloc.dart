import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thai_take_away_back_end/repositores/employees_repository.dart';

part 'add_employee_event.dart';
part 'add_employee_state.dart';


class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final EmployeesRepository repository;

  AddEmployeeBloc(this.repository) : super(AddEmployeeInitial()) {
    on<AddEmployeeRequested>((event, emit) async {
      emit(AddEmployeeLoading());
      try {
        final resp = await repository.addEmployee(
          name: event.name,
          position: event.position,
        );
        emit(AddEmployeeSuccess(
          message: resp.message,
          employeeID: resp.employeeID,
        ));
      } catch (e) {
        emit(AddEmployeeFailure(e.toString()));
      }
    });
  }
}

