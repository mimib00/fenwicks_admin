import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_admin/meta/models/user.dart';
import 'package:fenwicks_admin/meta/widgets/loading.dart';
import 'package:fenwicks_admin/meta/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController points = TextEditingController();

  RxString email = "".obs;

  void query(String value) {
    email.value = value;
    update();
  }

  Future<List<Users>> getUsers() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
    try {
      final data = await FirebaseFirestore.instance.collection("users").limit(50).get();
      docs = data.docs;
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.code));
    }

    List<Users> users = [];
    for (var doc in docs) {
      users.add(Users.fromJson(doc.data(), uid: doc.id));
    }
    return users;
  }

  void sendGift(Users user) async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);
      // add the points
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({"points": user.points + int.parse(points.text.trim())});

      await http.post(
        Uri.parse("https://us-central1-fenwicks-pub-a46a5.cloudfunctions.net/sendNotification"),
        body: {"amount": points.toString(), "token": user.token},
      );
      Get.back();
      Get.back();
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
  }
}
