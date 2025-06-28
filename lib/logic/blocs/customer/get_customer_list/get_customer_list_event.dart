part of 'get_customer_list_bloc.dart';

@immutable
abstract class GetCustomerListEvent {}

/// Fetch a page of customers
class FetchCustomerList extends GetCustomerListEvent {
  final int page;
  final int limit;

  FetchCustomerList({this.page = 1, this.limit = 10});
}
