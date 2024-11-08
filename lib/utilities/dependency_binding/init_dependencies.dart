import 'package:get/get.dart';
import 'package:test_project/controller/product_controller.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController());
  }
}
