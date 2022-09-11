import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_admin/meta/widgets/loading.dart';
import 'package:fenwicks_admin/meta/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  void register() async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      user = credential.user;

      FirebaseMessaging.instance.subscribeToTopic("admins");

      await FirebaseFirestore.instance.collection("admins").doc(user!.uid).set({
        "email": email.text.trim(),
      });
      Get.back();
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.code));
    }
  }

  void login() async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      Get.back();
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.code));
    }
  }

  void rest() {
    email.clear();
    password.clear();
    confirmPassword.clear();
  }
}
