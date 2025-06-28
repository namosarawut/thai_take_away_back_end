part of 'get_customer_list_bloc.dart';


@immutable
abstract class GetCustomerListState {}

class GetCustomerListInitial extends GetCustomerListState {}

class GetCustomerListLoading extends GetCustomerListState {}

class GetCustomerListLoaded extends GetCustomerListState {
  final List<CustomerModel> customers;
  final PaginationModel pagination;

  GetCustomerListLoaded({
    required this.customers,
    required this.pagination,
  });
}

class GetCustomerListError extends GetCustomerListState {
  final String message;
  GetCustomerListError(this.message);
}

