// lib/presentation/widgets/employee_period_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import 'package:thai_take_away_back_end/logic/blocs/employees/employees_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance_records/attendance_records_bloc.dart';
import 'package:thai_take_away_back_end/data/model/employee_model.dart';

class EmployeePeriodDialog {
  static Future<void> show(BuildContext context) {
    // เรียก fetch พนักงานก่อนเปิด dialog
    context.read<EmployeesBloc>().add(FetchEmployees(type: 'all', page: 1, limit: 100));
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _EmployeePeriodDialogContent(),
    );
  }
}

class _EmployeePeriodDialogContent extends StatefulWidget {
  const _EmployeePeriodDialogContent({Key? key}) : super(key: key);

  @override
  State<_EmployeePeriodDialogContent> createState() => _EmployeePeriodDialogContentState();
}

class _EmployeePeriodDialogContentState extends State<_EmployeePeriodDialogContent> {
  String? _selectedEmployeeId;
  String? _selectedEmployeeName;
  DateTimeRange? _selectedPeriod;
  bool _submitting = false;

  final DateFormat _displayFmt = DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttendanceRecordsBloc, AttendanceRecordsState>(
      listener: (ctx, attState) {
        if (attState is AttendanceRecordsLoading) {
          setState(() => _submitting = true);
        } else {
          // loaded or error → ปิด dialog
          Navigator.of(context).pop();
        }
      },
      child: Dialog(
        backgroundColor: const Color(0xFF7162BA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: 325,
          height: 340,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter Attendance',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Employee dropdown
                const Text('Employee', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                BlocBuilder<EmployeesBloc, EmployeesState>(
                  builder: (context, empState) {
                    if (empState is EmployeesLoading) {
                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                    } else if (empState is EmployeesLoaded) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedEmployeeId,
                          hint: const Text('Select employee'),
                          underline: const SizedBox(),
                          items: empState.employees.map((e) {
                            return DropdownMenuItem(
                              value: e.employeeID,
                              child: Text(e.name),
                            );
                          }).toList(),
                          onChanged: (id) {
                            final emp = empState.employees.firstWhere((e) => e.employeeID == id);
                            setState(() {
                              _selectedEmployeeId = id;
                              _selectedEmployeeName = emp.name;
                            });
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 16),
                // Period picker
                const Text('Period', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _pickDateRange(context),
                  child: Container(
                    height:  56,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      _selectedPeriod == null
                          ? 'Select period'
                          : '${_displayFmt.format(_selectedPeriod!.start)} – ${_displayFmt.format(_selectedPeriod!.end)}',
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
                const Spacer(),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _submitting ? null : () => Navigator.of(context).pop(),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: (!_canSubmit() || _submitting)
                          ? null
                          : () {
                        // ส่ง event ไปยัง AttendanceRecordsBloc
                        context.read<AttendanceRecordsBloc>().add(
                          FetchAttendanceRecords(
                            page: 1,
                            limit: 10,
                            startDate: _selectedPeriod!.start,
                            endDate: _selectedPeriod!.end,
                            employeeID: _selectedEmployeeId!,
                            startDateForFilter: _selectedPeriod!.start,
                            endDateForFilter:  _selectedPeriod!.end,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                      child: _submitting
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _canSubmit() {
    return _selectedEmployeeId != null && _selectedPeriod != null;
  }

  Future<void> _pickDateRange(BuildContext context) async {
    PickerDateRange? pickedRange;

    final result = await showDialog<PickerDateRange>(
      context: context,
      builder: (ctx) => AlertDialog(
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
          TextButton(onPressed: () => Navigator.of(ctx).pop(pickedRange), child: const Text('OK')),
        ],
      ),
    );
    if (result == null) return;

    final startTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 9, minute: 0));
    if (startTime == null) return;

    final endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute),
    );
    if (endTime == null) return;

    setState(() {
      _selectedPeriod = DateTimeRange(
        start: DateTime(result.startDate!.year, result.startDate!.month, result.startDate!.day, startTime.hour, startTime.minute),
        end: DateTime((result.endDate ?? result.startDate)!.year, (result.endDate ?? result.startDate)!.month, (result.endDate ?? result.startDate)!.day, endTime.hour, endTime.minute),
      );
    });
  }
}
