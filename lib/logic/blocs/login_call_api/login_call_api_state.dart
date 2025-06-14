part of 'login_call_api_bloc.dart';


@immutable
abstract class LoginCallApiState {}

class LoginCallApiInitial extends LoginCallApiState {}

class LoginCallApiLoading extends LoginCallApiState {}

/// Login สำเร็จ พร้อมข้อมูล user และ role
class LoginCallApiSuccess extends LoginCallApiState {
  final UserModel user;
  final String role;

  LoginCallApiSuccess({
    required this.user,
    required this.role,
  });
}

class LoginCallApiFailure extends LoginCallApiState {
  final String error;
  LoginCallApiFailure(this.error);
}

