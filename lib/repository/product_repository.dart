import 'package:test_project/model/product_model.dart';
import 'package:test_project/utilities/constants.dart';
import 'package:test_project/utilities/exceptions/server_error_exception.dart';
import 'package:test_project/utilities/network_helper/api_endpoints.dart';
import 'package:test_project/utilities/network_helper/api_helper.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    try {
      final jsonData = await ApiHelper.getApi(
        path: ApiEndPoints.products,
      );
      if (jsonData == null) throw ServerError(Constants.serverError);
      if (jsonData is! List || jsonData.isEmpty) return [];
      return jsonData.map((e) => ProductModel.fromJson(e)).toList();
    } on Exception catch (_) {
      throw ServerError(Constants.serverError);
    }
  }
}
