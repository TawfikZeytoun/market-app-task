import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_app/core/helpers/extensions.dart';
import 'package:market_app/core/helpers/spacing.dart';
import 'package:market_app/core/theme/colors.dart';
import 'package:market_app/core/theme/styles.dart';
import 'package:market_app/core/widgets/app_text_button.dart';
import 'package:market_app/features/cart/data/models/cart_item_model.dart';
import 'package:market_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:market_app/features/cart/logic/cubit/cart_state.dart';
import 'package:market_app/features/cart/ui/widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<CartItemModel> _items = [];

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart", style: TextStyles.font24BlueBold),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: ColorsManager.mainBlue),
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is Success) {
            final newItems = state.items;

            if (newItems.isEmpty) {
              final current = _items.length;
              for (int i = current - 1; i >= 0; i--) {
                _listKey.currentState?.removeItem(
                  i,
                  (_, animation) => SizeTransition(sizeFactor: animation),
                  duration: const Duration(milliseconds: 200),
                );
              }
              _items.clear();
            } else {
              final newItems = state.items;
              final oldItems = _items;
              _items = List.from(newItems);

              for (int i = oldItems.length; i < newItems.length; i++) {
                _listKey.currentState?.insertItem(
                  i,
                  duration: const Duration(milliseconds: 300),
                );
              }

              for (int i = oldItems.length - 1; i >= newItems.length; i--) {
                _listKey.currentState?.removeItem(
                  i,
                  (context, animation) => SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: CartItemTile(item: oldItems[i]),
                  ),
                  duration: const Duration(milliseconds: 600),
                );
              }
            }
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
                child:
                    CircularProgressIndicator(color: ColorsManager.mainBlue));
          } else if (state is Success) {
            final items = state.items;
            if (items.isEmpty) {
              return Center(
                  child: Text("Cart is empty",
                      style: TextStyles.font15DarkBlueMedium));
            }
            return Column(
              children: [
                Expanded(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: items.length,
                    itemBuilder: (context, index, animation) {
                      final item = items[index];
                      return SlideTransition(
                        position: animation.drive(
                          Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: CartItemTile(
                          key: ValueKey(item.product.id),
                          item: item,
                        ),
                      );
                    },
                  ),
                ),
                verticalSpace(16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity).toStringAsFixed(2)}',
                        style: TextStyles.font15DarkBlueMedium
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 150.w,
                        child: AppTextButton(
                          buttonText: 'Clear Cart',
                          textStyle: TextStyles.font16WhiteSemiBold,
                          onPressed: () {
                            _clearCartWithAnimation(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(16),
              ],
            );
          } else if (state is Error) {
            return Center(
                child: Text(state.message,
                    style: TextStyles.font15DarkBlueMedium));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _clearCartWithAnimation(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final currentItems = List<CartItemModel>.from(_items);

    for (int i = currentItems.length - 1; i >= 0; i--) {
      Future.delayed(
          Duration(milliseconds: 200 * (currentItems.length - 1 - i)), () {
        if (_listKey.currentState != null && i < _items.length) {
          final removedItem = _items[i];
          _items.removeAt(i);
          _listKey.currentState?.removeItem(
            i,
            (context, animation) => SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1, 0),
                ).chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: CartItemTile(item: removedItem),
            ),
            duration: const Duration(milliseconds: 600),
          );
        }
      });
    }

    Future.delayed(Duration(milliseconds: 200 * currentItems.length + 600), () {
      cubit.clearCart();
    });
  }
}
