import 'package:fenwicks_admin/meta/models/product.dart';
import 'package:fenwicks_admin/views/products/components/product_tile.dart';
import 'package:fenwicks_admin/views/products/controller/products_controll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends GetView<ProductsController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: controller.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Products"),
            );
          }
          final products = snapshot.data!;

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return ProductTile(product: products[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
