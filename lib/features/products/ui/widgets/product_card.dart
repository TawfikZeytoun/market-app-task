import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_app/core/theme/colors.dart';
import 'package:market_app/core/theme/styles.dart';
import 'package:market_app/features/products/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onAddToCart;
  const ProductCard({super.key, required this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.moreLightGrey,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                product.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.font14DarkBlueMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price}",
                style: TextStyles.font14DarkBlueMedium,
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart,
                    color: ColorsManager.mainBlue, size: 20),
                onPressed: onAddToCart,
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16.sp),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  '${product.rating.rate.toStringAsFixed(1)} (${product.rating.count} reviews)',
                  style: TextStyles.font13GreyRegular
                      .copyWith(color: ColorsManager.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
