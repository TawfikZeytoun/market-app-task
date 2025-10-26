import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:market_app/features/products/data/models/product_model.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = Loading;
  const factory ProductsState.success(List<ProductModel> products) = Success;
  const factory ProductsState.error(String error) = Error;
}
