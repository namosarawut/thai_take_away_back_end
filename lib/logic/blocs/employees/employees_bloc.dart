import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thai_take_away_back_end/data/model/employee_model.dart';
import 'package:thai_take_away_back_end/data/model/pagination_model.dart';
import 'package:thai_take_away_back_end/repositores/employees_repository.dart';

part 'employees_event.dart';
part 'employees_state.dart';


class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final EmployeesRepository repository;

  EmployeesBloc(this.repository) : super(EmployeesInitial()) {
    on<FetchEmployees>((event, emit) async {
      emit(EmployeesLoading());
      try {
        final resp = await repository.getAllEmployees(
          type: event.type,
          page: event.page,
          limit: event.limit,
        );
        emit(EmployeesLoaded(
          employees: resp.data,
          pagination: resp.pagination,
        ));
      } catch (e) {
        emit(EmployeesError(e.toString()));
      }
    });
  }
}

