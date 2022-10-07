import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwick_admin/meta/models/order.dart';
import 'package:fenwick_admin/meta/widgets/snack_bar.dart';
import 'package:fenwick_admin/views/orders/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetail extends GetView<OrderController> {
  const OrderDetail({super.key});

  Future<Map<String, dynamic>> getProductData(DocumentReference<Map<String, dynamic>> ref) async {
    DocumentSnapshot<Map<String, dynamic>>? doc;
    try {
      doc = await ref.get();
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    return doc!.data()!;
  }

  @override
  Widget build(BuildContext context) {
    final Order order = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Status",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  order.status,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Number",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  order.id,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Date",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  DateFormat("E, MMM dd yyy").format(order.createdAt.toDate()),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Client Name",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  order.owner.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Client Phone",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  order.owner.phone,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  order.address,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  order.method,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Price",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "\$${order.total.ceil()}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order",
                  style: TextStyle(fontSize: 20),
                ),
                ...order.products
                    .map(
                      (e) => FutureBuilder<Map<String, dynamic>>(
                        future: getProductData(e["product"]),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) return Container();
                          final data = snapshot.data!;
                          return Text(
                            "${data["name"]} X ${e["quantity"]}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          );
                        },
                      ),
                    )
                    .toList()
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                controller.changeStatus("on route", order.id);
              },
              icon: const Icon(Icons.route),
              label: const Text("On route"),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () {
                controller.changeStatus("delivered", order.id);
              },
              icon: const Icon(Icons.check),
              label: const Text("Deliverd"),
            ),
          ],
        ),
      ),
    );
  }
}
