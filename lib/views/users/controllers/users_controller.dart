import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_admin/meta/models/user.dart';
import 'package:fenwicks_admin/meta/widgets/snack_bar.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
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
}
