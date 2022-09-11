import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final List<Widget> tabs = [
    const Center(
      child: Text("Hello"),
    ),
    const Center(
      child: Text("Hello2"),
    ),
    const Center(
      child: Text("Hello3"),
    )
  ];

  RxInt index = 0.obs;

  void select(int value) {
    index.value = value;
    Get.back();
    update();
  }
}
