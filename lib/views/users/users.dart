import 'package:fenwick_admin/meta/models/user.dart';
import 'package:fenwick_admin/meta/widgets/loading.dart';
import 'package:fenwick_admin/views/users/components/user_tile.dart';
import 'package:fenwick_admin/views/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends GetView<UsersController> {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: const InputDecoration(
              hintText: "Search for users by email",
            ),
            onChanged: (value) {
              controller.query(value);
            },
          ),
        ),
        GetBuilder<UsersController>(
          init: UsersController(),
          builder: (ctrl) {
            return FutureBuilder<List<Users>>(
              future: ctrl.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Loading());
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
                final users = snapshot.data!;
                List<Users> query = [];
                if (ctrl.email.value.isEmpty) {
                  query = users;
                } else {
                  query =
                      users.where((element) => element.email.contains(ctrl.email.value)).toList();
                }

                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: query.length,
                    itemBuilder: (context, index) {
                      final user = query[index];
                      return UserTile(user: user);
                    },
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }
}
