
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/add_employee_dialog/position_dialog_cubit.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance/attendance_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance_call_api/attendance_call_api_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance_records/attendance_records_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/ban_customer/ban_customer_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/customer.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/get_customer_list/get_customer_list_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/get_customer_orders/get_customer_orders_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/unban_customer/unban_customer_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/dialog_employees/dialog_cubit.dart';
import 'package:thai_take_away_back_end/logic/blocs/employees/add_employee/add_employee_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/employees/delete_employee/delete_employee_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/login_call_api/login_call_api_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/logout/logout_cubit.dart';
import 'package:thai_take_away_back_end/logic/blocs/maps/map_cubit.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar_admin/side_bar_admin_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar_staff/side_bar_staff_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/store_settings/store_settings_bloc.dart';
import 'package:thai_take_away_back_end/repositores/attendance_records_repository.dart';
import 'package:thai_take_away_back_end/repositores/attendance_repository.dart';
import 'package:thai_take_away_back_end/repositores/auth_repository.dart';
import 'package:thai_take_away_back_end/repositores/customers_repository.dart';
import 'package:thai_take_away_back_end/repositores/employees_repository.dart';
import 'package:thai_take_away_back_end/repositores/store_settings_repository.dart';


import 'employees/employees_bloc.dart';
import 'employees/employees_screen_bloc.dart';
import 'order_view/order_view_cubit.dart';

class BlocList {
final AttendanceRepository attendanceRepository;
final AuthRepository authRepository;
final StoreSettingsRepository storeSettingsRepository;
final EmployeesRepository employeesRepository;
final AttendanceRecordsRepository attendanceRecordsRepository;
final CustomersRepository customersRepository;
  BlocList(this.attendanceRepository,this.authRepository,this.storeSettingsRepository,this.employeesRepository,this.attendanceRecordsRepository,this.customersRepository);

  List<BlocProvider> get blocs {
    return [
      BlocProvider<AttendanceBloc>(create: (_) => AttendanceBloc()),
      BlocProvider<EmployeesScreenBloc>(create: (_) => EmployeesScreenBloc()),
      BlocProvider<SideBarAdminBloc>(create: (_) => SideBarAdminBloc()),
      BlocProvider<SideBarStaffBloc>(create: (_) => SideBarStaffBloc()),
      BlocProvider<OrderViewCubit>(create: (_) => OrderViewCubit()),
      BlocProvider<DialogCubit>(create: (_) => DialogCubit()),
      BlocProvider<MapCubit>(create: (_) => MapCubit()),
      BlocProvider<PositionDialogCubit>(create: (_) => PositionDialogCubit()),
      BlocProvider<LogoutCubit>(create: (_) => LogoutCubit(authRepository)),
      BlocProvider<CustomerBloc>(create: (_) => CustomerBloc()..add(LoadCustomers())),
      BlocProvider<AttendanceCallApiBloc>(create: (_) => AttendanceCallApiBloc(attendanceRepository)),
      BlocProvider<LoginCallApiBloc>(create: (_) => LoginCallApiBloc(authRepository)),
      BlocProvider<StoreSettingsBloc>(create: (_) => StoreSettingsBloc(storeSettingsRepository)),
      BlocProvider<EmployeesBloc>(create: (_) => EmployeesBloc(employeesRepository)),
      BlocProvider<DeleteEmployeeBloc>(create: (_) => DeleteEmployeeBloc(employeesRepository)),
      BlocProvider<AddEmployeeBloc>(create: (_) => AddEmployeeBloc(employeesRepository)),
      BlocProvider<AttendanceRecordsBloc>(create: (_) => AttendanceRecordsBloc(attendanceRecordsRepository)),
      BlocProvider<GetCustomerListBloc>(create: (_) => GetCustomerListBloc(customersRepository)),
      BlocProvider<BanCustomerBloc>(create: (_) => BanCustomerBloc(customersRepository)),
      BlocProvider<UnbanCustomerBloc>(create: (_) => UnbanCustomerBloc(customersRepository)),
      BlocProvider<GetCustomerOrdersBloc>(create: (_) => GetCustomerOrdersBloc(customersRepository)),
    ];
  }
}
