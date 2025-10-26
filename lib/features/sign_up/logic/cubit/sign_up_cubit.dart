import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/core/helpers/locale_storage.dart';
import 'package:market_app/core/networking/api_result.dart' as api;
import 'package:market_app/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:market_app/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:market_app/features/sign_up/logic/cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  SignUpCubit(this._signupRepo) : super(SignupState.initial());
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  void emitSignupStates() async {
    emit(SignupState.signupLoading());
    final response = await _signupRepo.signup(SignupRequestBody(
      username: userNameController.text,
      email: emailController.text,
      password: passwordController.text,
    ));
    switch (response) {
      case api.Success(data: final signupResponse):
        await LocalStorage.clearCartForUser(userNameController.text);
        await LocalStorage.saveUserCredentials(
            userNameController.text, '', signupResponse.id);

        emit(SignupState.signupSuccess(signupResponse));
      case api.Failure(errorHandler: final error):
        emit(SignupState.signupError(error: error.apiErrorModel.message ?? ''));
    }
  }
}
