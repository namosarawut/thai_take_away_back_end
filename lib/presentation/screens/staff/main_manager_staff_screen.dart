import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar_staff/side_bar_staff_bloc.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/customer_screens/customer_list_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/employees_screen/employees_list_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/location_management/location_management_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/staff/menu_screen/menu_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/staff/notification_screen/notification_screen.dart';
import 'package:thai_take_away_back_end/presentation/widgets/sidebar_staff.dart';

import 'order_screen/order_screen.dart';

class MainManagerStaffScreen extends StatefulWidget {
  const MainManagerStaffScreen({super.key});

  @override
  State<MainManagerStaffScreen> createState() => _MainManagerAdminScreenState();
}

class _MainManagerAdminScreenState extends State<MainManagerStaffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<SideBarStaffBloc, SideBarStaffState>(
            builder: (context, sideBarStaffState) {
              if(sideBarStaffState.selectedItem == SideBarStaffSelectedItem.notification){
                return NotificationScreen();
              }else if(sideBarStaffState.selectedItem == SideBarStaffSelectedItem.order){
                return OrderScreen();
              } else if(sideBarStaffState.selectedItem == SideBarStaffSelectedItem.menu){
                return MenuScreen();
              } else {
                return SizedBox();
              }

            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
            child: const SideBarStaff(),
          ),
        ],
      ),
    );
  }
}
