import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thai_take_away_back_end/logic/blocs/customer/get_order_detail/get_order_detail_bloc.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderId;


  const OrderDetailPage({
    super.key,
    required this.orderId,

  });

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<GetOrderDetailBloc, GetOrderDetailState>(
      builder: (context, getOrderDetailState) {
        if(getOrderDetailState is GetOrderDetailLoaded) {
          final total = getOrderDetailState.order.orderDetails.fold<double>(0, (sum, item) => sum + double.parse(item.price.toString()));
          final formatter = NumberFormat('#,###', 'en_US');
          return Scaffold(
            backgroundColor: const Color(0xFFF1F4F9),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: icon + order ID
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
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFD80A3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                            Icons.restaurant_menu, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        orderId,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF534598),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'food list',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF534598),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // List of items
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListView.separated(
                        itemCount: getOrderDetailState.order.orderDetails.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, idx) {
                          final item = getOrderDetailState.order.orderDetails[idx];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ชื่อเมนู + รายละเอียด (ถ้ามี)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF534598),
                                        ),
                                      ),
                                      if (getOrderDetailState.order.orderDetails[idx].additionalInfo.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          getOrderDetailState.order.orderDetails[idx].additionalInfo,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF7162BA),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),

                                // ราคา
                                Text(
                                  '${formatter.format(item.price)} NOK',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF534598),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Total price
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 24, right: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${formatter.format(total)} NOK',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF534598),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else if(getOrderDetailState is GetOrderDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        else if(getOrderDetailState is GetOrderDetailError) {
          return Center(child: Text("Error: ${getOrderDetailState.message}"));
        }else{
          return Center(child: Text("Error: something went wrong"));
        }

      },
    );
  }
}

// Model สำหรับ Order Item
class OrderItem {
  final String name;
  final String? subtitle;
  final int price;

  OrderItem({
    required this.name,
    this.subtitle,
    required this.price,
  });
}
