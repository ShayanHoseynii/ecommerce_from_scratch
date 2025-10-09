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
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  final authRepository = AuthenticationRepository();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationRepository()),
        RepositoryProvider(create: (context) => UserRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(authRepository)..checkAppStart(),
          ),
          BlocProvider(create: (_) => NetworkCubit()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

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
          // Splash is removed only after state is determined
          FlutterNativeSplash.remove();

          if (state == AuthState.firstTime) {
            print('=============GETSTORAGE=========');
            print(GetStorage().read('IsFirstTime'));
            Navigator.pushReplacementNamed(context, '/onboarding');
          } else if (state == AuthState.loggedOut) {
            print('=============GETSTORAGE=========');
            print(GetStorage().read('IsFirstTime'));
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
