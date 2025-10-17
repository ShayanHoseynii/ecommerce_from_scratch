import 'package:cwt_starter_template/common/styles/spacing_styles.dart';
import 'package:cwt_starter_template/features/authentication/cubit/login/login_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/login/login_state.dart';
import 'package:cwt_starter_template/features/authentication/screens/signup/sign_up.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/constants/text_strings.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:cwt_starter_template/utils/popups/exports.dart';
import 'package:cwt_starter_template/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final loginCubit = context.read<LoginCubit>();
    _emailController = TextEditingController(text: loginCubit.state.email);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.loading) {
            TFullScreenLoader.openLoadingDialog(
              context,
              'Logging you in...',
              TImages.docerAnimation,
            );
          } else if (state.status == LoginStatus.failure) {
            // Check if the widget is still mounted before showing the loader/snackbar
            if (!context.mounted) return;
            TFullScreenLoader.stopLoading(context);
            TLoaders.errorSnackBar(
              context: context,
              title: 'Oh Snap!',
              message: state.error!,
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyles.paddingWithAppBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- HEADER ---
                Image(
                  image: AssetImage(
                    dark
                        ? "assets/logo/t-store-splash-logo-white.png"
                        : "assets/logo/t-store-splash-logo-black.png",
                  ),
                  height: 150,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  TTexts.tLoginTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.sm),
                Text(
                  TTexts.tLoginSubTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                // --- FORM ---
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: TSizes.spaceBtwSections,
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              onChanged:
                                  (value) => context
                                      .read<LoginCubit>()
                                      .emailChanged(value),
                              validator:
                                  (value) => TValidator.validateEmail(value),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Iconsax.direct_right),
                              ),
                            ),
                            const SizedBox(height: TSizes.spaceBtwInputFields),
                            TextFormField(
                              controller: _passwordController,
                              onChanged:
                                  (value) => context
                                      .read<LoginCubit>()
                                      .passwordChanged(value),
                              // 3. CORRECT VALIDATOR for password
                              validator:
                                  (value) => TValidator.validatePassword(value),
                              obscureText: !state.isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Iconsax.password_check),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    state.isPasswordVisible
                                        ? Iconsax.eye
                                        : Iconsax.eye_slash,
                                  ),
                                  onPressed:
                                      () =>
                                          context
                                              .read<LoginCubit>()
                                              .togglePasswordVisibility(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields / 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // 4. CORRECT CHECKBOX logic
                                    Checkbox(
                                      value: state.rememberMe,
                                      onChanged:
                                          (value) => context
                                              .read<LoginCubit>()
                                              .rememberMeChanged(value),
                                    ),
                                    const Text('Remember me'),
                                  ],
                                ),
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(
                                        context,
                                      ).pushNamed('/forget-password'),
                                  child: const Text('Forget Password?'),
                                ),
                              ],
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                    state.status == LoginStatus.loading
                                        ? null
                                        : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<LoginCubit>()
                                                .emailPasswordSignIn();
                                          }
                                        },
                                child:
                                    state.status == LoginStatus.loading
                                        ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : const Text('Login'),
                              ),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignUpScreen(),
                                      ),
                                    ),
                                child: const Text('Create Account'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                
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
                          onPressed: () => context.read<LoginCubit>().signUpWithGoogle(),
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
    );
  }
}
