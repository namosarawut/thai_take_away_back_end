// lib/presentation/screens/admin/employees_screen/employees_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/employees/add_employee/add_employee_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/employees/delete_employee/delete_employee_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/employees/employees_screen_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/employees/employees_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance_records/attendance_records_bloc.dart';
import 'package:thai_take_away_back_end/presentation/widgets/add_employee_dialog.dart';
import 'package:thai_take_away_back_end/presentation/widgets/employee_period_dialog.dart';

class EmployeesListScreen extends StatefulWidget {
  const EmployeesListScreen({super.key});

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  static const int _limit = 10;

  @override
  void initState() {
    super.initState();
    final screenBloc = context.read<EmployeesScreenBloc>();
    _loadData(screenBloc.state.isViewEmployeeList, 0);
  }

  void _loadData(bool viewList, int page) {
    if (viewList) {
      context.read<EmployeesBloc>().add(FetchEmployees(
        type: 'all',
        page: page,
        limit: _limit,
      ));
    } else {
      if (page == 0) {
        final start = DateTime.now();
        context.read<AttendanceRecordsBloc>().add(
          FetchAttendanceRecords(
            page: 1,
            limit: _limit,
            startDate: start,
            endDate: start,
          ),
        );
      } else {
        final start = DateTime.now();
        final end = DateTime.now();
        context.read<AttendanceRecordsBloc>().add(
          FetchAttendanceRecords(
            page: page,
            limit: _limit,
            startDate: start,
            endDate: end,
            employeeID: 'namoFag',
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddEmployeeBloc, AddEmployeeState>(
          listener: (context, state) {
            if (state is AddEmployeeLoading) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("ss"),
                  backgroundColor: Colors.green,
                ),
              );
              _loadData(true, 1);
            } else if (state is AddEmployeeFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
        BlocListener<DeleteEmployeeBloc, DeleteEmployeeState>(
          listener: (context, state) {
            if (state is DeleteEmployeeSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              _loadData(true, 1);
            } else if (state is DeleteEmployeeFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<EmployeesScreenBloc, EmployeesScreenState>(
        builder: (context, state) {
          final viewList = state.isViewEmployeeList;
          return Scaffold(
            backgroundColor: const Color(0xFFF1F4F9),
            body: Row(
              children: [
                const SizedBox(width: 120),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 120 - 24,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      // Header
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Employees',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo[800],
                              ),
                            ),
                            _buildPagination(viewList, state),
                          ],
                        ),
                      ),
                      // Toggle + Add/Filter
                      Row(
                        children: [
                          _buildToggle(viewList),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              if (viewList) {
                                AddEmployeeDialog.show(context);
                              } else {
                                EmployeePeriodDialog.show(context);
                              }
                            },
                            child: Container(
                              width: 263,
                              height: 56,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF76B46),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  viewList ? 'Add' : 'Filter Summary',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Content
                      Expanded(
                        child: viewList
                            ? _buildEmployeeList()
                            : _buildAttendanceList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildToggle(bool viewList) {
    return Container(
      width: 310,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E1EA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: viewList ? 4 : 160.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: 145,
                height: 37,
                decoration: BoxDecoration(
                  color: const Color(0xFF534598),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<EmployeesScreenBloc>()
                        .add(ToggleEmployeesViewType(true));
                    _loadData(true, 1);
                  },
                  child: Center(
                    child: Text(
                      'Employee Lists',
                      style: TextStyle(
                        color: viewList ? Colors.white : const Color(
                            0xFF534598),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<EmployeesScreenBloc>()
                        .add(ToggleEmployeesViewType(false));
                    _loadData(false, 0);
                  },
                  child: Center(
                    child: Text(
                      'Work Attendance',
                      style: TextStyle(
                        color:
                        !viewList ? Colors.white : const Color(0xFF534598),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(bool viewList, EmployeesScreenState state) {
    if (viewList) {
      return BlocBuilder<EmployeesBloc, EmployeesState>(
        builder: (context, state) {
          if (state is EmployeesLoaded) {
            final totalPages = state.pagination.totalPages;
            final currentPage = state.pagination.page;
            if (totalPages <= 1) return const SizedBox.shrink();
            final buttonCount = totalPages > 6 ? 6 : totalPages;
            return Row(
              children: List.generate(buttonCount, (idx) {
                final page = idx + 1;
                final isActive = page == currentPage;
                return GestureDetector(
                  onTap: () {
                    if (!isActive) _loadData(true, page);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF6A5BB0)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$page',
                        style: TextStyle(
                          color: isActive
                              ? Colors.white
                              : const Color(0xFF6A5BB0),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }
          return const SizedBox.shrink();
        },
      );
    } else {
      return BlocBuilder<AttendanceRecordsBloc, AttendanceRecordsState>(
        builder: (context, state) {
          if (state is AttendanceRecordsLoaded) {
            final totalPages = state.pagination.totalPages;
            final currentPage = state.pagination.page;
            if (totalPages <= 1) return const SizedBox.shrink();
            final buttonCount = totalPages > 6 ? 6 : totalPages;
            return Row(
              children: List.generate(buttonCount, (idx) {
                final page = idx + 1;
                final isActive = page == currentPage;
                return GestureDetector(
                  onTap: () {
                    if (!isActive) _loadData(false, page);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF6A5BB0)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$page',
                        style: TextStyle(
                          color: isActive
                              ? Colors.white
                              : const Color(0xFF6A5BB0),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }
          return const SizedBox.shrink();
        },
      );
    }
  }

  Widget _buildEmployeeList() {
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      builder: (context, state) {
        if (state is EmployeesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EmployeesLoaded) {
          return ListView.builder(
            itemCount: state.employees.length,
            itemBuilder: (_, i) {
              final emp = state.employees[i];
              return ListTile(
                leading: const Icon(Icons.person, color: Color(0xFFFD80A3)),
                title: Text("${emp.name} - ${emp.position}"),
                subtitle: Text(emp.employeeID),
                trailing: GestureDetector(
                  onTap: () {
                    context
                        .read<DeleteEmployeeBloc>()
                        .add(DeleteEmployeeRequested(emp.employeeID));
                  },
                  child: Container(
                    width: 80,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is EmployeesError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAttendanceList() {
    return BlocBuilder<AttendanceRecordsBloc, AttendanceRecordsState>(
      builder: (context, state) {
        if (state is AttendanceRecordsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AttendanceRecordsLoaded) {
          final total = state.records.fold<double>(
              0, (sum, r) => sum + r.workHours);
          return Stack(
            children: [
              ListView.builder(
                itemCount: state.records.length,
                itemBuilder: (_, i) {
                  final rec = state.records[i];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(rec.name),
                    subtitle: Text(
                      rec.checkOut != null
                          ? 'In: ${rec.checkIn} – Out: ${rec.checkOut}'
                          : 'In: ${rec.checkIn} – Haven\'t checked out yet',
                    ),
                    trailing: Container(
                      width: 80,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text('${rec.workHours}h',
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7162BA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Total ${total.toStringAsFixed(2)}h',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        } else if (state is AttendanceRecordsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
