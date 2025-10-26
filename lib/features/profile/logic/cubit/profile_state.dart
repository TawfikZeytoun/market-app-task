import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:market_app/features/profile/data/models/user_model.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = Loading;
  const factory ProfileState.success(UserModel user) = Success;
  const factory ProfileState.error({required String error}) = Error;
  const factory ProfileState.logoutLoading() = LogoutLoading;
  const factory ProfileState.logoutSuccess() = LogoutSuccess;
  const factory ProfileState.logoutError({required String error}) = LogoutError;
}
