import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/di/injection_container.dart';
import 'package:cwt_starter_template/features/authentication/cubit/forgetPassword/forget_password_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/forgetPassword/forget_password_state.dart';
import 'package:cwt_starter_template/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:cwt_starter_template/utils/popups/full_screen_loader.dart';
import 'package:cwt_starter_template/utils/popups/loaders.dart';
import 'package:cwt_starter_template/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state.status == ForgetPasswordStatus.loading) {
          TFullScreenLoader.openLoadingDialog(
            context,
            'Logging you in...',
            TImages.docerAnimation,
          );
        } else if (state.status == ForgetPasswordStatus.failure) {
          TFullScreenLoader.stopLoading(context);
          TLoaders.errorSnackBar(
            context: context,
            title: 'Oh Snap!',
            message: state.errorMessage!,
          );
        } else if (state.status == ForgetPasswordStatus.sent) {
          TFullScreenLoader.stopLoading(context);
          TLoaders.successSnackBar(
            context: context,
            title: 'Email Sent',
            message: 'Check your inbox for a password reset link.',
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => sl<ForgetPasswordCubit>(),
                child: ResetPasswordScreen(email: _emailController.text),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forget password',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  "Don't worry somtetimes people can forget their passwrord, enter your email and a reset password link will be sent to you.",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections * 2),
                TextFormField(
                  controller: _emailController,
                  validator: (value) => TValidator.validateEmail(value),
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<ForgetPasswordCubit>()
                            .sendPasswordResetEmail(_emailController.text);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
