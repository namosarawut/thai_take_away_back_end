import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thai_take_away_back_end/data/model/attendance_record_model.dart';
import 'package:thai_take_away_back_end/data/model/pagination_model.dart';
import 'package:thai_take_away_back_end/repositores/attendance_records_repository.dart';

part 'attendance_records_event.dart';
part 'attendance_records_state.dart';


class AttendanceRecordsBloc
    extends Bloc<AttendanceRecordsEvent, AttendanceRecordsState> {
  final AttendanceRecordsRepository repository;

  AttendanceRecordsBloc(this.repository)
      : super(AttendanceRecordsInitial()) {
    on<FetchAttendanceRecords>((event, emit) async {
      emit(AttendanceRecordsLoading());
      try {
        final resp = await repository.getAttendanceRecords(
          page: event.page,
          limit: event.limit,
          startDate: event.startDate,
          endDate: event.endDate,
          employeeID: event.employeeID,
        );
        emit(AttendanceRecordsLoaded(
          records: resp.data,
          pagination: resp.pagination,
        ));
      } catch (e) {
        emit(AttendanceRecordsError(e.toString()));
      }
    });
  }
}

