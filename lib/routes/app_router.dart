import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/forgetPassword/forget_password_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/onboarding/onboarding_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/signup/signup_cubit.dart';
import 'package:cwt_starter_template/features/authentication/screens/login/login.dart';
import 'package:cwt_starter_template/features/authentication/screens/onboarding/onboarding.dart';
import 'package:cwt_starter_template/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:cwt_starter_template/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:cwt_starter_template/features/authentication/screens/signup/sign_up.dart';
import 'package:cwt_starter_template/features/personalization/screens/profile/profile.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/add_new_address.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/addresses.dart';
import 'package:cwt_starter_template/features/shop/screens/brands/all_brands.dart';
import 'package:cwt_starter_template/features/shop/screens/cart/cart.dart';
import 'package:cwt_starter_template/features/shop/screens/checkout/checkout.dart';
import 'package:cwt_starter_template/features/shop/screens/order/order.dart';
import 'package:cwt_starter_template/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:cwt_starter_template/navigation/cubit/navigation_menu__cubit.dart';
import 'package:cwt_starter_template/navigation/navigation_menu.dart';
import 'package:cwt_starter_template/utils/helpers/networkManager/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cwt_starter_template/di/injection_container.dart';

class AppRouter {
  Route? onGeneratedRoute(RouteSettings settigns) {
    switch (settigns.name) {
      case '/':
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
        );
      case '/onboarding':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => OnboardingCubit(),
                child: OnboardingScreen(),
              ),
        );
      case '/navbar':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => NavigationCubit(),
                child: NavigationMenu(),
              ),
        );

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/create-account':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => sl<SignupCubit>(),
                child: SignUpScreen(),
              ),
        );

      case '/forget-password':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => sl<ForgetPasswordCubit>(),
                child: ForgetPassword(),
              ),
        );

      case '/reset-password':
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(email: ''),
        );

      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case '/reviews':
        return MaterialPageRoute(builder: (_) => ProductReviewsScreen());

      case '/addresses':
        return MaterialPageRoute(builder: (_) => AdressesScreen());

      case '/add-address':
        return MaterialPageRoute(builder: (_) => AddNewAddressScreen());

      case '/shopping-cart':
        return MaterialPageRoute(builder: (_) => CartScreen());

      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutScreen());

      case '/orders':
        return MaterialPageRoute(builder: (_) => OrderScreen());

      case '/brands':
        return MaterialPageRoute(builder: (_) => AllBrandsScreen());

      default:
        return null;
    }
  }
}
