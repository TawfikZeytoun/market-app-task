import 'package:elegant_notification/resources/arrays.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_app/core/helpers/extensions.dart';
import 'package:market_app/core/routing/routes.dart';
import 'package:market_app/core/theme/colors.dart';
import 'package:market_app/core/theme/styles.dart';
import 'package:market_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:market_app/features/product_details/logic/cubit/product_details_cubit.dart';
import 'package:market_app/features/product_details/logic/cubit/product_details_state.dart';
import 'package:market_app/features/products/data/models/product_model.dart';
import 'package:elegant_notification/elegant_notification.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.moreLightGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: ColorsManager.mainBlue),
        title: Text("Product Details",
            style: TextStyles.font16WhiteMedium
                .copyWith(color: ColorsManager.darkBlue)),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(Routes.cartScreen);
            },
            icon: const Icon(Icons.shopping_cart_outlined,
                color: ColorsManager.mainBlue),
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Success) {
            final product = state.product;
            return _buildDetails(context, product);
          } else if (state is Error) {
            return Center(child: Text(state.error));
          }
          context.read<ProductDetailsCubit>().fetchProductDetails(productId);
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDetails(BuildContext context, ProductModel product) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          Hero(
            tag: 'product-image-${product.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                product.image,
                height: 220.h,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(product.title,
              style: TextStyles.font24BlueBold,
              maxLines: 2,
              textAlign: TextAlign.center),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 22.sp),
              SizedBox(width: 4.w),
              Text("${product.rating.rate} (${product.rating.count} reviews)",
                  style: TextStyles.font14GreyRegular),
            ],
          ),
          SizedBox(height: 8.h),
          Text("\$${product.price}",
              style: TextStyles.font24BlackBold
                  .copyWith(color: ColorsManager.mainBlue)),
          SizedBox(height: 16.h),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                product.description,
                style: TextStyles.font14DarkBlueMedium,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          ElevatedButton.icon(
            onPressed: () {
              context.read<CartCubit>().addToCart(product);

              ElegantNotification.success(
                title: const Text("Added to cart"),
                description: const Text("Added successfully"),
                animation: AnimationType.fromTop,
                position: Alignment.topCenter,
                stackedOptions: StackedOptions(
                  type: StackedType.same,
                  key: 'top',
                  itemOffset: const Offset(0, -5),
                ),
                autoDismiss: true,
                isDismissable: true,
                showProgressIndicator: false,
              ).show(context);
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: Text("Add to Cart", style: TextStyles.font16WhiteSemiBold),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              minimumSize: Size(double.infinity, 52.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
        ],
      ),
    );
  }
}
