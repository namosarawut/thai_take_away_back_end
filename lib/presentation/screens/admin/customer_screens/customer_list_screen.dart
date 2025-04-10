import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/customer.dart';



class CustomerPage extends StatelessWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100,),
        Expanded(
          child: BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
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
                        const PaginationBar(),
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
                          itemCount: state.customers.length,
                          itemBuilder: (context, index) {
                            final customer = state.customers[index];
                            return CustomerListItem(customer: customer);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}


class PaginationBar extends StatelessWidget {
  const PaginationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, (index) {
        final pageNumber = index + 1;
        final isActive = pageNumber == 1; // Assuming page 1 is active
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 35,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              color: isActive ? const Color(0xFF6A5BB0) : Colors.white,
          ),
          child: Center(
            child: Text(
              '$pageNumber',
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF6A5BB0),
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CustomerListItem extends StatelessWidget {
  final Customer customer;

  const CustomerListItem({
    Key? key,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "customerDetailScreen");
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
              customer.id,
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
                  context.read<CustomerBloc>().add(BanCustomer(customer.id));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF85C70),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Ban',
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