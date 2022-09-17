import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_admin/core/routes/routes.dart';
import 'package:fenwicks_admin/meta/models/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatelessWidget {
  const EventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Event event = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: event.date.microsecondsSinceEpoch <= Timestamp.now().microsecondsSinceEpoch
                  ? Colors.red
                  : Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5),
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              event.date.microsecondsSinceEpoch <= Timestamp.now().microsecondsSinceEpoch ? "Passed" : "Up coming",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Description: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Expanded(
                  child: Text(
                    event.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                const Text(
                  "Date: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  DateFormat("dd-MM-yyy").format(event.date.toDate()),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                const Text(
                  "Points: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "${event.points}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Address: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Expanded(
                  child: Text(
                    event.address,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "type: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Expanded(
                  child: Text(
                    event.type.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {},
            child: const Icon(Icons.qr_code_2),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              Get.toNamed(Routes.addEvent, arguments: event);
            },
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "btn3",
            onPressed: () {
              Get.defaultDialog(
                title: "Warning",
                content: const Text("Are you sure you want to delete this?"),
                confirm: TextButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection("events").doc(event.id).delete();
                    Get.back();
                    Get.back();
                  },
                  child: const Text("Yes"),
                ),
                cancel: TextButton(onPressed: () => Get.back(), child: const Text("No")),
              );
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
