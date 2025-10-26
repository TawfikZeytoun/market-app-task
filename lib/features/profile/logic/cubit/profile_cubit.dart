import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:market_app/core/helpers/locale_storage.dart';
import 'package:market_app/core/networking/api_result.dart' as api;
import 'package:market_app/features/cart/data/repos/cart_repo.dart';
import 'package:market_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:market_app/features/profile/data/repos/profile_repo.dart';
import 'package:market_app/features/profile/logic/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  ProfileCubit(this._profileRepo) : super(ProfileState.initial());

  void fetchProfile() async {
    emit(ProfileState.loading());
    final username = await LocalStorage.getUsername();
    if (username == null) {
      emit(ProfileState.error(error: 'No user logged in'));
      return;
    }
    final response = await _profileRepo.getUserProfile();
    switch (response) {
      case api.Success(data: final user):
        emit(ProfileState.success(user));
      case api.Failure(errorHandler: final error):
        emit(ProfileState.error(
            error: error.apiErrorModel.message ?? 'Unknown error'));
    }
  }

  void logout() async {
    emit(ProfileState.logoutLoading());
    try {
      final username = await LocalStorage.getUsername();
      if (username != null) {
        final cartRepo = CartRepo();
        await cartRepo.clearCart(username);

        if (GetIt.I.isRegistered<CartCubit>()) {
          final cartCubit = GetIt.I<CartCubit>();
          cartCubit.clearCart();
        }
      }

      await LocalStorage.clearUserCredentials();

      emit(ProfileState.logoutSuccess());
    } catch (e) {
      emit(ProfileState.logoutError(error: 'Failed to logout: $e'));
    }
  }
}
