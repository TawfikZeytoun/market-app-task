import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:market_app/core/networking/api_service.dart';
import 'package:market_app/core/networking/dio_factory.dart';
import 'package:market_app/features/cart/data/repos/cart_repo.dart';
import 'package:market_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:market_app/features/login/data/repos/login_repo.dart';
import 'package:market_app/features/login/logic/cubit/login_cubit.dart';
import 'package:market_app/features/product_details/data/repos/product_details_repo.dart';
import 'package:market_app/features/product_details/logic/cubit/product_details_cubit.dart';
import 'package:market_app/features/products/data/repos/products_repo.dart';
import 'package:market_app/features/products/logic/cubit/products_cubit.dart';
import 'package:market_app/features/profile/data/repos/profile_repo.dart';
import 'package:market_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:market_app/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:market_app/features/sign_up/logic/cubit/sign_up_cubit.dart';
final getIt=GetIt.instance;
Future<void> setupGetIt(String username)async{
//Dio & apiService
Dio dio=DioFactory.getDio();
getIt.registerLazySingleton<ApiService>(()=>ApiService(dio));

//login
getIt.registerLazySingleton<LoginRepo>(()=>LoginRepo(getIt()));
getIt.registerFactory<LoginCubit>(()=>LoginCubit(getIt()));

//signup
getIt.registerLazySingleton<SignupRepo>(()=>SignupRepo(getIt()));
getIt.registerFactory<SignUpCubit>(()=>SignUpCubit(getIt()));

// products
getIt.registerLazySingleton<ProductsRepo>(() => ProductsRepo(getIt()));
getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));

// ProductDetails
getIt.registerLazySingleton<ProductDetailsRepo>(() => ProductDetailsRepo(getIt()));
getIt.registerFactory<ProductDetailsCubit>(() => ProductDetailsCubit(getIt()));



 // Profile 
getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<ProfileRepo>()));

  // Cart
  getIt.registerLazySingleton<CartRepo>(() => CartRepo());
getIt.registerLazySingleton<CartCubit>(() => CartCubit(getIt<CartRepo>(), username));
}