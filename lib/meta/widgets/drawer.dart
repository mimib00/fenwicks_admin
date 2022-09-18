import 'package:fenwicks_admin/meta/utils/constants.dart';
import 'package:fenwicks_admin/views/root/controllers/navigation_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDrawer extends GetView<NavigationController> {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              onTap: () => controller.select(0),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: kSelectedIconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.list,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: const Text("Products"),
            ),
            ListTile(
              onTap: () => controller.select(1),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: kSelectedIconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: const Text("Users"),
            ),
            ListTile(
              onTap: () => controller.select(2),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: kSelectedIconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.event_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: const Text("Events"),
            ),
            ListTile(
              onTap: () => controller.select(3),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: kSelectedIconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: const Text("Orders"),
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: kSelectedIconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.notification_add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: const Text("Notifications"),
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: kSelectedIconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shopping_cart_checkout_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: const Text("New Orders"),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: kSelectedIconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: const Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}
