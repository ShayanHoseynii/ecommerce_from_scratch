import 'package:cwt_starter_template/features/authentication/cubit/onboarding_cubit.dart';
import 'package:cwt_starter_template/features/authentication/screens/login/login.dart';
import 'package:cwt_starter_template/features/authentication/screens/onboarding/onboarding.dart';
import 'package:cwt_starter_template/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:cwt_starter_template/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:cwt_starter_template/features/authentication/screens/signup/sign_up.dart';
import 'package:cwt_starter_template/features/authentication/screens/signup/success_screen.dart';
import 'package:cwt_starter_template/features/authentication/screens/signup/verify_email.dart';
import 'package:cwt_starter_template/features/personalization/screens/profile/profile.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/product_detail.dart';
import 'package:cwt_starter_template/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:cwt_starter_template/navigation/cubit/navigation_menu__cubit.dart';
import 'package:cwt_starter_template/navigation/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGeneratedRoute(RouteSettings settigns) {
    switch (settigns.name) {
      case '/':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => OnboardingCubit(),
                child: OnboardingScreen(),
              ),
        );

      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case '/create-account':
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case '/verify-email':
        return MaterialPageRoute(builder: (_) => VerifyEmailScreen());

      case '/success-screen':
        return MaterialPageRoute(builder: (_) => SuccessScreen());

      case '/forget-password':
        return MaterialPageRoute(builder: (_) => ForgetPassword());

      case '/reset-password':
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());

      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case '/product-detail':
        return MaterialPageRoute(builder: (_) => ProductDetailScreen());

      case '/reviews':
        return MaterialPageRoute(builder: (_) => ProductReviewsScreen());

      case '/navbar':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => NavigationCubit(),
                child: NavigationMenu(),
              ),
        );

      default:
        return null;
    }
  }
}
