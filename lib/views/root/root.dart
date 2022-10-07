import 'package:fenwick_admin/meta/widgets/drawer.dart';
import 'package:fenwick_admin/views/root/controllers/navigation_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootScreen extends GetView<NavigationController> {
  const RootScreen({super.key});

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
