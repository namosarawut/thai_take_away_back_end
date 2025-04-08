
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance/attendance_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/customer.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar/side_bar_bloc.dart';

import 'order_view/order_view_cubit.dart';

class BlocList {

  BlocList();

  List<BlocProvider> get blocs {
    return [
      BlocProvider<AttendanceBloc>(create: (_) => AttendanceBloc()),
      BlocProvider<SideBarBloc>(create: (_) => SideBarBloc()),
      BlocProvider<OrderViewCubit>(create: (_) => OrderViewCubit()),
      BlocProvider<CustomerBloc>(create: (_) => CustomerBloc()..add(LoadCustomers())),
    ];
  }
}
