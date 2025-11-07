import 'package:get_it/get_it.dart';

import 'package:cwt_starter_template/data/repositories/authentication/authentication_repository.dart';
import 'package:cwt_starter_template/data/repositories/user/user_repository.dart';
import 'package:cwt_starter_template/data/repositories/categories/category_repository.dart';
import 'package:cwt_starter_template/data/repositories/banners/banners_repository.dart';
import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/data/repositories/brands/brands_repository.dart';
import 'package:cwt_starter_template/data/repositories/address/address_repository.dart';
import 'package:cwt_starter_template/data/repositories/order/order_repository.dart';

import 'package:cwt_starter_template/data/repositories/authentication/auth_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/login/login_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/signup/signup_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/forgetPassword/forget_password_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/email/email_verificatoin_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/adresses/cubit/address_form_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/product/product_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/brands/brands_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/banners/banners_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/all_products/all_products_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/home/controller/carusoul_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/wish_list/wish_list_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/brandShowcase/brand_showcase_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/subcategory/subcategory_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/payment/payment_method_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/orders/cubit/order_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/cubit/variation_cubit.dart';

import 'package:cwt_starter_template/utils/helpers/networkManager/network_manager.dart';

import 'package:cwt_starter_template/features/models/product_model.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingleton<AuthenticationRepository>(
    AuthenticationRepository.instance,
  );
  sl.registerLazySingleton<UserRepository>(() => UserRepository());
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepository());
  sl.registerLazySingleton<BannersRepository>(() => BannersRepository());
  sl.registerLazySingleton<ProductRepository>(() => ProductRepository());
  sl.registerLazySingleton<BrandsRepository>(() => BrandsRepository());
  sl.registerLazySingleton<AddressRepository>(() => AddressRepository());
  sl.registerLazySingleton<OrderRepository>(() => OrderRepository());

  sl.registerLazySingleton<NetworkCubit>(() => NetworkCubit());

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(sl<AuthenticationRepository>()),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      userRepo: sl<UserRepository>(),
      authRepository: sl<AuthenticationRepository>(),
      networkCubit: sl<NetworkCubit>(),
    ),
  );
  sl.registerFactory<UserCubit>(
    () => UserCubit(sl<UserRepository>(), sl<AuthenticationRepository>()),
  );
  sl.registerFactory<CategoryCubit>(
    () => CategoryCubit(sl<CategoryRepository>()),
  );
  sl.registerFactory<ProductCubit>(() => ProductCubit(sl<ProductRepository>()));
  sl.registerFactory<BrandsCubit>(() => BrandsCubit(sl<BrandsRepository>()));
  sl.registerFactory<BannerCubit>(() => BannerCubit(sl<BannersRepository>()));
  sl.registerFactory<AllProductsCubit>(
    () => AllProductsCubit(sl<ProductRepository>()),
  );
  sl.registerFactory<CarusoulCubit>(() => CarusoulCubit());

  sl.registerLazySingleton<FavouriteProductsCubit>(
    () => FavouriteProductsCubit(),
  );
  sl.registerFactory<WishlistCubit>(
    () => WishlistCubit(sl<FavouriteProductsCubit>(), sl<ProductRepository>()),
  );
  sl.registerFactory<BrandShowcaseCubit>(
    () => BrandShowcaseCubit(sl<BrandsRepository>(), sl<ProductRepository>()),
  );
  sl.registerFactory<SubcategoryCubit>(
    () => SubcategoryCubit(sl<CategoryRepository>(), sl<ProductRepository>()),
  );
  sl.registerLazySingleton<AddressCubit>(
    () => AddressCubit(sl<AddressRepository>()),
  );
  sl.registerFactory<AddressFormCubit>(
    () => AddressFormCubit(sl<AddressRepository>()),
  );
  sl.registerFactory<SignupCubit>(
    () => SignupCubit(
      authRepository: sl<AuthenticationRepository>(),
      networkCubit: sl<NetworkCubit>(),
      userRepository: sl<UserRepository>(),
    ),
  );
  sl.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(
      authRepository: sl<AuthenticationRepository>(),
      networkCubit: sl<NetworkCubit>(),
    ),
  );
  sl.registerFactory<EmailVerificationCubit>(
    () =>
        EmailVerificationCubit(authRepository: sl<AuthenticationRepository>()),
  );
  sl.registerLazySingleton<PaymentMethodCubit>(() => PaymentMethodCubit());
  sl.registerLazySingleton<CartCubit>(() => CartCubit());
  sl.registerFactory<OrderCubit>(
    () => OrderCubit(
      sl<OrderRepository>(),
      sl<AddressCubit>(),
      sl<PaymentMethodCubit>(),
      sl<CartCubit>(),
    ),
  );

  sl.registerFactoryParam<VariationCubit, ProductModel, void>(
    (product, _) => VariationCubit(product),
  );
}
