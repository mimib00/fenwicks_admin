import 'package:fenwicks_admin/views/auth/login.dart';
import 'package:fenwicks_admin/views/auth/register.dart';
import 'package:fenwicks_admin/views/products/product_details.dart';
import 'package:fenwicks_admin/views/root/controllers/bindings.dart';
import 'package:fenwicks_admin/views/root/root.dart';
import 'package:fenwicks_admin/views/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routes {
  static const root = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const productDetails = '/products/details';

  static List<GetPage<dynamic>> routes = [
    GetPage<Widget>(name: root, page: () => const RootScreen(), binding: RootBindings()),
    GetPage<Widget>(name: login, page: () => const LoginScreen()),
    GetPage<Widget>(name: register, page: () => const RegisterScreen()),
    GetPage<Widget>(name: splash, page: () => const SplashScreen()),
    GetPage<Widget>(name: productDetails, page: () => const ProductDetails()),
  ];
}
