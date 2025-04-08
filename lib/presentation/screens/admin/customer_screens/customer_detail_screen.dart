import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance/attendance_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/order_view/order_view_cubit.dart';


class CustomerDetailScreen extends StatefulWidget {

  const CustomerDetailScreen({super.key});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  final TextEditingController employeeIdController = TextEditingController();
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
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile Row
            SizedBox(height: 30,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){Navigator.pop(context);},
                  child: Container(
                    width: 70,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF534598)
                    ),
                    child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 40,),
                  ),
                ),
                SizedBox(width: 20,),
                Row(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFD80A3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.people, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Text("12212123",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Spacer(),
                Container(
                  width: 263,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF84E51),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                      child: Text("Ban",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                )
              ],
            ),
            const SizedBox(height: 16),
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
                        return ListTile(
                          title: const Text("12212123"),
                          subtitle: const Text("1000 k."),
                          leading: const Icon(Icons.image, color: Color(0xFFFD80A3)),
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
      );
  },
),
    );
  }
}


