import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/side_bar/side_bar_bloc.dart';

/// 5. ปรับปรุง Widget Sidebar โดยใช้ BlocBuilder
class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideBarBloc, SideBarState>(
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
                  context.read<SideBarBloc>().add(
                    SelectSideBarItem(
                        selectedItem: SideBarSelectedItem.location),
                  );
                },
                child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Image.asset(
                    state.selectedItem == SideBarSelectedItem.location
                        ? 'assets/icons/location_active.png'
                        : 'assets/icons/location_unactive.png',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ไอคอน Customer
              GestureDetector(
                onTap: () {
                  context.read<SideBarBloc>().add(
                    SelectSideBarItem(
                        selectedItem: SideBarSelectedItem.customer),
                  );
                },
                child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Image.asset(
                    state.selectedItem == SideBarSelectedItem.customer
                        ? 'assets/icons/customer_active.png'
                        : 'assets/icons/customer_unactive.png',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ไอคอน Staff
              GestureDetector(
                onTap: () {
                  context.read<SideBarBloc>().add(
                    SelectSideBarItem(
                        selectedItem: SideBarSelectedItem.staff),
                  );
                },
                child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Image.asset(
                    state.selectedItem == SideBarSelectedItem.staff
                        ? 'assets/icons/staff_active.png'
                        : 'assets/icons/staff_unactive.png',
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