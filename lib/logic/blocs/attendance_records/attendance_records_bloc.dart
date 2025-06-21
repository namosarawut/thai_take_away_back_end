// lib/logic/blocs/attendance_records/attendance_records_bloc.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/data/model/attendance_record_model.dart';
import 'package:thai_take_away_back_end/data/model/pagination_model.dart';
import 'package:thai_take_away_back_end/repositores/attendance_records_repository.dart';

part 'attendance_records_event.dart';
part 'attendance_records_state.dart';

class AttendanceRecordsBloc
    extends Bloc<AttendanceRecordsEvent, AttendanceRecordsState> {
  final AttendanceRecordsRepository repository;

  AttendanceRecordsBloc(this.repository)
      : super(const AttendanceRecordsInitial()) {
    on<FetchAttendanceRecords>((event, emit) async {
      final prev = state;

      // Sentinel: ถ้า employeeID == 'namoFag' ให้ใช้ค่าตัวกรองเดิมทั้งหมด
      final useOldFilter = event.employeeID == 'namoFag' &&
          prev.startDateForFilter != null &&
          prev.endDateForFilter != null &&
          prev.employeeIDForFilter.isNotEmpty;

      // Check ว่าเป็นการส่ง filter ใหม่ปกติหรือไม่
      final hasNewFilter = event.employeeID.isNotEmpty &&
          event.startDateForFilter != null &&
          event.endDateForFilter != null &&
          event.employeeID != 'namoFag';

      // กำหนดค่าที่จะเรียก API
      late final DateTime callStart;
      late final DateTime callEnd;
      late final String callEmployee;

      // ถ้า sentinel ใช้ตัวกรองเก่า
      if (useOldFilter) {
        callStart = prev.startDateForFilter!;
        callEnd = prev.endDateForFilter!;
        callEmployee = prev.employeeIDForFilter;
      }
      // ถ้าเป็น filter ใหม่
      else if (hasNewFilter) {
        callStart = event.startDateForFilter!;
        callEnd = event.endDateForFilter!;
        callEmployee = event.employeeID;
      }
      // กรณีทั่วไป (ไม่กรอง)
      else {
        callStart = event.startDate;
        callEnd = event.endDate;
        callEmployee = event.employeeID;
      }

      // เตรียมค่าตัวกรองที่จะเก็บไว้ใน state ถัดไป
      final nextStartFilter = useOldFilter
          ? prev.startDateForFilter
          : hasNewFilter
          ? event.startDateForFilter
          : null;
      final nextEndFilter = useOldFilter
          ? prev.endDateForFilter
          : hasNewFilter
          ? event.endDateForFilter
          : null;
      final nextEmployeeFilter = useOldFilter
          ? prev.employeeIDForFilter
          : hasNewFilter
          ? event.employeeID
          : '';

      // Emit loading พร้อมตัวกรองปัจจุบัน
      emit(AttendanceRecordsLoading(
        startDateForFilter: nextStartFilter,
        endDateForFilter: nextEndFilter,
        employeeIDForFilter: nextEmployeeFilter,
      ));

      try {
        final resp = await repository.getAttendanceRecords(
          page: event.page,
          limit: event.limit,
          startDate: callStart,
          endDate: callEnd,
          employeeID: callEmployee,
        );

        emit(AttendanceRecordsLoaded(
          records: resp.data,
          pagination: resp.pagination,
          startDateForFilter: nextStartFilter,
          endDateForFilter: nextEndFilter,
          employeeIDForFilter: nextEmployeeFilter,
        ));
      } catch (e) {
        emit(AttendanceRecordsError(
          e.toString(),
          startDateForFilter: nextStartFilter,
          endDateForFilter: nextEndFilter,
          employeeIDForFilter: nextEmployeeFilter,
        ));
      }
    });
  }
}
