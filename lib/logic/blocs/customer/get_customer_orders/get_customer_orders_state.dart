part of 'get_customer_orders_bloc.dart';


@immutable
abstract class GetCustomerOrdersState {}

class GetCustomerOrdersInitial extends GetCustomerOrdersState {}

class GetCustomerOrdersLoading extends GetCustomerOrdersState {}

class GetCustomerOrdersLoaded extends GetCustomerOrdersState {
  final List<OrderModel> orders;
  final double totalPrice;

  GetCustomerOrdersLoaded({
    required this.orders,
    required this.totalPrice,
  });
}

class GetCustomerOrdersError extends GetCustomerOrdersState {
  final String message;
  GetCustomerOrdersError(this.message);
}

