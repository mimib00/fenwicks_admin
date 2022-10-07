import 'package:fenwick_admin/views/events/events.dart';
import 'package:fenwick_admin/views/notifications/send_notification.dart';
import 'package:fenwick_admin/views/orders/orders.dart';
import 'package:fenwick_admin/views/products/products.dart';
import 'package:fenwick_admin/views/users/users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final List<Widget> tabs = [
    const ProductScreen(),
    const UsersScreen(),
    const EventScreen(),
    const OrdersScreen(),
    const SendNotification(),
  ];

  RxInt index = 0.obs;

  void select(int value) {
    index.value = value;
    Get.back();
    update();
  }
}
