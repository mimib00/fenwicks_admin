import 'package:fenwicks_admin/views/products/controller/products_controll.dart';
import 'package:fenwicks_admin/views/users/controllers/users_controller.dart';
import 'package:get/get.dart';

class RootBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
    Get.lazyPut(() => UsersController());
  }
}
