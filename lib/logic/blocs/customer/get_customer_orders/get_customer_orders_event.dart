part of 'get_customer_orders_bloc.dart';

@immutable
abstract class GetCustomerOrdersEvent {}

/// Fetch orders for one customer in a date range
class FetchCustomerOrders extends GetCustomerOrdersEvent {
  final int customerId;
  final DateTime startDate;
  final DateTime endDate;

  FetchCustomerOrders({
    required this.customerId,
    required this.startDate,
    required this.endDate,
  });
}

