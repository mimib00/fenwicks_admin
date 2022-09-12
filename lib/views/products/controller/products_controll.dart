import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_admin/meta/models/product.dart';
import 'package:fenwicks_admin/meta/widgets/loading.dart';
import 'package:fenwicks_admin/meta/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final GlobalKey<FormState> addForm = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController points = TextEditingController();
  final TextEditingController bounus = TextEditingController();
  final TextEditingController servings = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController level = TextEditingController();
  final TextEditingController sku = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return FirebaseFirestore.instance.collection("products").snapshots();
  }

  Future<void> addProduct() async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);
      Map<String, dynamic> data = {
        "name": name.text.trim(),
        "description": description.text.trim(),
        "quantity": int.parse(quantity.text.trim()),
        "price": double.parse(price.text.trim()),
        "points": int.parse(points.text.trim()),
        "bounus": int.parse(bounus.text.trim()),
        "servings": int.parse(servings.text.trim()),
        "category": category.text.trim(),
        "level": int.parse(level.text.trim()),
        "sku": int.parse(sku.text.trim()),
        "rating": 5,
      };

      await FirebaseFirestore.instance.collection("products").add(data);

      Get.back();
      Get.back();
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.code));
    }
  }

  void reset() {
    name.clear();
    description.clear();
    quantity.clear();
    price.clear();
    points.clear();
    bounus.clear();
    servings.clear();
    category.clear();
    level.clear();
    sku.clear();
  }
}
