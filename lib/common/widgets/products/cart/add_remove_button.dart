import 'package:cwt_starter_template/common/widgets/icons/circular_icon.dart';
import 'package:cwt_starter_template/features/models/cart_item_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TProductQuantityWithAddRemove extends StatelessWidget {
  const TProductQuantityWithAddRemove({super.key, required this.cartItem});
  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularIcon(
          onPressed: () => context.read<CartCubit>().decrementItem(cartItem.varitaionId),
          dark: dark,
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: dark ? TColors.white : TColors.black,
          backgroundColor: dark ? TColors.darkerGrey : TColors.lightContainer,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        Text(cartItem.quantity.toString(), style: Theme.of(context).textTheme.titleSmall),

        const SizedBox(width: TSizes.spaceBtwItems),
        CircularIcon(
          onPressed: () => context.read<CartCubit>().incrementItem(cartItem.varitaionId),

          dark: dark,
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: TColors.white,
          backgroundColor: TColors.primary,
        ),
      ],
    );
  }
}
