// lib/presentation/widgets/add_employee_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/employees/add_employee/add_employee_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/employees/employees_bloc.dart';
import 'package:thai_take_away_back_end/repositores/employees_repository.dart';
import 'package:thai_take_away_back_end/service/api_service.dart';

class AddEmployeeDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider(
        create: (_) => AddEmployeeBloc(
          EmployeesRepository(ApiService()),
        ),
        child: const _AddEmployeeDialogContent(),
      ),
    );
  }
}

class _AddEmployeeDialogContent extends StatefulWidget {
  const _AddEmployeeDialogContent({Key? key}) : super(key: key);

  @override
  State<_AddEmployeeDialogContent> createState() => _AddEmployeeDialogContentState();
}

class _AddEmployeeDialogContentState extends State<_AddEmployeeDialogContent> {
  final _nameController = TextEditingController();
  String? _selectedPosition;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF7162BA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text(
              'Add Employee',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedPosition,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Position',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: ['admin', 'staff']
                  .map((p) => DropdownMenuItem(value: p, child: Text(p.capitalize())))
                  .toList(),
              onChanged: (v) => setState(() => _selectedPosition = v),
            ),
            const SizedBox(height: 16),

            BlocConsumer<AddEmployeeBloc, AddEmployeeState>(
              listener: (context, state) {
                if (state is AddEmployeeSuccess) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Add Employee: ${_nameController.text} Successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<EmployeesBloc>().add(FetchEmployees(
                    type: 'all',
                    page: 1,
                    limit: 10,
                  ));
                } else if (state is AddEmployeeFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.error}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is AddEmployeeLoading;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: isLoading || _nameController.text.trim().isEmpty || _selectedPosition == null
                          ? null
                          : () {
                        context.read<AddEmployeeBloc>().add(
                          AddEmployeeRequested(
                            name: _nameController.text.trim(),
                            position: _selectedPosition!,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLoading ? Colors.grey : const Color(0xFFFD80A3),
                      ),
                      child: isLoading
                          ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                          : const Text('Submit'),
                    ),
                  ],
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}

extension _StringExt on String {
  String capitalize() => isEmpty ? this : (this[0].toUpperCase() + substring(1));
}
