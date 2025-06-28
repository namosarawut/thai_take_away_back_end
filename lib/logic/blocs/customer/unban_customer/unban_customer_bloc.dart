

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/repositores/customers_repository.dart';

part 'unban_customer_event.dart';
part 'unban_customer_state.dart';



class UnbanCustomerBloc extends Bloc<UnbanCustomerEvent, UnbanCustomerState> {
  final CustomersRepository repository;

  UnbanCustomerBloc(this.repository) : super(UnbanCustomerInitial()) {
    on<UnbanCustomerRequested>((event, emit) async {
      emit(UnbanCustomerLoading());
      try {
        final resp = await repository.unbanCustomer(event.customerId);
        emit(UnbanCustomerSuccess(resp.message));
      } catch (e) {
        emit(UnbanCustomerFailure(e.toString()));
      }
    });
  }
}
