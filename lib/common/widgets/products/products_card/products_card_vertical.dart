import 'package:cwt_starter_template/common/styles/shodows.dart';
import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:cwt_starter_template/common/widgets/texts/brand_title_text_with_verifiedIcon.dart';
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

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final salePercentage = product.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final price = product.getProductPrice(product);

    return GestureDetector(
      onTap:
          () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product),
              ),
            ),
          },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(16),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            TRoundedContainer(
              height: 180,
              width: 181,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.lightGrey,
              child: Stack(
                children: [
                  Center(child: TRoundedImage(imageUrl: product.thumbnail)),
                  // --Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 10,
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
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),

            // -- Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -- Title & Brand
                  Padding(
                    padding: const EdgeInsets.only(
                      left: TSizes.sm,
                      top: TSizes.sm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleText(title: product.title, smallSize: true),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                        BrandTitleTextWithVerifiedIcon(
                          title: product.brand!.name,
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // -- Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: TSizes.sm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.salePrice != null &&
                                  product.salePrice! > 0)
                                Text(
                                  '\$${product.price}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium!.apply(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),

                              // Final Price
                              Text(
                                '\$$price',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                        ),
                      ),

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
                              if (product.productType == 'ProductType.single') {
                                context.read<CartCubit>().addToCart(
                                  product: product,
                                  quantity: 1,
                                  selectedVariation: null,
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => ProductDetailScreen(
                                          product: product,
                                        ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    productQuantityInCart > 0
                                        ? TColors.primary
                                        : TColors.black,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(TSizes.cardRadiusMd),
                                  bottomRight: Radius.circular(
                                    TSizes.productImageRadius,
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                height: TSizes.iconLg * 1.2,
                                width: TSizes.iconLg * 1.2,
                                child: Center(
                                  child:
                                      productQuantityInCart > 0
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
