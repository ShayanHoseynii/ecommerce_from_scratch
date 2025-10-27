import 'package:cwt_starter_template/common/widgets/icons/circular_icon.dart';
import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_state.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return BlocBuilder<FavouriteProductsCubit, FavouriteProductsState>(
      builder: (context, state) {
        bool isFavourite = false;
        if (state is FavouriteProductsLoaded) {
          isFavourite = state.favourites.containsKey(productId);
        }

        return CircularIcon(
          icon: isFavourite ? Iconsax.heart5 : Iconsax.heart,
          color: isFavourite ? Colors.red : null,
          dark: dark,
          onPressed: () {
            context
                .read<FavouriteProductsCubit>()
                .toggleFavouriteStatus(productId);
          },
        );
      },
    );
  }
}
