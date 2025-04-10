import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar/side_bar_bloc.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/customer_screens/customer_list_screen.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/employees_screen/employees_list_screen.dart';
import 'package:thai_take_away_back_end/presentation/widgets/sidebar.dart';

class MainManagerAdminScreen extends StatefulWidget {
  const MainManagerAdminScreen({super.key});

  @override
  State<MainManagerAdminScreen> createState() => _MainManagerAdminScreenState();
}

class _MainManagerAdminScreenState extends State<MainManagerAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<SideBarBloc, SideBarState>(
            builder: (context, sideBarState) {
              if(sideBarState.selectedItem == SideBarSelectedItem.customer){
                return CustomerPage();
              }else if(sideBarState.selectedItem == SideBarSelectedItem.staff){
                return EmployeesListScreen();
              } else {
                return SizedBox();
              }

            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
            child: const SideBar(),
          ),
        ],
      ),
    );
  }
}
