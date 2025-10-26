import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/core/networking/api_result.dart' as api;
import 'package:market_app/features/products/data/repos/products_repo.dart';
import 'package:market_app/features/products/logic/cubit/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _productsRepo;
  ProductsCubit(this._productsRepo) : super(const ProductsState.initial());

  void getProducts() async {
    emit(const ProductsState.loading());
    final response = await _productsRepo.getAllProducts();

    switch (response) {
      case api.Success(data: final products):
        emit(ProductsState.success(products));
      case api.Failure(errorHandler: final error):
        emit(ProductsState.error(
            error.apiErrorModel.message ?? 'Error fetching products'));
    }
  }
}
