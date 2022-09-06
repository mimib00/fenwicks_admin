import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar errorCard(String error) {
  return GetSnackBar(
    title: "Error",
    message: error,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
  );
}
