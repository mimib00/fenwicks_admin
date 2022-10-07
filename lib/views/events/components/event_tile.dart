import 'package:fenwick_admin/core/routes/routes.dart';
import 'package:fenwick_admin/meta/models/event.dart';
import 'package:fenwick_admin/meta/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventTile extends StatelessWidget {
  final Event event;
  const EventTile({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () => Get.toNamed(Routes.eventDetails, arguments: event),
        leading: const CircleAvatar(
          backgroundColor: kSelectedIconBackgroundColor,
          foregroundColor: Colors.white,
          child: Icon(Icons.wine_bar_rounded),
        ),
        title: Text(
          event.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
