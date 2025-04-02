part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  final bool isCheckIn;
  final String? employeeId;
  final bool showDialog;
  final String currentTime;

  const AttendanceState({
    required this.isCheckIn,
    this.employeeId,
    this.showDialog = false,
    required this.currentTime,
  });

  AttendanceState copyWith({
    bool? isCheckIn,
    String? employeeId,
    bool? showDialog,
    String? currentTime,
  }) {
    return AttendanceState(
      isCheckIn: isCheckIn ?? this.isCheckIn,
      employeeId: employeeId ?? this.employeeId,
      showDialog: showDialog ?? this.showDialog,
      currentTime: currentTime ?? this.currentTime,
    );
  }

  @override
  List<Object?> get props => [isCheckIn, employeeId, showDialog, currentTime];
}