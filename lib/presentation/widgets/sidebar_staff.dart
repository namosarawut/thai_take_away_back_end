import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar_admin/side_bar_admin_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar_staff/side_bar_staff_bloc.dart';

/// 5. ปรับปรุง Widget SideBarAdmin โดยใช้ BlocBuilder
class SideBarStaff extends StatelessWidget {
  const SideBarStaff({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideBarStaffBloc, SideBarStaffState>(
      builder: (context, state) {
        return Container(
          width: 80,
          height: MediaQuery.of(context).size.height - 48,
          decoration: BoxDecoration(
            color: const Color(0xFF6A5BB0),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // ไอคอน Location
              GestureDetector(
                onTap: () {
                  // เมื่อกด Location ให้ส่ง Event เพื่อเปลี่ยน state
                  context.read<SideBarStaffBloc>().add(
                    SelectSideBarStaffItem(
                        selectedItem: SideBarStaffSelectedItem.notification),
                  );
                },
                child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Image.asset(
                    state.selectedItem == SideBarStaffSelectedItem.notification
                        ? 'assets/icons/natifacation_icon_enable.png'
                        : 'assets/icons/natifacation_icon_disable.png',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ไอคอน Customer
              GestureDetector(
                onTap: () {
                  context.read<SideBarStaffBloc>().add(
                    SelectSideBarStaffItem(
                        selectedItem: SideBarStaffSelectedItem.order),
                  );
                },
                child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Image.asset(
                    state.selectedItem == SideBarStaffSelectedItem.order
                        ? 'assets/icons/order_icon_enable.png'
                        : 'assets/icons/order_icon_disable.png',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ไอคอน Staff
              GestureDetector(
                onTap: () {
                  context.read<SideBarStaffBloc>().add(
                    SelectSideBarStaffItem(
                        selectedItem: SideBarStaffSelectedItem.menu),
                  );
                },
                child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Image.asset(
                    state.selectedItem == SideBarStaffSelectedItem.menu
                        ? 'assets/icons/menu_icon_enable.png'
                        : 'assets/icons/menu_icon_disable.png',
                  ),
                ),
              ),
              const Spacer(),
              // ไอคอน Logout (คงที่ ไม่ต้องใช้ bloc)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 20),
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}