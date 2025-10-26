import 'package:market_app/core/networking/api_error_handler.dart';
import 'package:market_app/core/networking/api_result.dart';
import 'package:market_app/core/networking/api_service.dart';
import 'package:market_app/features/products/data/models/product_model.dart';

class ProductDetailsRepo {
  final ApiService _apiService;
  ProductDetailsRepo(this._apiService);

  Future<ApiResult<ProductModel>> getProductById(int id) async {
    try {
      final response = await _apiService.getProductById(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
