import 'package:fenwicks_admin/meta/widgets/loading.dart';
import 'package:fenwicks_admin/meta/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();

  void sendNotification() async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);
      // send http request
      final url = Uri.parse("https://us-central1-fenwicks-pub-a46a5.cloudfunctions.net/sendNotifications");

      final res = await http.post(
        url,
        body: {
          "title": title.text.trim(),
          "body": body.text.trim(),
        },
      );

      // // throw error
      // if (res.statusCode == 404) throw res.body;
      // show status is good and clear fields
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 3),
          title: "Success",
          messageText: Text(
            "Notification has been sent",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Baloo",
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
      title.clear();
      body.clear();
      Get.back();
    } catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.toString()));
    }
  }
}
