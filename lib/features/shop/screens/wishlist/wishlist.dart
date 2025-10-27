import 'package:cwt_starter_template/common/widgets/icons/circular_icon.dart';
import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products/products_card/products_card_vertical.dart';
import 'package:cwt_starter_template/features/shop/cubit/wish_list/wish_list_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/wish_list/wish_list_state.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/vertical_product_shimmer.dart';
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
              BlocBuilder<WishlistCubit, WishlistState>(
                builder: (context, state) {
                  if (state is WishlistLoading) {
                    return const TVerticalProductShimmer();
                  } else if (state is WishlistError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is WishlistLoaded && state.products.isEmpty) {
                    return const Center(child: Text('No products available'));
                  } else if (state is WishlistLoaded) {
                    return GridLayout(
                      itemCount: state.products.length,
                      itemBuilder: (_, index) =>  ProductCardVertical(product: state.products[index],),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
