import 'package:fenwick_admin/core/routes/routes.dart';
import 'package:fenwick_admin/meta/models/order.dart';
import 'package:fenwick_admin/meta/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () => Get.toNamed(Routes.orderDetails, arguments: order),
        leading: const CircleAvatar(
          backgroundColor: kSelectedIconBackgroundColor,
          foregroundColor: Colors.white,
          child: Icon(Icons.shopping_cart),
        ),
        title: Text(
          order.id,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
