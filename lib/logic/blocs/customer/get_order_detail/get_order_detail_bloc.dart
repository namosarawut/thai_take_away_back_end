
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/data/model/order_detail_model.dart';
import 'package:thai_take_away_back_end/repositores/orders_repository.dart';

part 'get_order_detail_event.dart';
part 'get_order_detail_state.dart';


class GetOrderDetailBloc
    extends Bloc<GetOrderDetailEvent, GetOrderDetailState> {
  final OrdersRepository repository;

  GetOrderDetailBloc(this.repository) : super(GetOrderDetailInitial()) {
    on<FetchOrderDetail>((event, emit) async {
      emit(GetOrderDetailLoading());
      try {
        final order = await repository.getOrderDetail(event.orderId);
        emit(GetOrderDetailLoaded(order));
      } catch (e) {
        emit(GetOrderDetailError(e.toString()));
      }
    });
  }
}

