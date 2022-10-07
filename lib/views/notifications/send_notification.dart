import 'package:fenwick_admin/views/notifications/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendNotification extends GetView<NotificationController> {
  const SendNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: [
          const Text(
            "Send Notification to all users",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              controller: controller.title,
              decoration: const InputDecoration(
                hintText: "Notification Title",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Field required";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              controller: controller.body,
              decoration: const InputDecoration(
                hintText: "Notification Body",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Field required";
                return null;
              },
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.sendNotification();
              }
            },
            icon: const Icon(Icons.send),
            label: const Text("Send"),
          )
        ],
      ),
    );
  }
}
