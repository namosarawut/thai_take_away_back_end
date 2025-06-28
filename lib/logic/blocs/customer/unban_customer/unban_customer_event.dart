part of 'unban_customer_bloc.dart';

@immutable
abstract class UnbanCustomerEvent {}

/// Triggered when user clicks "Unban"
class UnbanCustomerRequested extends UnbanCustomerEvent {
  final int customerId;
  UnbanCustomerRequested(this.customerId);
}
