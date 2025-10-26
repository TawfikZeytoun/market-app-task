import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:market_app/features/products/data/models/product_model.dart';

part 'product_details_state.freezed.dart';

@freezed
class ProductDetailsState with _$ProductDetailsState {
  const factory ProductDetailsState.initial() = _Initial;
  const factory ProductDetailsState.loading() = Loading;
  const factory ProductDetailsState.success(ProductModel product) = Success;
  const factory ProductDetailsState.error(String error) = Error;
}
