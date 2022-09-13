import 'package:fenwicks_admin/meta/models/user.dart';
import 'package:fenwicks_admin/views/users/controllers/users_controller.dart';
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
          builder: (_) {
            return FutureBuilder<List<Users>>(
              future: controller.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
                final users = snapshot.data!;
                List<Users> query = [];
                if (controller.email.value.isEmpty) {
                  query = users;
                } else {
                  query = users.where((element) => element.email.contains(controller.email.value)).toList();
                }

                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: query.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {},
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(query[index].name),
                        subtitle: Text(query[index].email),
                      );
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
