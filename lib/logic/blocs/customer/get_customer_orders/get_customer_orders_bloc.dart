
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/data/model/order_model.dart';
import 'package:thai_take_away_back_end/repositores/customers_repository.dart';

part 'get_customer_orders_event.dart';
part 'get_customer_orders_state.dart';

class GetCustomerOrdersBloc
    extends Bloc<GetCustomerOrdersEvent, GetCustomerOrdersState> {
  final CustomersRepository repository;

  GetCustomerOrdersBloc(this.repository)
      : super(GetCustomerOrdersInitial()) {
    on<FetchCustomerOrders>((event, emit) async {
      emit(GetCustomerOrdersLoading());
      try {
        final resp = await repository.getCustomerOrders(
          customerId: event.customerId,
          startDate: event.startDate,
          endDate: event.endDate,
        );
        emit(GetCustomerOrdersLoaded(
          orders: resp.data,
          totalPrice: resp.totalPrice,
        ));
      } catch (e) {
        emit(GetCustomerOrdersError(e.toString()));
      }
    });
  }
}

