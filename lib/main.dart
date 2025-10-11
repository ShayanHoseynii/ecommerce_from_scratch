import 'package:cwt_starter_template/data/repositories/authentication/auth_cubit.dart';
import 'package:cwt_starter_template/data/repositories/authentication/auth_state.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
import 'package:cwt_starter_template/features/authentication/screens/signup/verify_email.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_router.dart';
import 'utils/theme/theme.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationRepository()),
        RepositoryProvider(create: (context) => UserRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(context.read<AuthenticationRepository>()),
          ),
          BlocProvider(create: (context) => NetworkCubit()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

// Your MyApp class is correct and doesn't need changes.
// I've just added the missing 'break;' statement.
class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      onGenerateRoute: _appRouter.onGeneratedRoute,
      home: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          FlutterNativeSplash.remove();

          switch (state.status) {
            case AuthStatus.firstTime:
              Navigator.pushReplacementNamed(context, '/onboarding');
              break;
            case AuthStatus.emailVerification:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        VerifyEmailScreen(email: state.user?.email ?? '')),
              );
              break;
            case AuthStatus.authenticated:
              Navigator.pushReplacementNamed(context, '/navbar');
              break;
            case AuthStatus.unauthenticated:
              Navigator.pushReplacementNamed(context, '/login');
              break; // Added missing break
            case AuthStatus.authError:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      state.errorMessage ?? 'An authentication error occurred.'),
                ),
              );
              Navigator.pushReplacementNamed(context, '/login');
              break;
            case AuthStatus.unknown:
              break;
          }
        },
        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}