// employee_period_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:intl/intl.dart';
import 'package:thai_take_away_back_end/logic/blocs/dialog_employees/dialog_cubit.dart';

class EmployeePeriodDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => BlocProvider(
        create: (_) => DialogCubit(),
        child: const _EmployeePeriodDialogContent(),
      ),
    );
  }
}

class _EmployeePeriodDialogContent extends StatelessWidget {
  const _EmployeePeriodDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DialogCubit>();
    final state = context.watch<DialogCubit>().state;
    final dateFormat = DateFormat('dd/MM/yyyy HH.mm');

    String periodText() {
      if (state.selectedPeriod == null) return 'เลือกช่วงเวลา';
      final s = state.selectedPeriod!;
      final df = DateFormat('dd/MM/yyyy HH.mm');
      return '${df.format(s.start)} - ${df.format(s.end)}';
    }


    return Dialog(
      backgroundColor: const Color(0xFF7162BA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
              // Dropdown button (mock)
              GestureDetector(
                onTap: () async {
                  // จำลองการเลือกจาก API
                  final choice = await showModalBottomSheet<String>(
                    context: context,
                    builder: (_) => ListView(
                      children: [
                        ListTile(
                          title: const Text('namo sarawut'),
                          onTap: () => Navigator.pop(context, 'namo sarawut'),
                        ),
                        ListTile(
                          title: const Text('alice'),
                          onTap: () => Navigator.pop(context, 'alice'),
                        ),
                      ],
                    ),
                  );
                  if (choice != null) cubit.selectEmployee(choice);
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
                          state.selectedEmployee ?? 'เลือกชื่อพนักงาน',
                          style: TextStyle(
                            color: state.selectedEmployee == null
                                ? Colors.grey
                                : const Color(0xFF7162BA),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Image.asset(
                        'assets/icons/dropdown_icon.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Title: period
              const Text(
                'period',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Date range picker button
              GestureDetector(
                onTap: () => _showDateTimeRangePicker(context, cubit),
                child: Container(
                  width: 302,
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    periodText(),
                    style: const TextStyle(
                      color: Color(0xFF7162BA),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // OK button
              Center(
                child: GestureDetector(
                  onTap: () {
                    // เก็บค่าจาก state ไปใช้งานต่อ
                    final selEmp = state.selectedEmployee;
                    final selPer = state.selectedPeriod;
                    // TODO: ส่งค่ากลับหรือบันทึกผ่าน Bloc
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

  void _showDateTimeRangePicker(BuildContext context, DialogCubit cubit) async {
    // ตัวแปรชั่วคราวเก็บช่วงวันที่ที่เลือก
    PickerDateRange? pickedRange;

    // 1) เลือกช่วงวันที่
    final dateResult = await showDialog<PickerDateRange>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 300,
            height: 350,
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: (args) {
                if (args.value is PickerDateRange) {
                  pickedRange = args.value as PickerDateRange;
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(pickedRange);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // ถ้า user กด cancel หรือ ไม่ได้เลือกอะไร
    if (dateResult == null) return;

    // 2) เลือกเวลาเริ่มต้น
    final startTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (startTime == null) return;

    // 3) เลือกเวลาสิ้นสุด
    final endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute),
    );
    if (endTime == null) return;

    // 4) รวมวันที่+เวลา และอัปเดต state ใน Cubit
    final startDateTime = DateTime(
      dateResult.startDate!.year,
      dateResult.startDate!.month,
      dateResult.startDate!.day,
      startTime.hour,
      startTime.minute,
    );
    final endDateTime = DateTime(
      (dateResult.endDate ?? dateResult.startDate)!.year,
      (dateResult.endDate ?? dateResult.startDate)!.month,
      (dateResult.endDate ?? dateResult.startDate)!.day,
      endTime.hour,
      endTime.minute,
    );

    cubit.selectPeriod(DateTimeRange(start: startDateTime, end: endDateTime));
  }


}
