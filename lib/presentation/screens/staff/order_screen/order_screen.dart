import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance/attendance_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/customer.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/customer_screens/order_detail_screen.dart';
import 'package:thai_take_away_back_end/presentation/widgets/add_employee_dialog.dart';
import 'package:thai_take_away_back_end/presentation/widgets/employee_period_dialog.dart';



class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _selectedDateRange = "11/12/2024 - 11/03/2025";

  void _showDatePicker() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SizedBox(
          height: 400,
          width: 300,
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: (args) {
              if (args.value is PickerDateRange) {
                final start = args.value.startDate;
                final end = args.value.endDate ?? start;
                final format = DateFormat('MM/dd/yyyy');
                setState(() {
                  _selectedDateRange =
                  "${format.format(start!)} - ${format.format(end)}";
                });
              }
            },
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Row(
            children: [
              SizedBox(width: 120,),
              Container(
                width: MediaQuery.of(context).size.width - 120-24,
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    // Header section with title and pagination
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Employees',
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
                    // Switch Button and Date Picker
                    Row(
                      children: [
                        Container(
                          width: 263,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(0xFFE2E1EA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              // Animated slider background
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                left: state.isCheckIn ? 0 : 131.5,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Container(
                                    width: 131.5,
                                    height: 37,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF534598),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              // Button labels
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<AttendanceBloc>().add(ToggleCheckInMode(true));
                                      },
                                      child: Center(
                                        child: Text(
                                          'Order Lists',
                                          style: TextStyle(
                                            color: state.isCheckIn ? Colors.white : Color(0xFF534598),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<AttendanceBloc>().add(ToggleCheckInMode(false));
                                      },
                                      child: Center(
                                        child: Text(
                                          'Order history',
                                          style: TextStyle(
                                            color: !state.isCheckIn ? Colors.white : Color(0xFF534598),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: _showDatePicker,
                          child: Container(
                            width: 263,
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFF534598),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(_selectedDateRange,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    // Order List
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: (){
                                    // ในที่ที่ต้องการเปิดหน้า Order Detail:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => OrderDetailPage(
                                          orderId: '12212123',
                                          items: [
                                            OrderItem(name: 'Stekt ris med kylling', price: 129),
                                            OrderItem(name: 'Stekt ris med kylling', price: 129),
                                            OrderItem(name: 'Stekt ris med kylling', price: 129),
                                            OrderItem(
                                              name: 'Stekt ris med kylling',
                                              subtitle: 'Stekt ris med kylling',
                                              price: 129,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                  },
                                  child: ListTile(
                                    title: const Text("12212123"),
                                    subtitle: const Text("1000 k."),
                                    leading: const Icon(Icons.image, color: Color(0xFFFD80A3)),
                                  ),
                                );
                              },
                            ),

                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height-310,
                            left:  MediaQuery.of(context).size.width-230,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 56,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7162BA),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    "9,000,000 NOK",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),



                  ],
                ),
              ),
            ],
          );
        },
      ),
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