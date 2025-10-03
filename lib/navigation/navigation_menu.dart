import 'package:cwt_starter_template/features/personalization/screens/settings/settings.dart';
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

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return NavigationBar(
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
            indicatorColor: darkMode ? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.1),
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return IndexedStack(
              index: state.index,
              children: [
                HomeScreen(),
                Store(),
                FavouriteItemScreen(),
                SettingsScreen(),
              ],
            );
        },
      ),
    );
  }
}
