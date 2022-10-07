import 'package:fenwick_admin/meta/models/user.dart';
import 'package:fenwick_admin/views/users/components/points_dialog.dart';
import 'package:fenwick_admin/views/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTile extends StatefulWidget {
  final Users user;
  const UserTile({
    super.key,
    required this.user,
  });

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  late bool isActive;

  @override
  void initState() {
    isActive = widget.user.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.dialog(PointsDialog(user: widget.user));
      },
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(widget.user.name),
      subtitle: Text(widget.user.email),
      trailing: IconButton(
        onPressed: () async {
          final controller = Get.find<UsersController>();

          final status = await controller.banUser(!widget.user.isActive, widget.user.id!);
          if (status) {
            setState(() {
              isActive = !isActive;
            });
          }
        },
        iconSize: 35,
        icon: !isActive
            ? const Icon(
                Icons.delete_forever_rounded,
                color: Colors.red,
              )
            : const Icon(
                Icons.person_add_alt_1,
                color: Colors.green,
              ),
      ),
    );
  }
}
