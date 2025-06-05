import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thai_take_away_back_end/repositores/attendance_repository.dart';

part 'attendance_call_api_event.dart';
part 'attendance_call_api_state.dart';

// attendance_call_api_bloc.dart
class AttendanceCallApiBloc
    extends Bloc<AttendanceCallApiEvent, AttendanceCallApiState> {
  final AttendanceRepository repository;

  AttendanceCallApiBloc(this.repository)
      : super(AttendanceCallApiInitial()) {
    on<CheckInRequested>((event, emit) async {
      emit(AttendanceCallApiLoading());
      try {
        final resp =
        await repository.checkInEmployee(employeeID: event.employeeID);
        emit(
          AttendanceCallApiSuccess(
            message: resp.message,
            name: resp.data.name,
            checkInTime: resp.data.checkInTime,
          ),
        );
      } catch (e) {
        emit(AttendanceCallApiFailure(e.toString()));
      }
    });
  }
}
