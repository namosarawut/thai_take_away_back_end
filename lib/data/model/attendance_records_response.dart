// data/model/attendance_records_response.dart

import 'package:thai_take_away_back_end/data/model/attendance_record_model.dart';
import 'package:thai_take_away_back_end/data/model/pagination_model.dart';

class AttendanceRecordsResponse {
  final List<AttendanceRecordModel> data;
  final PaginationModel pagination;

  AttendanceRecordsResponse({
    required this.data,
    required this.pagination,
  });

  factory AttendanceRecordsResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordsResponse(
      data: (json['data'] as List)
          .map((e) => AttendanceRecordModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
      PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }
}
