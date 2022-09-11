import 'package:fenwicks_admin/meta/widgets/drawer.dart';
import 'package:fenwicks_admin/views/home/controllers/navigation_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<NavigationController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        title: const Text("Fenwicks Admin"),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return controller.tabs[controller.index.value];
        },
      ),
    );
  }
}
