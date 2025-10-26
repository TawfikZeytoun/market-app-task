import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:market_app/features/cart/data/models/cart_item_model.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.loading() = Loading;
  const factory CartState.success(List<CartItemModel> items) = Success;
  const factory CartState.error(String message) = Error;
}
