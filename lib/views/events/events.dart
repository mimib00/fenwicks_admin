import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_admin/core/routes/routes.dart';
import 'package:fenwicks_admin/meta/models/event.dart';
import 'package:fenwicks_admin/views/events/components/event_tile.dart';
import 'package:fenwicks_admin/views/events/controller/events_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventScreen extends GetView<EventsController> {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();
          List<Event> events = [];
          final data = snapshot.data!;
          for (var item in data.docs) {
            events.add(Event.fromJson(item.data(), uid: item.id));
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: events.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return EventTile(event: events[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addEvent);
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
