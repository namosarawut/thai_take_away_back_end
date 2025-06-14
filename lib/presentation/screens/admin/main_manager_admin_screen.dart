import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/logout/logout_cubit.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar_admin/side_bar_admin_bloc.dart';

import 'package:thai_take_away_back_end/presentation/screens/admin/customer_screens/customer_list_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/employees_screen/employees_list_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/location_management/location_management_screen.dart';
import 'package:thai_take_away_back_end/presentation/widgets/sidebar_admin.dart';

class MainManagerAdminScreen extends StatefulWidget {
  const MainManagerAdminScreen({super.key});

  @override
  State<MainManagerAdminScreen> createState() => _MainManagerAdminScreenState();
}

class _MainManagerAdminScreenState extends State<MainManagerAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, logoutState) {
          if (logoutState is LogoutLoading) {
            // แสดง loading overlay
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else {
            // ปิด loading dialog
            if (Navigator.canPop(context)) Navigator.pop(context);

            if (logoutState is LogoutSuccess) {
              // ไปหน้า Login และล้าง stack
              Navigator.of(context).pushNamedAndRemoveUntil(
                'loginScreen',
                (route) => false,
              );
            } else if (logoutState is LogoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logout failed: ${logoutState.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        builder: (context, logoutState) {
          return Stack(
            children: [
              BlocBuilder<SideBarAdminBloc, SideBarAdminState>(
                builder: (context, sideBarAdminState) {
                  if (sideBarAdminState.selectedItem ==
                      SideBarAdminSelectedItem.customer) {
                    return CustomerPage();
                  } else if (sideBarAdminState.selectedItem ==
                      SideBarAdminSelectedItem.staff) {
                    return EmployeesListScreen();
                  } else if (sideBarAdminState.selectedItem ==
                      SideBarAdminSelectedItem.location) {
                    return MapScreen();
                  } else {
                    return SizedBox();
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
                child: const SideBarAdmin(),
              ),
              Visibility(
                visible: logoutState is LogoutLoading,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black26,
                  child: Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
