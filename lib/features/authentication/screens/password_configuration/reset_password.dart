import 'package:cwt_starter_template/features/authentication/cubit/forgetPassword/forget_password_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/forgetPassword/forget_password_state.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/device/device_utility.dart';
import 'package:cwt_starter_template/utils/popups/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state.status == ForgetPasswordStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        } else if (state.status == ForgetPasswordStatus.failure) {
          TLoaders.errorSnackBar(
            context: context,
            title: state.errorMessage ?? 'Something went wrong, try agian',
          );
        } else if (state.status == ForgetPasswordStatus.sent) {
          TLoaders.successSnackBar(
            context: context,
            title: 'The reset password mail has been sent to your mail address',
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                image: AssetImage(
                  "assets/images/animations/sammy-line-man-receives-a-mail.png",
                ),
                width: TDeviceUtils.getScreenWidth(context) * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Password Reset Email Sent',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(
                "Your account security is our Priority! We've sent you a Secure Link to Safely Change Your Password and Keep Your Account Protected",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      ),
                  child: Text('Done'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed:
                      () => context
                          .read<ForgetPasswordCubit>()
                          .sendPasswordResetEmail(email),
                  child: Text('Resend Email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
