// order_view_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

enum OrderViewState { orderList, orderHistory }

class OrderViewCubit extends Cubit<OrderViewState> {
  OrderViewCubit() : super(OrderViewState.orderList);

  void selectOrderList() => emit(OrderViewState.orderList);
  void selectOrderHistory() => emit(OrderViewState.orderHistory);
}
