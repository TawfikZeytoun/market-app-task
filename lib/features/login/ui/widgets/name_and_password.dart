import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/core/helpers/app_regex.dart';
import 'package:market_app/core/helpers/spacing.dart';
import 'package:market_app/core/widgets/app_text_form_field.dart';
import 'package:market_app/features/login/logic/cubit/login_cubit.dart';
import 'package:market_app/features/login/ui/widgets/password_validations.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmialAndPasswordState();
}

class _EmialAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialCharacters = false;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    passwordController = context.read<LoginCubit>().passwordController;
    setupPasswordControllerListener();
  }
 void setupPasswordControllerListener(){
  passwordController.addListener((){
   setState((){
    hasLowerCase=AppRegex.hasLowerCase(passwordController.text);
    hasSpecialCharacters=AppRegex.hasSpecialCharacter(passwordController.text);
    hasNumber=AppRegex.hasNumber(passwordController.text);
   });
  });
 }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'UserName',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
            },
            controller: context.read<LoginCubit>().userNameController,
          ),
          verticalSpace(18),
          AppTextFormField(
            controller: context.read<LoginCubit>().passwordController,
            hintText: 'Password',
            isObscureText: isObscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              child:
                  Icon(isObscureText ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          verticalSpace(24),
          PasswordValidations(
            hasLowerCase: hasLowerCase,
            hasSpecialCharacters: hasSpecialCharacters,
            hasNumber: hasNumber
          ),
        ],
      ),
    );
  }
  @override
   void dispose(){
    passwordController.dispose();
    super.dispose();
   }
}
