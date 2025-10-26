import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/core/helpers/locale_storage.dart';
import 'package:market_app/core/networking/api_result.dart' as api;
import 'package:market_app/features/login/data/models/login_request_body.dart';
import 'package:market_app/features/login/data/repos/login_repo.dart';
import 'package:market_app/features/login/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginState.initial());
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(LoginRequestBody(
        username: userNameController.text, password: passwordController.text));

    switch (response) {
      case api.Success(data: final loginResponse):
        await LocalStorage.saveUserCredentials(
            userNameController.text, loginResponse.token);
        emit(LoginState.success(loginResponse));
      case api.Failure(errorHandler: final error):
        emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    }
  }
}
