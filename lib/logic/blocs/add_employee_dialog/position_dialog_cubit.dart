// position_dialog_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionDialogState {
  final String employeeName;
  final String? position; // "Admin" หรือ "Staff"

  PositionDialogState({
    this.employeeName = '',
    this.position,
  });

  PositionDialogState copyWith({
    String? employeeName,
    String? position,
  }) {
    return PositionDialogState(
      employeeName: employeeName ?? this.employeeName,
      position: position ?? this.position,
    );
  }
}

class PositionDialogCubit extends Cubit<PositionDialogState> {
  PositionDialogCubit() : super(PositionDialogState());

  void nameChanged(String name) {
    emit(state.copyWith(employeeName: name));
  }

  void positionChanged(String pos) {
    emit(state.copyWith(position: pos));
  }
}
