import 'package:cwt_starter_template/features/authentication/controllers/onboarding_cubit.dart';
import 'package:cwt_starter_template/features/authentication/screens/login/login.dart';
import 'package:cwt_starter_template/features/authentication/screens/onboarding/onboarding.dart';
import 'package:cwt_starter_template/features/authentication/screens/signup/sign_up.dart';
import 'package:cwt_starter_template/routes/routes.dart';
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

      default:
        return null;
    }
  }
}
