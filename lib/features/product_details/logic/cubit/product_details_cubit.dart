import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/core/networking/api_result.dart' as api;
import 'package:market_app/features/product_details/data/repos/product_details_repo.dart';
import 'package:market_app/features/product_details/logic/cubit/product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo _productDetailsRepo;

  ProductDetailsCubit(this._productDetailsRepo)
      : super(const ProductDetailsState.initial());

  void fetchProductDetails(int id) async {
    emit(const ProductDetailsState.loading());
    final response = await _productDetailsRepo.getProductById(id);
    switch (response) {
      case api.Success(data: final product):
        emit(ProductDetailsState.success(product));
      case api.Failure(errorHandler: final error):
        emit(ProductDetailsState.error(
            error.apiErrorModel.message ?? 'Error fetching product details'));
    }
  }
}
