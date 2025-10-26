import 'package:market_app/core/helpers/locale_storage.dart';
import 'package:market_app/core/networking/api_error_handler.dart';
import 'package:market_app/core/networking/api_result.dart';
import 'package:market_app/core/networking/api_service.dart';
import 'package:market_app/features/profile/data/models/user_model.dart';

class ProfileRepo {
  final ApiService _apiService;
  ProfileRepo(this._apiService);

  Future<ApiResult<UserModel>> getUserProfile() async {
    try {
      final userId = await LocalStorage.getUserId();
      if (userId != null) {
        final user = await _apiService.getUserById(userId);
        return ApiResult.success(user);
      } else {
        final username = await LocalStorage.getUsername();
        if (username == null) throw Exception('No user data available');
        final allUsers = await _apiService.getAllUsers();
        final user = allUsers.firstWhere((u) => u.username == username,
            orElse: () => throw Exception('User not found'));
        return ApiResult.success(user);
      }
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
