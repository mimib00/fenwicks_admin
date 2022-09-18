import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_admin/meta/widgets/snack_bar.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("orders");

  RxString filter = "all".obs;

  void changeFilter(String value) {
    filter.value = value;
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrders() {
    Stream<QuerySnapshot<Map<String, dynamic>>>? snap;
    try {
      if (filter.value == "pending") {
        snap = _ref.where("status", isEqualTo: "pending").orderBy("created_at", descending: true).snapshots();
      } else if (filter.value == "onroute") {
        snap = _ref.where("status", isEqualTo: "on route").orderBy("created_at", descending: true).snapshots();
      } else if (filter.value == "deliverd") {
        snap = _ref.where("status", isEqualTo: "deliverd").orderBy("created_at", descending: true).snapshots();
      } else {
        snap = _ref.orderBy("created_at", descending: true).snapshots();
      }
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }

    return snap!;
  }

  void changeStatus(String status, String id) async {
    try {
      await _ref.doc(id).set({"status": status}, SetOptions(merge: true));
      // if (delete) {
      //   final snap = await FirebaseFirestore.instance.collection("admins").get();
      //   final admin = snap.docs.first;
      //   await FirebaseFirestore.instance.collection("admins").doc(admin.id).set({
      //     "notifications": FieldValue.arrayRemove([id])
      //   }, SetOptions(merge: true));
      // }
      Get.back();
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }
}
