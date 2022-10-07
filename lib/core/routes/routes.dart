import 'package:fenwick_admin/views/auth/login.dart';
import 'package:fenwick_admin/views/auth/register.dart';
import 'package:fenwick_admin/views/events/add_event.dart';
import 'package:fenwick_admin/views/events/event_details.dart';
import 'package:fenwick_admin/views/orders/order_details.dart';
import 'package:fenwick_admin/views/products/add_product.dart';
import 'package:fenwick_admin/views/products/product_details.dart';
import 'package:fenwick_admin/views/root/controllers/bindings.dart';
import 'package:fenwick_admin/views/root/root.dart';
import 'package:fenwick_admin/views/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routes {
  static const root = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const productDetails = '/products/details';
  static const addProduct = '/products/add';
  static const eventDetails = '/events/details';
  static const addEvent = '/events/add';
  static const orderDetails = '/orders/details';

  static List<GetPage<dynamic>> routes = [
    GetPage<Widget>(name: root, page: () => const RootScreen(), binding: RootBindings()),
    GetPage<Widget>(name: login, page: () => const LoginScreen()),
    GetPage<Widget>(name: register, page: () => const RegisterScreen()),
    GetPage<Widget>(name: splash, page: () => const SplashScreen()),
    GetPage<Widget>(name: productDetails, page: () => const ProductDetails()),
    GetPage<Widget>(name: addProduct, page: () => const AddProductScreen()),
    GetPage<Widget>(name: eventDetails, page: () => const EventDetail()),
    GetPage<Widget>(name: addEvent, page: () => const AddEventScreen()),
    GetPage<Widget>(name: orderDetails, page: () => const OrderDetail()),
  ];
}
