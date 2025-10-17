import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_state.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/popups/full_screen_loader.dart';
import 'package:cwt_starter_template/utils/popups/loaders.dart';
import 'package:cwt_starter_template/utils/validators/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReauthLoginForm extends StatefulWidget {
  const ReauthLoginForm({super.key});

  @override
  State<ReauthLoginForm> createState() => _ReauthLoginFormState();
}

class _ReauthLoginFormState extends State<ReauthLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _email = FirebaseAuth.instance.currentUser?.email ?? '';

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          TFullScreenLoader.openLoadingDialog(
            context,
            'Processing...',
            TImages.docerAnimation,
          );
        } else if (state is UserDeleteSuccess) {
          // The global AuthCubit will handle navigation, so just stop the loader.
          TFullScreenLoader.stopLoading(context);
        } else if (state is UserFailure) {
          TFullScreenLoader.stopLoading(context);
          TLoaders.errorSnackBar(
            context: context,
            title: 'Oh Snap!',
            message: state.error,
          );
        }
      },
      child: Scaffold(
        appBar: TAppBar(
          title: const Text('Re-Authenticate'),
          showBackArrow: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'To delete your account, please enter your password to confirm.',
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator:
                      (value) =>
                          TValidator.validateEmptyText('Password', value),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<UserCubit>().reauthenticateAndDelete(
                          _email,
                          _passwordController.text.trim(),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Confirm & Delete'),
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
