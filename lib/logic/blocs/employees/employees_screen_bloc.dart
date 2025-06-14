import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'employees_screen_event.dart';
part 'employees_screen_state.dart';

class EmployeesScreenBloc extends Bloc<EmployeesScreenEvent, EmployeesScreenState> {
  EmployeesScreenBloc() : super(EmployeesScreenState(
      isViewEmployeeList: true,
      currentTime: DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now())
  )) {
    on<ToggleEmployeesViewType>(_onToggleEmployeesViewType);
    on<SubmitAttendance>(_onSubmitAttendance);
    on<CloseDialog>(_onCloseDialog);

    // Update time every second
    Stream.periodic(Duration(seconds: 1)).listen((_) {
      add(ToggleEmployeesViewType(state.isViewEmployeeList));
    });
  }

  void _onToggleEmployeesViewType(ToggleEmployeesViewType event, Emitter<EmployeesScreenState> emit) {
    emit(state.copyWith(
        isCheckIn: event.isCheckIn,
        currentTime: DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now())
    ));
  }

  void _onSubmitAttendance(SubmitAttendance event, Emitter<EmployeesScreenState> emit) {
    if (event.employeeId.isNotEmpty) {
      emit(state.copyWith(
          employeeId: event.employeeId,
          showDialog: true,
          currentTime: DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now())
      ));
    }
  }

  void _onCloseDialog(CloseDialog event, Emitter<EmployeesScreenState> emit) {
    emit(state.copyWith(showDialog: false));
  }
}
