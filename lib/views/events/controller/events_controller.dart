import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EventsController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>> getEvents() {
    return FirebaseFirestore.instance.collection("events").snapshots();
  }
}
