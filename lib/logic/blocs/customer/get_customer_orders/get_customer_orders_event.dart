part of 'get_customer_orders_bloc.dart';

@immutable
abstract class GetCustomerOrdersEvent {}

/// Fetch orders for one customer in a date range
class FetchCustomerOrders extends GetCustomerOrdersEvent {
  final int customerId;
  FetchCustomerOrders({
    required this.customerId,
  });
}

