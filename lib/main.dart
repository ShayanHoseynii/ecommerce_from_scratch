import 'package:cwt_starter_template/data/repositories/address/address_repository.dart';
import 'package:cwt_starter_template/data/repositories/authentication/auth_cubit.dart';
import 'package:cwt_starter_template/data/repositories/authentication/auth_state.dart';
import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/banners/banners_repository.dart';
import 'package:cwt_starter_template/data/repositories/brands/brands_repository.dart';
import 'package:cwt_starter_template/data/repositories/categories/category_repository.dart';
import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
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
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiRepositoryProvider(
      providers: [
RepositoryProvider.value(value: AuthenticationRepository.instance),        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => CategoryRepository()),
        RepositoryProvider(create: (_) => BannersRepository()),
        RepositoryProvider(create: (_) => ProductRepository()),
        RepositoryProvider(create: (_) => BrandsRepository()),
        RepositoryProvider(create: (_) => AddressRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) =>
                    AuthCubit(context.read<AuthenticationRepository>()),
          ),
          BlocProvider(create: (context) => NetworkCubit()),
          BlocProvider(
            create:
                (context) => LoginCubit(
                  userRepo: context.read<UserRepository>(),
                  authRepository: context.read<AuthenticationRepository>(),
                  networkCubit: context.read<NetworkCubit>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => UserCubit(
                  context.read<UserRepository>(),
                  context.read<AuthenticationRepository>(),
                ),
          ),

           BlocProvider(
                create:
                    (context) =>
                        CategoryCubit(context.read<CategoryRepository>())
                          ..fetchCategories(),
              ),
              BlocProvider(
                create:
                    (context) =>
                        ProductCubit(context.read<ProductRepository>())
                          ..fetchProducts(),
              ),
              BlocProvider(
                create:
                    (context) =>
                        BrandsCubit(context.read<BrandsRepository>())
                          ..fetchBrands(),
              ),
              BlocProvider(create: (context) => FavouriteProductsCubit()),
                      BlocProvider(create: (_) => CartCubit()), 
                      BlocProvider(create: (context) => AddressCubit(context.read<AddressRepository>())..fetchUserAddresses()), 



          
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
    return GetMaterialApp(
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
