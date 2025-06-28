// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/bloc.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/customer_screens/customer_list_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/customer_screens/customer_detail_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/main_manager_admin_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/customer_screens/order_detail_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/staff/main_manager_staff_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/login_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/options_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/staff/menu_screen/menu_form_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/work_attendance_screen.dart';
import 'package:thai_take_away_back_end/repositores/attendance_records_repository.dart';
import 'package:thai_take_away_back_end/repositores/attendance_repository.dart';
import 'package:thai_take_away_back_end/repositores/auth_repository.dart';
import 'package:thai_take_away_back_end/repositores/customers_repository.dart';
import 'package:thai_take_away_back_end/repositores/employees_repository.dart';
import 'package:thai_take_away_back_end/repositores/store_settings_repository.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';
import 'package:thai_take_away_back_end/data/local_storage_helper.dart';
import 'package:thai_take_away_back_end/data/model/user_model.dart';
import 'core/config/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvironmentConfig().initialize(Environment.dev);
  final apiService = ApiService();
  final attendanceRepository = AttendanceRepository(apiService);
  final authRepository = AuthRepository(apiService);
  final storeSettingsRepository = StoreSettingsRepository(apiService);
  final employeesRepository = EmployeesRepository(apiService);
  final attendanceRecordsRepository = AttendanceRecordsRepository(apiService);
  final customersRepository = CustomersRepository(apiService);

  runApp(
    MyApp(
      attendanceRepository: attendanceRepository,
      authRepository: authRepository,
        storeSettingsRepository:storeSettingsRepository,
        employeesRepository:employeesRepository,
        attendanceRecordsRepository: attendanceRecordsRepository,
      customersRepository: customersRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AttendanceRepository attendanceRepository;
  final AuthRepository authRepository;
  final StoreSettingsRepository storeSettingsRepository;
  final EmployeesRepository employeesRepository;
  final AttendanceRecordsRepository attendanceRecordsRepository;
  final CustomersRepository customersRepository;

  const MyApp({
    super.key,
    required this.attendanceRepository,
    required this.authRepository,
    required this.storeSettingsRepository,
    required this.employeesRepository,
    required this.attendanceRecordsRepository, required this.customersRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocList(attendanceRepository, authRepository,storeSettingsRepository,employeesRepository,attendanceRecordsRepository,customersRepository).blocs,
      child: MaterialApp(
        title: 'Secure Flutter App',
        theme: ThemeData(primarySwatch: Colors.blue),

        // ใช้ home ตรวจสอบ session ก่อนนำทาง
        home: FutureBuilder<UserModel?>(
          future: LocalStorageHelper.getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            final user = snapshot.data;
            if (user == null) {
              return  TwoButtonsScreen();
            } else if (user.position == 'admin') {
              return const MainManagerAdminScreen();
            } else {
              return const MainManagerStaffScreen();
            }
          },
        ),

        // เอา entry ของ "/" ออก
        routes: {
          'loginScreen': (_) =>  LoginScreen(),
          'workAttendance': (_) =>  AttendancePage(),
          'customerPage': (_) => const CustomerPage(),
          'customerDetailScreen': (_) => const CustomerDetailScreen(),
          'mainManagerAdminScreen': (_) => const MainManagerAdminScreen(),
          'mainManagerStaffScreen': (_) => const MainManagerStaffScreen(),
          'addItemScreen': (_) => const AddItemScreen(),
        },
      ),
    );
  }
}
