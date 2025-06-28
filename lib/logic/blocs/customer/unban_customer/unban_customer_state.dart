part of 'unban_customer_bloc.dart';



@immutable
abstract class UnbanCustomerState {}

class UnbanCustomerInitial extends UnbanCustomerState {}

class UnbanCustomerLoading extends UnbanCustomerState {}

class UnbanCustomerSuccess extends UnbanCustomerState {
  final String message;
  UnbanCustomerSuccess(this.message);
}

class UnbanCustomerFailure extends UnbanCustomerState {
  final String error;
  UnbanCustomerFailure(this.error);
}

