import 'package:flutter/material.dart';
import 'package:market_app/core/helpers/spacing.dart';
import 'package:market_app/core/theme/colors.dart';
import 'package:market_app/core/theme/styles.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
 
  final bool hasSpecialCharacters;
  final bool hasNumber;
 
  const PasswordValidations(
      {super.key,
      required this.hasLowerCase,
      required this.hasSpecialCharacters,
      required this.hasNumber,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow("At least 1 lowercase letter", hasLowerCase),
        verticalSpace(2),
        buildValidationRow("At least 1 special character", hasSpecialCharacters),
        verticalSpace(2),
        buildValidationRow("At least 1 number", hasNumber),
       
      
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        CircleAvatar(
          radius: 2.5,
          backgroundColor: ColorsManager.grey,
        ),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyles.font13DarkBlueRegular.copyWith(
            decoration:hasValidated? TextDecoration.lineThrough:null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated? ColorsManager.grey:ColorsManager.darkBlue
          ),
        ),
      ],
    );
  }
}
