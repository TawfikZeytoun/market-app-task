import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/core/helpers/extensions.dart';
import 'package:market_app/core/routing/routes.dart';
import 'package:market_app/core/theme/colors.dart';
import 'package:market_app/core/theme/styles.dart';
import 'package:market_app/features/login/logic/cubit/login_cubit.dart';
import 'package:market_app/features/login/logic/cubit/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous,current)=>current is Loading|| current is Success || current is Error,
      listener: (context, state) {
        if(state is Loading){
          showDialog(context: context, builder:(context)=>Center(
            child: CircularProgressIndicator(
              color: ColorsManager.mainBlue,
            ),
          ));
        }else if(state is Success){
          context.pop();
          context.pushNamed(Routes.productsScreen);
        }else if(state is Error){
          setupErrorState(context, state.error);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  
  void setupErrorState(BuildContext context,String error){
context.pop();
          showDialog(context: context, builder:(context)=>AlertDialog(
            icon: Icon(
              Icons.error,
              color: Colors.red,
              size: 32,
            ),
            content: Text(
              error,
              style: TextStyles.font15DarkBlueMedium,
            ),
            actions: [
              TextButton(onPressed: (){
                context.pop();
              }, child: Text(
                "Got it",
                style: TextStyles.font14BlueSemiBold,
              ))
            ],
          ));
        }
}
