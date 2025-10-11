import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/signup/signup_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/signup/signup_state.dart';
import 'package:cwt_starter_template/features/authentication/screens/signup/verify_email.dart';
import 'package:cwt_starter_template/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:cwt_starter_template/utils/popups/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create:
            (context) => SignupCubit(
              networkCubit: context.read<NetworkCubit>(),
              authRepository: context.read<AuthenticationRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
        child: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status == FormStatus.loading) {
              // Show the loading dialog when the state is loading
              TFullScreenLoader.openLoadingDialog(
                context,
                'We are processing your information...',
                TImages.docerAnimation,
              ); // Replace with your animation
            } else if (state.status == FormStatus.success ||
                state.status == FormStatus.failure) {
              // Stop the loading dialog when the process is complete (either success or failure)
              TFullScreenLoader.stopLoading(context);

              // Optionally, show a success or error message here
              if (state.status == FormStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'An error occurred'),
                  ),
                );
              } else if (state.status == FormStatus.success) {
                // Navigate on success

                TLoaders.successSnackBar(
                  context: context,
                  title: 'Account Successfuly Created!',
                  message: 'A verification email has been sent to your inbox.',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VerifyEmailScreen(email: state.email.trim()),
                  ),
                );
              }
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's create your account",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  SignupForm(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Devider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Divider(
                          color: dark ? TColors.darkGrey : TColors.grey,
                          thickness: 0.5,
                          endIndent: 5,
                          indent: 60,
                        ),
                      ),

                      Text(
                        'Or Sing in With',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Flexible(
                        child: Divider(
                          color: dark ? TColors.darkGrey : TColors.grey,
                          thickness: 0.5,
                          endIndent: 60,
                          indent: 5,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: TColors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Image(
                            width: TSizes.iconMd,
                            height: TSizes.iconMd,
                            image: AssetImage(TImages.tGoogleLogo),
                          ),
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: TColors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Image(
                            width: TSizes.iconMd,
                            height: TSizes.iconMd,
                            image: AssetImage(TImages.tFacebookLogo),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
