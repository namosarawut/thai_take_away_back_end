import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/repositores/auth_repository.dart';


class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepository repository;
  LogoutCubit(this.repository) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await repository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}


@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

/// ล้างข้อมูลสำเร็จ
class LogoutSuccess extends LogoutState {}

/// เกิดข้อผิดพลาดขณะ logout
class LogoutFailure extends LogoutState {
  final String error;
  LogoutFailure(this.error);
}