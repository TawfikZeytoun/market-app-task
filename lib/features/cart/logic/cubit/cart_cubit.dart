import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/features/cart/data/models/cart_item_model.dart';
import 'package:market_app/features/cart/data/models/cart_model.dart';
import 'package:market_app/features/cart/data/repos/cart_repo.dart';
import 'package:market_app/features/cart/logic/cubit/cart_state.dart';
import 'package:market_app/features/products/data/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;
  final String _username;
  List<CartItemModel> cartItems = [];

  CartCubit(this._cartRepo, this._username) : super(const CartState.initial()) {
    loadCart();
  }

  void loadCart() async {
    emit(const CartState.loading());
    final saved = await _cartRepo.getCart(_username);
    cartItems = saved?.items ?? [];
    emit(CartState.success(List.from(cartItems)));
  }

  void addToCart(ProductModel product) {
    final i = cartItems.indexWhere((e) => e.product.id == product.id);
    if (i >= 0) {
      cartItems[i] = cartItems[i].copyWith(quantity: cartItems[i].quantity + 1);
    } else {
      cartItems.add(CartItemModel(product: product, quantity: 1));
    }
    _save();
  }

  void removeFromCart(ProductModel product) {
    final i = cartItems.indexWhere((e) => e.product.id == product.id);
    if (i == -1) return;
    if (cartItems[i].quantity > 1) {
      cartItems[i] = cartItems[i].copyWith(quantity: cartItems[i].quantity - 1);
    } else {
      cartItems.removeAt(i);
    }
    _save();
  }

  void deleteItem(ProductModel product) {
    cartItems.removeWhere((e) => e.product.id == product.id);
    _save();
  }

  void clearCart() async {
    cartItems.clear();

    await _cartRepo.saveCart(CartModel(items: []), _username);

    emit(const CartState.success([]));
  }

  void _save() async {
    await _cartRepo.saveCart(CartModel(items: cartItems), _username);
    emit(CartState.success(List.from(cartItems)));
  }
}
