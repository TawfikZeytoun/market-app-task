import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_app/core/helpers/spacing.dart';
import 'package:market_app/core/theme/colors.dart';
import 'package:market_app/core/theme/styles.dart';
import 'package:market_app/core/widgets/app_text_button.dart';
import 'package:market_app/core/routing/routes.dart';
import 'package:market_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:market_app/features/profile/logic/cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().fetchProfile();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Profile', style: TextStyles.font24BlueBold),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is LogoutLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: ColorsManager.mainBlue),
              ),
            );
          } else if (state is LogoutSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, Routes.loginScreen);
          } else if (state is LogoutError) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.error),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK')),
                ],
              ),
            );
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                  child:
                      CircularProgressIndicator(color: ColorsManager.mainBlue));
            } else if (state is Success) {
              final user = state.user;
              return AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Username:  ',
                                style: TextStyles.font14BlueSemiBold),
                            TextSpan(
                                text: user.username,
                                style: TextStyles.font15DarkBlueMedium),
                          ]),
                        ),
                        verticalSpace(20),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Email: ',
                                style: TextStyles.font14BlueSemiBold),
                            TextSpan(
                                text: user.email,
                                style: TextStyles.font15DarkBlueMedium),
                          ]),
                        ),
                        verticalSpace(20),
                        AppTextButton(
                          buttonText: 'Logout',
                          textStyle: TextStyles.font16WhiteSemiBold,
                          onPressed: () {
                            context.read<ProfileCubit>().logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is Error) {
              return Center(
                  child: Text(state.error,
                      style: TextStyles.font15DarkBlueMedium));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
