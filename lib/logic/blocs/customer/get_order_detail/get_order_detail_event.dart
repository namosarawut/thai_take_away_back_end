part of 'get_order_detail_bloc.dart';


@immutable
abstract class GetOrderDetailEvent {}

/// Triggered to load a specific order by ID
class FetchOrderDetail extends GetOrderDetailEvent {
  final int orderId;

  FetchOrderDetail(this.orderId);
}
