import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_admin/meta/models/product.dart';
import 'package:fenwicks_admin/meta/widgets/loading.dart';
import 'package:fenwicks_admin/meta/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  void addProduct() async {
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

  void editProduct(Product product) async {
    try {
      Get.dialog(const Loading(), barrierDismissible: false);

      Map<String, dynamic> data = {
        "name": name.text.trim().isNotEmpty ? name.text.trim() : product.name,
        "description": description.text.trim().isNotEmpty ? description.text.trim() : product.description,
        "quantity": quantity.text.trim().isNotEmpty ? int.parse(quantity.text.trim()) : product.quantity,
        "price": price.text.trim().isNotEmpty ? double.parse(price.text.trim()) : product.price,
        "points": points.text.trim().isNotEmpty ? int.parse(points.text.trim()) : product.points,
        "bounus": bounus.text.trim().isNotEmpty ? int.parse(bounus.text.trim()) : product.bounus,
        "servings": servings.text.trim().isNotEmpty ? int.parse(servings.text.trim()) : product.servings,
        "category": category.text.trim().isNotEmpty ? category.text.trim() : product.category,
        "level": level.text.trim().isNotEmpty ? int.parse(level.text.trim()) : product.level,
        "sku": sku.text.trim().isNotEmpty ? int.parse(sku.text.trim()) : product.sku,
        "rating": 5,
      };

      await FirebaseFirestore.instance.collection("products").doc(product.uid).update(data);

      Get.back();
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
