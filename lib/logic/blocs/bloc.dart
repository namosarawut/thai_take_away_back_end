
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/add_employee_dialog/position_dialog_cubit.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance/attendance_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance_call_api/attendance_call_api_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/customer.dart';
import 'package:thai_take_away_back_end/logic/blocs/dialog_employees/dialog_cubit.dart';
import 'package:thai_take_away_back_end/logic/blocs/maps/map_cubit.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar_admin/side_bar_admin_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar_staff/side_bar_staff_bloc.dart';
import 'package:thai_take_away_back_end/repositores/attendance_repository.dart';


import 'order_view/order_view_cubit.dart';

class BlocList {
final AttendanceRepository attendanceRepository;
  BlocList(this.attendanceRepository);

  List<BlocProvider> get blocs {
    return [
      BlocProvider<AttendanceBloc>(create: (_) => AttendanceBloc()),
      BlocProvider<SideBarAdminBloc>(create: (_) => SideBarAdminBloc()),
      BlocProvider<SideBarStaffBloc>(create: (_) => SideBarStaffBloc()),
      BlocProvider<OrderViewCubit>(create: (_) => OrderViewCubit()),
      BlocProvider<DialogCubit>(create: (_) => DialogCubit()),
      BlocProvider<MapCubit>(create: (_) => MapCubit()),
      BlocProvider<PositionDialogCubit>(create: (_) => PositionDialogCubit()),
      BlocProvider<CustomerBloc>(create: (_) => CustomerBloc()..add(LoadCustomers())),
      BlocProvider<AttendanceCallApiBloc>(create: (_) => AttendanceCallApiBloc(attendanceRepository)),
    ];
  }
}
