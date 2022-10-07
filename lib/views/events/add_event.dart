import 'package:fenwick_admin/meta/models/event.dart';
import 'package:fenwick_admin/views/events/controller/events_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends GetView<EventsController> {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Event? event = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(event == null ? "Add an Event" : "Edit Event"),
        centerTitle: true,
      ),
      body: Form(
        onWillPop: () async {
          controller.reset();
          return true;
        },
        key: controller.formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.name,
                decoration: InputDecoration(
                  hintText: event == null ? "Name" : "Name: ${event.name}",
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
                controller: controller.description,
                decoration: InputDecoration(
                  hintText: event == null ? "Description" : "Description: ${event.description}",
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
                controller: controller.address,
                decoration: InputDecoration(
                  hintText: event == null ? "Address" : "Address: ${event.address}",
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
                controller: controller.points,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: event == null ? "Points" : "Points: ${event.points}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Obx(
              () {
                if (event != null) {
                  controller.setValue(event.type.name);
                }
                return DropdownButton<String>(
                  value: controller.dropValue.value,
                  items: [
                    DropdownMenuItem(
                      value: EventTypes.concert.name,
                      child: Text(
                        EventTypes.concert.name,
                      ),
                    ),
                    DropdownMenuItem(
                      value: EventTypes.themeNight.name,
                      child: Text(
                        EventTypes.themeNight.name,
                      ),
                    ),
                    DropdownMenuItem(
                      value: EventTypes.drinking.name,
                      child: Text(
                        EventTypes.drinking.name,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    controller.setValue(value);
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.secret,
                decoration: InputDecoration(
                  hintText: event == null ? "Secret" : "Secret: ${event.secret}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Obx(
              () {
                if (event != null) {
                  controller.setDate(event.date.toDate());
                }
                return GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2050),
                    );
                    if (date != null) {
                      controller.setDate(date);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      DateFormat("dd-MM-yyy").format(controller.time.value),
                      style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                if (event == null) {
                  if (controller.formKey.currentState!.validate()) {
                    controller.addEvent();
                  }
                } else {
                  controller.editEvent(event);
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
