import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/core/helpers/extensions.dart';
import 'package:market_app/core/routing/routes.dart';
import 'package:market_app/core/theme/colors.dart';
import 'package:market_app/core/theme/styles.dart';
import 'package:market_app/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:market_app/features/sign_up/logic/cubit/sign_up_state.dart';

class SignupBlocListener extends StatelessWidget {
  const SignupBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignupState>(
      listenWhen: (previous, current) =>
          current is SignupLoading ||
          current is SignupSuccess ||
          current is SignupError,
      listener: (context, state) {
        if (state is SignupLoading) {
          showDialog(
              context: context,
              builder: (context) => Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.mainBlue,
                    ),
                  ));
        } else if (state is SignupSuccess) {
          context.pop();
          showSuccessDialog(context);
        } else if (state is SignupError) {
          setupErrorState(context, state.error);
        }
      },
      child: SizedBox.shrink(),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Signup Successful'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Congratulations , you have signed up")
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  context.pushNamed(Routes.productsScreen);
                },
                child: Text("Continue"),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    surfaceTintColor: Colors.grey,
                    foregroundColor: Colors.white),
              ),
            ],
          );
        });
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              icon: Icon(
                Icons.error,
                color: Colors.red,
                size: 32,
              ),
              content: Text(
                error,
                style: TextStyles.font15DarkBlueMedium,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    'Got it',
                    style: TextStyles.font14BlueSemiBold,
                  ),
                ),
              ],
            ));
  }
}
