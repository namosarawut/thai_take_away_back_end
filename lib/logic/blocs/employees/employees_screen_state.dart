part of 'employees_screen_bloc.dart';

class EmployeesScreenState extends Equatable {
  final bool isViewEmployeeList;
  final String? employeeId;
  final bool showDialog;
  final String currentTime;

  const EmployeesScreenState({
    required this.isViewEmployeeList,
    this.employeeId,
    this.showDialog = false,
    required this.currentTime,
  });

  EmployeesScreenState copyWith({
    bool? isCheckIn,
    String? employeeId,
    bool? showDialog,
    String? currentTime,
  }) {
    return EmployeesScreenState(
      isViewEmployeeList: isCheckIn ?? this.isViewEmployeeList,
      employeeId: employeeId ?? this.employeeId,
      showDialog: showDialog ?? this.showDialog,
      currentTime: currentTime ?? this.currentTime,
    );
  }

  @override
  List<Object?> get props => [isViewEmployeeList, employeeId, showDialog, currentTime];
}