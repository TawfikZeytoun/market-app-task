import 'package:market_app/core/networking/api_error_handler.dart';
import 'package:market_app/core/networking/api_result.dart';
import 'package:market_app/core/networking/api_service.dart';
import 'package:market_app/features/products/data/models/product_model.dart';

class ProductsRepo {
  final ApiService _apiService;
  ProductsRepo(this._apiService);

  Future<ApiResult<List<ProductModel>>> getAllProducts() async {
    try {
      final response = await _apiService.getAllProducts();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
