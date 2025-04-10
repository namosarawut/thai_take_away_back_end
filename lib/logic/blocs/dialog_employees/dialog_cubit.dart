// dialog_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogState {
  final String? selectedEmployee;
  final DateTimeRange? selectedPeriod;

  DialogState({this.selectedEmployee, this.selectedPeriod});

  DialogState copyWith({
    String? selectedEmployee,
    DateTimeRange? selectedPeriod,
  }) {
    return DialogState(
      selectedEmployee: selectedEmployee ?? this.selectedEmployee,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }
}

class DialogCubit extends Cubit<DialogState> {
  DialogCubit() : super(DialogState());

  void selectEmployee(String name) {
    emit(state.copyWith(selectedEmployee: name));
  }

  void selectPeriod(DateTimeRange range) {
    emit(state.copyWith(selectedPeriod: range));
  }
}
