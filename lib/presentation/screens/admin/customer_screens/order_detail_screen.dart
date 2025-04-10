import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderId;
  final List<OrderItem> items;

  const OrderDetailPage({
    super.key,
    required this.orderId,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final total = items.fold<int>(0, (sum, item) => sum + item.price);
    final formatter = NumberFormat('#,###', 'en_US');

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF7162BA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: icon + order ID
            Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFD80A3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.restaurant_menu, color: Colors.white),
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
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, idx) {
                    final item = items[idx];
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
                                if (item.subtitle != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    item.subtitle!,
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
              padding: const EdgeInsets.only(top: 12, bottom: 24, right: 16),
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
