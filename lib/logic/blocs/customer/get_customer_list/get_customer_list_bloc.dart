import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/data/model/customer_model.dart';
import 'package:thai_take_away_back_end/data/model/pagination_model.dart';
import 'package:thai_take_away_back_end/repositores/customers_repository.dart';

part 'get_customer_list_event.dart';

part 'get_customer_list_state.dart';

// lib/logic/blocs/get_customer_list/get_customer_list_bloc.dart

class GetCustomerListBloc
    extends Bloc<GetCustomerListEvent, GetCustomerListState> {
  final CustomersRepository repository;

  GetCustomerListBloc(this.repository) : super(GetCustomerListInitial()) {
    on<FetchCustomerList>((event, emit) async {
      emit(GetCustomerListLoading());
      try {
        final resp = await repository.getCustomers(
          page: event.page,
          limit: event.limit,
        );
        emit(GetCustomerListLoaded(
          customers: resp.data,
          pagination: resp.pagination,
        ));
      } catch (e) {
        emit(GetCustomerListError(e.toString()));
      }
    });
  }
}
