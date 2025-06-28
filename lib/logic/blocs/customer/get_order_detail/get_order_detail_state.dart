part of 'get_order_detail_bloc.dart';

@immutable
abstract class GetOrderDetailState {}

class GetOrderDetailInitial extends GetOrderDetailState {}

class GetOrderDetailLoading extends GetOrderDetailState {}

class GetOrderDetailLoaded extends GetOrderDetailState {
  final OrderDetailModel order;

  GetOrderDetailLoaded(this.order);
}

class GetOrderDetailError extends GetOrderDetailState {
  final String message;
  GetOrderDetailError(this.message);
}

