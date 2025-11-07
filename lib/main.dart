import 'package:cwt_starter_template/data/repositories/authentication/auth_cubit.dart';
import 'package:cwt_starter_template/data/repositories/authentication/auth_state.dart';
import 'package:cwt_starter_template/features/authentication/cubit/login/login_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/brands/brands_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/product/product_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/simple_bloc_observer.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:cwt_starter_template/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cwt_starter_template/di/injection_container.dart';
import 'routes/app_router.dart';
import 'utils/theme/theme.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  await TLocalStorage.init(null);
  
  await initDependencies();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider.value(value: sl<NetworkCubit>()),
        BlocProvider(create: (_) => sl<LoginCubit>()),
        BlocProvider(create: (_) => sl<UserCubit>()),
        BlocProvider(create: (_) => sl<CategoryCubit>()..fetchCategories()),
        BlocProvider(create: (_) => sl<ProductCubit>()..fetchProducts()),
        BlocProvider(create: (_) => sl<BrandsCubit>()..fetchBrands()),
        BlocProvider.value(value: sl<FavouriteProductsCubit>()),
        BlocProvider.value(value: sl<CartCubit>()),
        BlocProvider.value(value: sl<AddressCubit>()..fetchUserAddresses()),
      ],
      child: MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      navigatorKey: navigatorKey,
      onGenerateRoute: _appRouter.onGeneratedRoute,
      initialRoute: '/',
      builder: (context, child) {
        return MultiBlocListener(
          listeners: [
            BlocListener<AuthCubit, AuthState>(
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
                    default:
                      break;
                  }
                });
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listenWhen: (previous, current) => previous.status != current.status,
              listener: (context, state) {
                switch (state.status) {
                  case AuthStatus.authenticated:
                  case AuthStatus.emailVerification:
                  case AuthStatus.unauthenticated:
                    sl<FavouriteProductsCubit>().initFavourites();
                    sl<CartCubit>().loadCartFromStorage();
                    break;
                  default:
                    break;
                }
              },
            ),
          ],
          child: child!,
        );
      },
    );
  }
}