import 'package:dio/dio.dart';
import 'package:market_app/core/networking/api_constants.dart';
import 'package:market_app/features/cart/data/models/cart_model.dart';
import 'package:market_app/features/login/data/models/login_request_body.dart';
import 'package:market_app/features/login/data/models/login_response.dart';
import 'package:market_app/features/products/data/models/product_model.dart';
import 'package:market_app/features/profile/data/models/user_model.dart';
import 'package:market_app/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:market_app/features/sign_up/data/models/sign_up_response.dart';

import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);
  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(@Body() SignupRequestBody signUpRequestBody);
  @GET(ApiConstants.getAllProducts)
  Future<List<ProductModel>> getAllProducts();

  @GET(ApiConstants.getProductById + '/{id}')
  Future<ProductModel> getProductById(@Path('id') int id);

  @GET('users')
  Future<List<UserModel>> getAllUsers();

  @GET('users/{id}')
  Future<UserModel> getUserById(@Path('id') int id);

  @GET('carts/user/{userId}')
Future<List<CartModel>> getUserCarts(@Path('userId') int userId);
}
