// position_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/add_employee_dialog/position_dialog_cubit.dart';


class PositionDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => BlocProvider(
        create: (_) => PositionDialogCubit(),
        child: const _PositionDialogContent(),
      ),
    );
  }
}

class _PositionDialogContent extends StatelessWidget {
  const _PositionDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PositionDialogCubit>();
    final state = context.watch<PositionDialogCubit>().state;

    return Dialog(
      backgroundColor: const Color(0xFF7162BA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: 325,
        height: 363,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title: employee name
              const Text(
                'employee name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // TextField สำหรับกรอกชื่อ
              Container(
                width: 302,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  style: const TextStyle(color: Color(0xFF7162BA)),
                  decoration: const InputDecoration(
                    hintText: 'กรอกชื่อพนักงาน',
                    border: InputBorder.none,
                  ),
                  onChanged: cubit.nameChanged,
                ),
              ),
              const SizedBox(height: 16),
              // Title: position
              const Text(
                'position',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Dropdown for position
              GestureDetector(
                onTap: () async {
                  final choice = await showModalBottomSheet<String>(
                    context: context,
                    builder: (_) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Admin'),
                          onTap: () => Navigator.pop(context, 'Admin'),
                        ),
                        ListTile(
                          title: const Text('Staff'),
                          onTap: () => Navigator.pop(context, 'Staff'),
                        ),
                      ],
                    ),
                  );
                  if (choice != null) cubit.positionChanged(choice);
                },
                child: Container(
                  width: 302,
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.position ?? 'เลือกตำแหน่ง',
                          style: TextStyle(
                            color: state.position == null
                                ? Colors.grey
                                : const Color(0xFF7162BA),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/icons/dropdown_icon.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // OK button
              Center(
                child: GestureDetector(
                  onTap: () {
                    // ดึงค่าจาก Cubit.state ไปใช้งานต่อ
                    final name = state.employeeName;
                    final pos = state.position;
                    // TODO: บันทึกค่าหรือส่ง event ไปยัง Bloc อื่น
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 302,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFD80A3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
