import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceState(
      isCheckIn: true,
      currentTime: DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now())
  )) {
    on<ToggleCheckInMode>(_onToggleCheckInMode);
    on<SubmitAttendance>(_onSubmitAttendance);
    on<CloseDialog>(_onCloseDialog);

    // Update time every second
    Stream.periodic(Duration(seconds: 1)).listen((_) {
      add(ToggleCheckInMode(state.isCheckIn));
    });
  }

  void _onToggleCheckInMode(ToggleCheckInMode event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(
        isCheckIn: event.isCheckIn,
        currentTime: DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now())
    ));
  }

  void _onSubmitAttendance(SubmitAttendance event, Emitter<AttendanceState> emit) {
    if (event.employeeId.isNotEmpty) {
      emit(state.copyWith(
          employeeId: event.employeeId,
          showDialog: true,
          currentTime: DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now())
      ));
    }
  }

  void _onCloseDialog(CloseDialog event, Emitter<AttendanceState> emit) {
    emit(state.copyWith(showDialog: false));
  }
}
