

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/repositores/customers_repository.dart';

part 'ban_customer_event.dart';
part 'ban_customer_state.dart';



class BanCustomerBloc extends Bloc<BanCustomerEvent, BanCustomerState> {
  final CustomersRepository repository;

  BanCustomerBloc(this.repository) : super(BanCustomerInitial()) {
    on<BanCustomerRequested>((event, emit) async {
      emit(BanCustomerLoading());
      try {
        final resp = await repository.banCustomer(event.customerId);
        emit(BanCustomerSuccess(resp.message));
      } catch (e) {
        emit(BanCustomerFailure(e.toString()));
      }
    });
  }
}
