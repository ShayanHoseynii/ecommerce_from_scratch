import 'package:cwt_starter_template/data/repositories/authentication/auth_cubit.dart';
import 'package:cwt_starter_template/data/repositories/authentication/auth_state.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
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
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
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
            create:
                (context) => AuthCubit(
                  context.read<AuthenticationRepository>(),
                  context.read<UserRepository>(),
                ),
          ),
          BlocProvider(create: (context) => NetworkCubit()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      navigatorKey: navigatorKey,
      onGenerateRoute: _appRouter.onGeneratedRoute,
      initialRoute: '/',
      builder: (context, child) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final navigator = navigatorKey.currentState;
              if (navigator == null) return;

              switch (state.status) {
                case AuthStatus.firstTime:
                  navigator.pushNamed('/onboarding');
                  break;

                case AuthStatus.unauthenticated:
                  navigator.pushReplacementNamed('/login');
                  break;

                case AuthStatus.authenticated:
                  navigator.pushNamedAndRemoveUntil(
                    '/navbar',
                    (Route<dynamic> route) => false,
                  );
                  break;
                // ... handle other cases similarly
                default:
                  break;
              }
            });
          },
          child: child!,
        );
      },
    );
  }
}
