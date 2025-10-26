import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_app/features/cart/data/models/cart_item_model.dart';
import 'package:market_app/features/cart/logic/cubit/cart_cubit.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return Card(
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.5),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Row(
          children: [
            SizedBox(
              width: 60.w,
              height: 60.h,
              child: Image.network(item.product.image, fit: BoxFit.contain),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp)),
                  Text('\$${item.product.price}',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _AnimatedIconButton(
                  icon: Icons.remove,
                  onPressed: () => cubit.removeFromCart(item.product),
                ),
                SizedBox(width: 8.w),
                Text('${item.quantity}', style: TextStyle(fontSize: 16.sp)),
                SizedBox(width: 8.w),
                _AnimatedIconButton(
                  icon: Icons.add,
                  onPressed: () => cubit.addToCart(item.product),
                ),
                SizedBox(width: 12.w),
                _AnimatedIconButton(
                  icon: Icons.delete,
                  color: Colors.red,
                  onPressed: () => cubit.deleteItem(item.product),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedIconButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  const _AnimatedIconButton({
    required this.icon,
    this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: (color ?? Colors.blue).withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22.r, color: color ?? Colors.blue),
        ),
      ),
    );
  }
}
