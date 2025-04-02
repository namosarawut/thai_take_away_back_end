
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance/attendance_bloc.dart';

class BlocList {

  BlocList();

  List<BlocProvider> get blocs {
    return [
      BlocProvider<AttendanceBloc>(create: (_) => AttendanceBloc()),
    ];
  }
}
