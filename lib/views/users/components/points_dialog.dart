import 'package:fenwick_admin/meta/models/user.dart';
import 'package:fenwick_admin/views/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PointsDialog extends GetView<UsersController> {
  final Users user;
  const PointsDialog({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send Gift to ${user.name}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: controller.formKey,
                    onWillPop: () async {
                      controller.points.clear();
                      return true;
                    },
                    child: TextFormField(
                      controller: controller.points,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        hintText: "Ammount",
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.sendGift(user);
                    }
                  },
                  child: const Text("Send"),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
