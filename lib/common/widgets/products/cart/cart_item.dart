import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/icons/circular_icon.dart';
import 'package:cwt_starter_template/common/widgets/texts/brand_title_text_with_verifiedIcon.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_title_text.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_price_text.dart';
import 'package:cwt_starter_template/data/models/cart_item_model.dart';
import 'package:cwt_starter_template/core/constants/colors.dart';
import 'package:cwt_starter_template/core/constants/sizes.dart';
import 'package:cwt_starter_template/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/common/widgets/products/cart/add_remove_button.dart';
import 'package:iconsax/iconsax.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({super.key, required this.cartItem});
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.sm),
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      borderColor: dark ? TColors.darkBackground : TColors.borderLight,
      child: Stack(
        children: [
          Row(
            children: [
              /// Image
              TRoundedImage(
                imageUrl: cartItem.image!,
                width: 60,
                height: 60,
                padding: EdgeInsets.zero,
                backgroundColor: null,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),

              /// Title, Attributes, Controls
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (cartItem.brandName != null)
                      BrandTitleTextWithVerifiedIcon(
                        title: cartItem.brandName!,
                      ),
                    Flexible(
                      child: ProductTitleText(
                        title: cartItem.title,
                        maxLines: 1,
                      ),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (cartItem.selectedVariation != null)
                              Text.rich(
                                TextSpan(
                                  children:
                                      cartItem.selectedVariation!.entries
                                          .expand(
                                            (entry) => [
                                              TextSpan(
                                                text: '${entry.key}: ',
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.bodySmall,
                                              ),
                                              TextSpan(
                                                text: '${entry.value} ',
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.bodyLarge,
                                              ),
                                            ],
                                          )
                                          .toList(),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    /// Attributes
                    const SizedBox(height: TSizes.sm),

                    /// Quantity controls and subtotal inside container
                    Row(
                      children: [
                        TProductQuantityWithAddRemove(cartItem: cartItem),
                        const Spacer(),
                        TProductPriceText(
                          price: (cartItem.price * cartItem.quantity)
                              .toStringAsFixed(2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Remove button (clear, small, accessible)
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CircularIcon(
              dark: dark,
              icon: Iconsax.trash,
              color: TColors.white,
              backgroundColor: TColors.error,
              width: 32,
              height: 32,
              size: TSizes.md,
              onPressed:
                  () => context.read<CartCubit>().removeItem(
                    cartItem.varitaionId,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
