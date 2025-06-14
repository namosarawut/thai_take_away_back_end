import 'dart:developer';

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
    // เช็คอิน
    on<CheckInRequested>((event, emit) async {
      emit(AttendanceCallApiLoading());
      try {
        final resp = await repository.checkInEmployee(
          employeeID: event.employeeID,
        );
        emit(AttendanceCallApiSuccess(
          message: resp.message,
          name: resp.data.name,
          timestamp: resp.data.checkInTime,
        ));
      } catch (e) {
        emit(AttendanceCallApiFailure(e.toString()));
      }
    });

    // เช็คเอาท์
    on<CheckOutRequested>((event, emit) async {
      emit(AttendanceCallApiLoading());
      log("[namo log] event.employeeID : ${event.employeeID}");
      try {
        final resp = await repository.checkOutEmployee(
          employeeID: event.employeeID,
        );
        emit(AttendanceCallApiSuccess(
          message: resp.message,
          name: resp.data.name,
          timestamp: resp.data.checkOutTime,
        ));
      } catch (e) {
        emit(AttendanceCallApiFailure(e.toString()));
      }
    });
  }
}
