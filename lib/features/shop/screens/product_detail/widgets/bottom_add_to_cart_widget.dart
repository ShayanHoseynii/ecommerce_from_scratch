import 'package:cwt_starter_template/common/widgets/icons/circular_icon.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/features/models/product_variation_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/cubit/cart_quntity_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/cubit/variation_cubit.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.lightContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Row(
            children: [
              CircularIcon(
                onPressed: () => context.read<QuantityCubit>().decrement(),
                dark: dark,
                icon: Iconsax.minus,
                backgroundColor: TColors.darkGrey,
                width: 40,
                height: 40,
                color: TColors.white,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              BlocBuilder<QuantityCubit, int>(
                builder: (context, quantity) {
                  return Text(
                    '$quantity',
                    style: Theme.of(context).textTheme.titleSmall,
                  );
                },
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              CircularIcon(
                onPressed: () => context.read<QuantityCubit>().increment(),
                dark: dark,
                icon: Iconsax.add,
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: TColors.white,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // 6. Get all the data needed from the cubits
              final quantity = context.read<QuantityCubit>().state;
              final variationState = context.read<VariationCubit>().state;

              // Get selected variation
              final ProductVariationModel variation =
                  variationState.selectedVariation;

              final ProductVariationModel? selectedVariation =
                  variation.id.isEmpty ? null : variation;

              // 7. Call the CartCubit
              context.read<CartCubit>().addToCart(
                product: product,
                quantity: quantity,
                selectedVariation: selectedVariation,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.black,
              side: const BorderSide(color: TColors.black),
            ),
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
