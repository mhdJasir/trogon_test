import 'package:get/get.dart';
import 'package:test_project/model/product_model.dart';
import 'package:test_project/repository/product_repository.dart';
import 'package:test_project/utilities/exceptions/server_error_exception.dart';

class ProductController extends GetxController {
  final _productRepo = ProductRepository();
  List<ProductModel> products = [];

  List<ProductModel> get topRated =>
      products.where((e) => e.rating >= 4.7).toList();

  List<ProductModel> get trending {
    if (products.length > 5) return products.sublist(0, 6);
    return products;
  }

  bool isGettingProducts = false;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  getProducts() async {
    try {
      isGettingProducts = true;
      update();
      products = await _productRepo.getProducts();
      isGettingProducts = false;
      update();
    } on Exception catch (e) {
      if (e is ServerError) Get.showSnackbar(GetSnackBar(message: e.message));
    }
  }
}
