import 'package:fenwicks_admin/meta/models/product.dart';
import 'package:fenwicks_admin/views/products/controller/products_controll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddProductScreen extends GetView<ProductsController> {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product? product = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(product == null ? "Add a Product" : "Edit Product"),
        centerTitle: true,
      ),
      body: Form(
        onWillPop: () async {
          controller.reset();
          return true;
        },
        key: controller.formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.name,
                decoration: InputDecoration(
                  hintText: product == null ? "Name" : "Name: ${product.name}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.description,
                decoration: InputDecoration(
                  hintText: product == null ? "Description" : "Description: ${product.description}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.quantity,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: product == null ? "Available Quantity" : "Available Quantity: ${product.quantity}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.price,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  // hintText: "Price",
                  hintText: product == null ? "Price" : "Price: ${product.price}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.points,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: product == null ? "Points" : "Points: ${product.points}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.bounus,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: product == null ? "Bounus" : "Bounus: ${product.bounus}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.servings,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: product == null ? "Servings" : "Servings: ${product.servings}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.category,
                decoration: InputDecoration(
                  hintText: product == null ? "Category" : "Category: ${product.category}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.sku,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: product == null ? "Stock Keeping Unit (sku)" : "SKU: ${product.sku}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                controller: controller.level,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: product == null ? "Level" : "Level: ${product.level}",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Field required";
                  return null;
                },
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                if (product == null) {
                  if (controller.formKey.currentState!.validate()) {
                    controller.addProduct();
                  }
                } else {
                  controller.editProduct(product);
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
