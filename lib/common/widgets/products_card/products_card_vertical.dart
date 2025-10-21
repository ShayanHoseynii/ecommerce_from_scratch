import 'package:cwt_starter_template/common/widgets/icons/circular_icon.dart';
import 'package:cwt_starter_template/common/styles/shodows.dart';
import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/common/widgets/texts/brand_title_text_with_verifiedIcon.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_title_text.dart';
import 'package:cwt_starter_template/features/authentication/cubit/product/product_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/product/product_state.dart';
import 'package:cwt_starter_template/features/authentication/models/product_model.dart';
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

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return GestureDetector(
          onTap:
              () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              ),
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
                              style: Theme.of(context).textTheme.labelLarge!
                                  .apply(color: TColors.black),
                            ),
                          ),
                        ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircularIcon(
                          dark: dark,
                          icon: Iconsax.heart5,
                          color: Colors.red,
                        ),
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
                            ProductTitleText(
                              title: product.title,
                              smallSize: true,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems / 2),
                            BrandTitleTextWithVerifiedIcon(
                              title: product.brand!.name,
                            ),
                          ],
                        ),
                      ),

                      // Use Spacer to push the price to the bottom
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
                                  // Strikethrough price if there is a sale price
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
                                        Theme.of(
                                          context,
                                        ).textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Add to Cart Button
                          Container(
                            decoration: const BoxDecoration(
                              color: TColors.dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(TSizes.cardRadiusMd),
                                bottomRight: Radius.circular(
                                  TSizes.productImageRadius,
                                ),
                              ),
                            ),
                            child: const SizedBox(
                              height: TSizes.iconLg * 1.2,
                              width: TSizes.iconLg * 1.2,
                              child: Center(
                                child: Icon(Iconsax.add, color: TColors.white),
                              ),
                            ),
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
      },
    );
  }
}
