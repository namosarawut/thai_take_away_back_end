import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:thai_take_away_back_end/logic/blocs/attendance/attendance_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/get_customer_orders/get_customer_orders_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/get_order_detail/get_order_detail_bloc.dart';
import 'package:thai_take_away_back_end/logic/blocs/order_view/order_view_cubit.dart';
import 'package:thai_take_away_back_end/presentation/screens/admin/customer_screens/order_detail_screen.dart';


class CustomerDetailScreen extends StatefulWidget {

  const CustomerDetailScreen({super.key});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
    as CustomerDetailArgs;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      body: BlocBuilder<GetCustomerOrdersBloc, GetCustomerOrdersState>(
        builder: (context, getCustomerOrdersState) {
          if(getCustomerOrdersState is GetCustomerOrdersLoaded){

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
                           Text(args.customerNumber,
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
                        child:  Center(
                            child: Text(args.isBan ? "Unban" : "Ban",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      )
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
                            itemCount: getCustomerOrdersState.orders.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: (){
                                  context.read<GetOrderDetailBloc>().add(FetchOrderDetail(getCustomerOrdersState.orders[index].orderID));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OrderDetailPage(
                                        orderId: getCustomerOrdersState.orders[index].orderID.toString(),

                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title:  Text("${getCustomerOrdersState.orders[index].orderID}"),
                                  subtitle:  Text("${getCustomerOrdersState.orders[index].totalPrice} k."),
                                  leading: const Icon(Icons.image, color: Color(0xFFFD80A3)),
                                ),
                              );
                            },
                          ),

                        ),
                        Positioned(
                          bottom: 16,
                          right: 0,
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
                              child:  Center(
                                child: Text(
                                  "${getCustomerOrdersState.totalPrice} NOK",
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
          } else if (getCustomerOrdersState is GetCustomerOrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (getCustomerOrdersState is GetCustomerOrdersError) {
            return Center(child: Text("error : ${getCustomerOrdersState.message}"));
          }else{
            return Center(child: Text("error : something went wrong"));
          }

        },
      ),
    );
  }
}




class CustomerDetailArgs {
  final String customerNumber;
  final bool isBan;

  CustomerDetailArgs({
    required this.customerNumber,
    required this.isBan,
  });
}

