import 'package:fenwicks_admin/views/events/controller/events_controller.dart';
import 'package:fenwicks_admin/views/notifications/controller/notification_controller.dart';
import 'package:fenwicks_admin/views/orders/controller/order_controller.dart';
import 'package:fenwicks_admin/views/products/controller/products_controll.dart';
import 'package:fenwicks_admin/views/users/controllers/users_controller.dart';
import 'package:get/get.dart';

class RootBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
    Get.lazyPut(() => UsersController());
    Get.lazyPut(() => EventsController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => NotificationController());
  }
}
