import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/data/model/customer_model.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/customer.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/get_customer_list/get_customer_list_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/get_customer_orders/get_customer_orders_bloc.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/customer_screens/customer_detail_screen.dart';


class CustomerPage extends StatelessWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100,),
        Expanded(
          child: BlocBuilder<GetCustomerListBloc, GetCustomerListState>(
            builder: (context, getCustomerListState) {
              if(getCustomerListState is GetCustomerListLoaded){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    // Header section with title and pagination
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[800],
                            ),
                          ),
                           _buildPagination(),
                        ],
                      ),
                    ),

                    // Customer list
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: getCustomerListState.customers.length,
                            itemBuilder: (context, index) {
                              final customer = getCustomerListState.customers[index];
                              return CustomerListItem(customer: customer);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if(getCustomerListState is GetCustomerListLoading){
                return const Center(child: CircularProgressIndicator());
              } else if(getCustomerListState is GetCustomerListError){
                return Center(child: Text('Error: ${getCustomerListState.message}'));
              }else{
                return Center(child: Text('Error: something went wrong}'));
              }
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildPagination() {
  return BlocBuilder<GetCustomerListBloc, GetCustomerListState>(
    builder: (context, state) {
      if (state is GetCustomerListLoaded) {
        final totalPages = state.pagination.totalPages;
        final currentPage = state.pagination.page;
        if (totalPages <= 1) return const SizedBox.shrink();
        final buttonCount = totalPages > 6 ? 6 : totalPages;
        return Row(
          children: List.generate(buttonCount, (idx) {
            final page = idx + 1;
            final isActive = page == currentPage;
            return GestureDetector(
              onTap: () {
                // if (!isActive) _loadData(true, page);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 35,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isActive ? const Color(0xFF6A5BB0) : Colors.white,
                ),
                child: Center(
                  child: Text(
                    '$page',
                    style: TextStyle(
                        color: isActive ? Colors.white : const Color(0xFF6A5BB0),
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              )
            );
          }),
        );
      }
      return const SizedBox.shrink();
    },
  );
}



class CustomerListItem extends StatelessWidget {
  final CustomerModel customer;

  const CustomerListItem({
    Key? key,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime lastDayOfMonth(DateTime date) {
      // กำหนดวันเป็น 0 ของเดือนถัดไป
      return DateTime(date.year, date.month + 1, 0);
    }

    return GestureDetector(
      onTap: () {


        context.read<GetCustomerOrdersBloc>().add(
          FetchCustomerOrders(
            customerId: customer.customerID,
          ),
        );
        Navigator.pushNamed(
          context,
          "customerDetailScreen",
          arguments: CustomerDetailArgs(
            customerNumber: customer.phoneNumber.toString(),
            isBan: false,
          ),
        );
        },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            // Customer icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.group,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            // Customer ID
            Text(
              customer.phoneNumber.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            const Spacer(),
            // Ban button
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CustomerBloc>().add(BanCustomer(  customer.customerID.toString()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF85C70),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child:  Text(
                  customer.status == "active" ? 'Ban' : 'Unban',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}