import 'package:cwt_starter_template/features/authentication/cubit/signup/signup_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/signup/signup_state.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:cwt_starter_template/utils/popups/exports.dart';
import 'package:cwt_starter_template/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Form(
          autovalidateMode: AutovalidateMode.onUnfocus,

          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator:
                          (value) =>
                              TValidator.validateEmptyText('First name', value),
                      onChanged:
                          (value) => context
                              .read<SignupCubit>()
                              .firstNameChanged(value),
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      validator:
                          (value) =>
                              TValidator.validateEmptyText('Last name', value),

                      onChanged:
                          (value) => context
                              .read<SignupCubit>()
                              .lastNameChanged(value),

                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // User Name
              TextFormField(
                validator:
                    (value) => TValidator.validateEmptyText('Username', value),

                onChanged:
                    (value) =>
                        context.read<SignupCubit>().usernameChanged(value),

                decoration: const InputDecoration(
                  labelText: 'User Name',
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Email
              TextFormField(
                validator: (value) => TValidator.validateEmail(value),

                onChanged:
                    (value) => context.read<SignupCubit>().emailChanged(value),

                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Iconsax.direct),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Phone Number
              TextFormField(
                validator: (value) => TValidator.validatePhoneNumber(value),
                onChanged:
                    (value) =>
                        context.read<SignupCubit>().phoneNumberChanged(value),

                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Iconsax.call),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              //Password
              TextFormField(
                validator: (value) => TValidator.validatePassword(value),
                onChanged:
                    (value) =>
                        context.read<SignupCubit>().passwordChanged(value),

                obscureText: !state.isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed:
                        () =>
                            context
                                .read<SignupCubit>()
                                .togglePasswordVisibility(),
                    icon: Icon(
                      state.isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Term & Conditions CheckBox
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: state.areTermsAccepted,
                      onChanged:
                          (value) => context
                              .read<SignupCubit>()
                              .termsAcceptenceChanged(value),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'I agree to ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: dark ? TColors.white : TColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                dark ? TColors.white : TColors.primary,
                          ),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: 'Terms of use',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: dark ? TColors.white : TColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                dark ? TColors.white : TColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      state.status == FormStatus.loading
                          ? null
                          : () {
                            if (!state.areTermsAccepted) {
                              TLoaders.errorSnackBar(
                                context: context,
                                title: 'Accept Privacy and Policy',
                                message:
                                    'In order to craete account, you must have to read and accept the Privacy Policy & Terms of Use.',
                              );
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              context.read<SignupCubit>().signUp();
                            }
                          },
                  child:
                      state.status == FormStatus.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Create Account'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
