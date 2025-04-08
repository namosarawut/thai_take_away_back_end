import 'package:flutter_bloc/flutter_bloc.dart';

// Models
class Customer {
  final String id;

  Customer({required this.id});
}

// Events
abstract class CustomerEvent {}

class LoadCustomers extends CustomerEvent {}

class BanCustomer extends CustomerEvent {
  final String customerId;

  BanCustomer(this.customerId);
}

// States
class CustomerState {
  final List<Customer> customers;
  final int currentPage;
  final int totalPages;

  CustomerState({
    required this.customers,
    this.currentPage = 1,
    this.totalPages = 6,
  });

  CustomerState copyWith({
    List<Customer>? customers,
    int? currentPage,
    int? totalPages,
  }) {
    return CustomerState(
      customers: customers ?? this.customers,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

// BLoC
class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerState(customers: [])) {
    on<LoadCustomers>(_onLoadCustomers);
    on<BanCustomer>(_onBanCustomer);
  }

  void _onLoadCustomers(LoadCustomers event, Emitter<CustomerState> emit) {
    // Mock data
    final mockCustomers = [
      Customer(id: '12212123'),
      Customer(id: '12212123'),
      Customer(id: '12212123'),
      Customer(id: '12212123'),
      Customer(id: '12212123'),
      Customer(id: '12212123'),
      Customer(id: '12212123'),
    ];
    emit(state.copyWith(customers: mockCustomers));
  }

  void _onBanCustomer(BanCustomer event, Emitter<CustomerState> emit) {
    print('Customer with ID: ${event.customerId} has been banned');
    // In a real app, you'd update the customer status in the database
    // and then update the state with the new list of customers
  }
}