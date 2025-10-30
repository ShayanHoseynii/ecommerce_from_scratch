import 'package:cwt_starter_template/common/styles/shodows.dart';
import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:cwt_starter_template/common/widgets/texts/brand_title_text_with_verifiedIcon.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_price_text.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_title_text.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/shopping_cart/cart_state.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/product_detail.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final salePercentage = product.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final price = product.getProductPrice(product);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [ShadowStyle.horizontalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.lightContainer,
      ),
      child: Row(
        children: [
          /// Thumbnail
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product),
              ),
            ),
            child: TRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.lightContainer,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: TRoundedImage(imageUrl: product.thumbnail),
                  ),

                  // -- Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm,
                          vertical: TSizes.xs,
                        ),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.apply(color: TColors.black),
                        ),
                      ),
                    ),

                  /// -- Favourite Icon
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),
          ),

          /// Details
          SizedBox(
            width: 168,
            child: Padding(
              padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleText(title: product.title, smallSize: true),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      BrandTitleTextWithVerifiedIcon(
                          title: product.brand!.name),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: TProductPriceText(price: price)),
                      
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          int productQuantityInCart = 0;
                          if (state is CartLoaded) {
                            productQuantityInCart = state.cartItems
                                .where((item) => item.productId == product.id)
                                .fold(
                                  0,
                                  (previous, element) =>
                                      previous + element.quantity,
                                );
                          }

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (product.productType ==
                                  'ProductType.simple') {
                                context.read<CartCubit>().addToCart(
                                      product: product,
                                      quantity: 1,
                                      selectedVariation: null,
                                    );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailScreen(product: product),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: productQuantityInCart > 0
                                    ? TColors.primary
                                    : TColors.dark,
                                borderRadius: const BorderRadius.only(
                                  topLeft:
                                      Radius.circular(TSizes.cardRadiusMd),
                                  bottomRight: Radius.circular(
                                      TSizes.productImageRadius),
                                ),
                              ),
                              child: SizedBox(
                                height: TSizes.iconLg * 1.2,
                                width: TSizes.iconLg * 1.2,
                                child: Center(
                                  child: productQuantityInCart > 0
                                      ? Text(
                                          productQuantityInCart.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .apply(color: TColors.white),
                                        )
                                      : const Icon(
                                          Iconsax.add,
                                          color: TColors.white,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // --- 4. END OF PASTED LOGIC ---
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}