import 'package:cwt_starter_template/common/widgets/icons/circular_icon.dart';
import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products_card/products_card_vertical.dart';
import 'package:cwt_starter_template/navigation/cubit/navigation_menu__cubit.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteItemScreen extends StatelessWidget {
  const FavouriteItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            dark: dark,
            icon: Iconsax.add,
            onPressed: () => context.read<NavigationCubit>().changeIndex(0),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              GridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => ProductCardVertical(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
