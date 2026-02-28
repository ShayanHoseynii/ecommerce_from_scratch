import 'package:cwt_starter_template/common/widgets/icons/circular_icon.dart';
import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/favourite_icon/favourite_icon_state.dart';
import 'package:cwt_starter_template/core/helpers/exports.dart';
import 'package:cwt_starter_template/core/constants/colors.dart';
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

        return Semantics(
          button: true,
          label: isFavourite ? 'Remove from wishlist' : 'Add to wishlist',
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder:
                (child, animation) => ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  ),
                  child: child,
                ),
            child: CircularIcon(
              key: ValueKey(isFavourite),
              icon: isFavourite ? Iconsax.heart5 : Iconsax.heart,
              color: isFavourite ? TColors.red : null,
              backgroundColor:
                  isFavourite ? TColors.red.withOpacity(0.15) : null,
              dark: dark,
              // Reduce outer spacing around the heart icon
              constraints: const BoxConstraints.tightFor(width: 36, height: 36),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              onPressed: () {
                context.read<FavouriteProductsCubit>().toggleFavouriteStatus(
                  productId,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
