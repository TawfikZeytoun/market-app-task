import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_app/core/di/dependency_injection.dart';
import 'package:market_app/core/helpers/locale_storage.dart';
import 'package:market_app/core/routing/app_router.dart';
import 'package:market_app/core/routing/routes.dart';
import 'package:market_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:market_app/market_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  final username = await LocalStorage.getUsername() ?? 'guest';
  await setupGetIt(username);

  final initialRoute =
      username != 'guest' ? Routes.productsScreen : Routes.loginScreen;

  runApp(
    BlocProvider<CartCubit>(
      create: (_) => getIt<CartCubit>(),
      child: MarketApp(appRouter: AppRouter(), initialRoute: initialRoute),
    ),
  );
}
