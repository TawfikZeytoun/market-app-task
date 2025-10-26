import 'package:market_app/core/helpers/locale_storage.dart';
import 'package:market_app/features/cart/data/models/cart_model.dart';

class CartRepo {
  Future<void> saveCart(CartModel cart, String username) =>
      LocalStorage.saveCartForUser(cart, username);

  Future<CartModel?> getCart(String username) =>
      LocalStorage.getCartForUser(username);

  Future<void> clearCart(String username) async {
    await LocalStorage.saveCartForUser(CartModel(items: []), username);
  }
}
