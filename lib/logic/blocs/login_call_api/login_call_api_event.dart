part of 'login_call_api_bloc.dart';


@immutable
abstract class LoginCallApiEvent {}

/// ผู้ใช้กรอก employeeID แล้วกด Login
class LoginRequested extends LoginCallApiEvent {
  final String employeeID;
  LoginRequested(this.employeeID);
}
