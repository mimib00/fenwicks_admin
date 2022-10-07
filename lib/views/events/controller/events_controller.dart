import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwick_admin/meta/models/event.dart';
import 'package:fenwick_admin/meta/widgets/loading.dart';
import 'package:fenwick_admin/meta/widgets/snack_bar.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class EventsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController points = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController secret = TextEditingController();

  ScreenshotController screenshotController = ScreenshotController();

  Stream<QuerySnapshot<Map<String, dynamic>>> getEvents() {
    return FirebaseFirestore.instance.collection("events").snapshots();
  }

  RxString dropValue = EventTypes.concert.name.obs;

  Rx<DateTime> time = Rx(DateTime.now());

  void genrateQR(String text) {
    Get.dialog(
      Align(
        alignment: Alignment.center,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QrImage(
                  data: text,
                  version: QrVersions.auto,
                  size: 300,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final image = await screenshotController.captureFromWidget(
                      Container(
                        color: Colors.white,
                        child: QrImage(
                          data: text,
                          version: QrVersions.auto,
                          size: 300,
                        ),
                      ),
                    );
                    await FileSaver.instance.saveFile("QR_${DateTime.now().millisecondsSinceEpoch}", image, ".jpg",
                        mimeType: MimeType.JPEG);
                    Get.back();
                  },
                  icon: const Icon(Icons.download),
                  label: const Text("Download"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);
      Map<String, dynamic> data = {
        "name": name.text.trim(),
        "description": description.text.trim(),
        "points": int.parse(points.text.trim()),
        "date": Timestamp.fromDate(time.value),
        "address": address.text,
        "going": [],
        "secret": secret.text,
        "photos": <String>[],
        "type": dropValue.value,
      };

      await FirebaseFirestore.instance.collection("events").add(data);

      Get.back();
      Get.back();
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.code));
    }
  }

  void editEvent(Event event) async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);

      Map<String, dynamic> data = {
        "name": name.text.trim().isNotEmpty ? name.text.trim() : event.name,
        "description": description.text.trim().isNotEmpty ? description.text.trim() : event.description,
        "address": address.text.trim().isNotEmpty ? address.text.trim() : event.address,
        "date": Timestamp.fromDate(time.value),
        "points": points.text.trim().isNotEmpty ? int.parse(points.text.trim()) : event.points,
        "secret": secret.text.trim().isNotEmpty ? secret.text.trim() : event.secret,
        "type": dropValue.value,
      };

      await FirebaseFirestore.instance.collection("events").doc(event.id).update(data);

      Get.back();
      Get.back();
      Get.back();
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.code));
    }
  }

  void setDate(DateTime date) {
    time.value = date;
    update();
  }

  void setValue(String value) {
    dropValue.value = value;
    update();
  }

  void reset() {
    name.clear();
    description.clear();
    points.clear();
    address.clear();
    secret.clear();
  }
}
