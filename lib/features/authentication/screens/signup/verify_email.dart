import 'dart:async';

import 'package:cwt_starter_template/common/widgets/success_screen/success_screen.dart';
import 'package:cwt_starter_template/data/repositories/authentication/auth_cubit.dart';
import 'package:cwt_starter_template/di/injection_container.dart';
import 'package:cwt_starter_template/features/authentication/cubit/email/email_verification_state.dart';
import 'package:cwt_starter_template/features/authentication/cubit/email/email_verificatoin_cubit.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/device/device_utility.dart';
import 'package:cwt_starter_template/utils/popups/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, required this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmailVerificationCubit>(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();

              },
              icon: const Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        body: BlocListener<EmailVerificationCubit, EmailVerificationState>(
          listener: (context, state) {
            if (state.status == EmailVerificationStatus.success) {
              TLoaders.successSnackBar(
                context: context,
                title: 'Success!',
                message: "Your email has been verified",
              );
              Timer(const Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SuccessScreen(
                          image: TImages.successfullyRegisterAnimation,
                          title: 'Well Done!',
                          subtitle:
                              'Your account has been created successfuly.',
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/navbar',
                              (route) => false,
                            );
                          },
                        ),
                  ),
                );
              });
            } else if (state.status == EmailVerificationStatus.failure) {
              TLoaders.errorSnackBar(
                context: context,
                title: 'Oh Snap!',
                message: state.errorMessage ?? 'Something went wrong',
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Image(
                    image: AssetImage(TImages.deliveredEmailIllustration),
                    width: TDeviceUtils.getScreenWidth(context) * 0.6,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Title and Subtitle
                  Text(
                    'Verify your email address!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    'Congratulations Your Account Awaits: Verify Your Email to Start Shopping and Experience a World of Unriveald Deals and Personalized offers',
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Buttons
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<
                      EmailVerificationCubit,
                      EmailVerificationState
                    >(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            state.status == EmailVerificationStatus.loading
                                ? null
                                : () =>
                                    context
                                        .read<EmailVerificationCubit>()
                                        .manuallyCheckStatus();
                          },
                          child:
                              state.status == EmailVerificationStatus.loading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text('Continue'),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<EmailVerificationCubit>()
                            .sendEmailVerification();
                      },
                      child: Text('Resend Email'),
                    ),
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
