import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:market_app/core/helpers/extensions.dart';
import 'package:market_app/core/routing/routes.dart';
import 'package:market_app/core/theme/colors.dart';
import 'package:market_app/core/theme/styles.dart';
import 'package:market_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:market_app/features/products/logic/cubit/products_cubit.dart';
import 'package:market_app/features/products/logic/cubit/products_state.dart';
import 'package:market_app/features/products/ui/widgets/product_card.dart';
import 'package:market_app/features/products/ui/widgets/search_field.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String query = "";

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
      child: Scaffold(
        backgroundColor: ColorsManager.moreLightGrey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Products",
            style: TextStyles.font24BlueBold,
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.profileScreen);
              },
              icon: const Icon(
                Icons.person,
                color: ColorsManager.mainBlue,
              ),
            ),
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.cartScreen);
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: ColorsManager.mainBlue,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            children: [
              CustomSearchField(
                onChanged: (value) {
                  setState(() {
                    query = value.toLowerCase();
                  });
                },
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.mainBlue,
                        ),
                      );
                    } else if (state is Success) {
                      final products = state.products
                          .where((p) => p.title.toLowerCase().contains(query))
                          .toList();

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                Routes.productDetailsScreen,
                                arguments: product.id,
                              );
                            },
                            child: Hero(
                              tag: 'product-image-${product.id}',
                              child: ProductCard(
                                product: product,
                                onAddToCart: () {
                                  context.read<CartCubit>().addToCart(product);

                                  ElegantNotification.success(
                                    title: const Text("Added to cart"),
                                    description:
                                        const Text("Added successfully"),
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
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is Error) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
