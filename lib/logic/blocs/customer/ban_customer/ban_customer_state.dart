part of 'ban_customer_bloc.dart';

// lib/logic/blocs/customer/ban_customer_state.dart
@immutable
abstract class BanCustomerState {}

class BanCustomerInitial extends BanCustomerState {}

class BanCustomerLoading extends BanCustomerState {}

class BanCustomerSuccess extends BanCustomerState {
  final String message;
  BanCustomerSuccess(this.message);
}

class BanCustomerFailure extends BanCustomerState {
  final String error;
  BanCustomerFailure(this.error);
}

