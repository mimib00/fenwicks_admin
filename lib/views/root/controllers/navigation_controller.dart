import 'package:fenwicks_admin/views/events/controller/events_controller.dart';
import 'package:fenwicks_admin/views/events/events.dart';
import 'package:fenwicks_admin/views/notifications/notification.dart';
import 'package:fenwicks_admin/views/orders/orders.dart';
import 'package:fenwicks_admin/views/products/products.dart';
import 'package:fenwicks_admin/views/users/users.dart';
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
