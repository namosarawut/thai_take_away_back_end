part of 'ban_customer_bloc.dart';


@immutable
abstract class BanCustomerEvent {}

class BanCustomerRequested extends BanCustomerEvent {
  final int customerId;
  BanCustomerRequested(this.customerId);
}

