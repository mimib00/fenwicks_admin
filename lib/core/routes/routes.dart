import 'package:fenwicks_admin/views/auth/login.dart';
import 'package:fenwicks_admin/views/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';

  static List<GetPage<dynamic>> routes = [
    GetPage<Widget>(name: home, page: () => const Scaffold()),
    GetPage<Widget>(name: login, page: () => const LoginScreen()),
    GetPage<Widget>(name: register, page: () => const RegisterScreen()),
  ];
}
