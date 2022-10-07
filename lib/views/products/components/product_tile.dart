import 'package:fenwick_admin/core/routes/routes.dart';
import 'package:fenwick_admin/meta/models/product.dart';
import 'package:fenwick_admin/meta/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () => Get.toNamed(Routes.productDetails, arguments: product),
        leading: const CircleAvatar(
          backgroundColor: kSelectedIconBackgroundColor,
          foregroundColor: Colors.white,
          child: Icon(Icons.wine_bar_rounded),
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
