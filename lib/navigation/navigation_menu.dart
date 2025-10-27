import 'package:cwt_starter_template/data/repositories/banners/banners_repository.dart';
import 'package:cwt_starter_template/data/repositories/brands/brands_repository.dart';
import 'package:cwt_starter_template/data/repositories/categories/category_repository.dart';
import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/features/shop/cubit/banners/banners_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/brands/brands_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/category/category_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/product/product_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/user/user_cubit.dart';
import 'package:cwt_starter_template/features/personalization/screens/settings/settings.dart';
import 'package:cwt_starter_template/features/shop/cubit/wish_list/wish_list_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/home/home.dart';
import 'package:cwt_starter_template/features/shop/screens/store/store.dart';
import 'package:cwt_starter_template/features/shop/screens/wishlist/wishlist.dart';
import 'package:cwt_starter_template/navigation/cubit/navigation_menu__cubit.dart';
import 'package:cwt_starter_template/navigation/cubit/navigation_menu_state.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  void initState() {
    context.read<UserCubit>().fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
              NavigationDestination(
                icon: Icon(Iconsax.heart),
                label: 'WishList',
              ),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            ],
            height: 80,
            elevation: 0,
            selectedIndex: state.index,
            onDestinationSelected:
                (value) => {context.read<NavigationCubit>().changeIndex(value)},
            backgroundColor: darkMode ? TColors.black : Colors.white,
            indicatorColor:
                darkMode
                    ? TColors.white.withOpacity(0.1)
                    : TColors.black.withOpacity(0.1),
          ),

          body: IndexedStack(
            index: state.index,
            children: [
              HomeScreen(),
              Store(),
              BlocProvider(
                create: (context) => WishlistCubit(context.read<FavouriteProductsCubit>(),context.read<ProductRepository>())..fetchWishlistProducts(),
                child: FavouriteItemScreen(),
              ),
              SettingsScreen(),
            ],
          ),
        );
      },
    );
  }
}
