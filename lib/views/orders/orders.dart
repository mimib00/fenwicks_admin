import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwick_admin/meta/models/order.dart';
import 'package:fenwick_admin/meta/models/user.dart';
import 'package:fenwick_admin/views/orders/components/order_tile.dart';
import 'package:fenwick_admin/views/orders/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends GetView<OrderController> {
  const OrdersScreen({super.key});

  Future<List<Order>> getOrder(QuerySnapshot<Map<String, dynamic>> snap) async {
    List<Order> orders = [];
    for (var item in snap.docs) {
      DocumentReference<Map<String, dynamic>> ref = item.data()["owner"];
      final temp = await ref.get();
      final user = Users.fromJson(temp.data()!, uid: temp.id);
      final map = item.data();
      map["owner"] = user;
      orders.add(Order.fromJson(map, item.id));
    }
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: controller.tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          enableFeedback: false,
          labelPadding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Pending"),
            Tab(text: "On Route"),
            Tab(text: "Deliverd"),
          ],
          onTap: (value) {
            switch (value) {
              case 0:
                controller.changeFilter("all");
                break;
              case 1:
                controller.changeFilter("pending");
                break;
              case 2:
                controller.changeFilter("onroute");
                break;
              case 3:
                controller.changeFilter("deliverd");
                break;
              default:
                controller.changeFilter("all");
            }
          },
        ),
      ),
      body: Obx(
        () {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>?>(
            stream: controller.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return Container();
              final data = snapshot.data!;

              return FutureBuilder<List<Order>>(
                future: getOrder(data),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Container();
                  }
                  final orders = snapshot.data!;

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: orders.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return OrderTile(
                        order: orders[index],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
