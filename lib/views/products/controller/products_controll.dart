import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_admin/meta/models/product.dart';
import 'package:fenwicks_admin/meta/widgets/snack_bar.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    try {
      final snap = await FirebaseFirestore.instance.collection("products").get();

      for (var item in snap.docs) {
        products.add(Product.fromJson(item.data(), item.id));
      }
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.code));
    }
    return products;
  }
}
