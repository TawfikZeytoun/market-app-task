
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/core/di/dependency_injection.dart';
import 'package:market_app/core/routing/routes.dart';
import 'package:market_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:market_app/features/cart/ui/cart_screen.dart';
import 'package:market_app/features/login/logic/cubit/login_cubit.dart';
import 'package:market_app/features/login/ui/login_screen.dart';
import 'package:market_app/features/product_details/logic/cubit/product_details_cubit.dart';
import 'package:market_app/features/product_details/ui/product_details_screen.dart';
import 'package:market_app/features/products/logic/cubit/products_cubit.dart';
import 'package:market_app/features/products/ui/products_screen.dart';
import 'package:market_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:market_app/features/profile/ui/profile_screen.dart';
import 'package:market_app/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:market_app/features/sign_up/ui/sign_up_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings){
    final arguments=settings.arguments;
switch(settings.name){
 case(Routes.loginScreen):
 return MaterialPageRoute(builder: (_)=>BlocProvider(
  create: (BuildContext context)=>getIt<LoginCubit>(),
  child: LoginScreen()
  )
  );
   case(Routes.signupScreen):
 return MaterialPageRoute(builder: (_)=>BlocProvider(
  create: (BuildContext context)=>getIt<SignUpCubit>(),
  child: SignupScreen()
  )
  );

   case (Routes.productsScreen):
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                getIt<ProductsCubit>()..getProducts(),
            child: const ProductsScreen(),
          ),
        );
        case (Routes.productDetailsScreen):
  final productId = arguments as int;
  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (context) => getIt<ProductDetailsCubit>()..fetchProductDetails(productId),
      child: ProductDetailsScreen(productId: productId),
    ),
  );
  case Routes.cartScreen:
 return MaterialPageRoute(
    builder: (_) => BlocProvider<CartCubit>.value(
      value: getIt<CartCubit>()..loadCart(),
      child: CartScreen(),
    ),
  );
 case Routes.profileScreen:
  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => getIt<ProfileCubit>(),
      child: const ProfileScreen(),
    ),
  );
   default:
  return MaterialPageRoute(builder: (_)=>Scaffold(
  body: Center(
    child: Text("No Route defined for ${settings.name}"),
  ),
  ));
}
  }
}