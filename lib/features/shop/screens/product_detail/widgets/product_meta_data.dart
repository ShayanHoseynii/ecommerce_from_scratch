import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/images/circular_image.dart';
import 'package:cwt_starter_template/common/widgets/texts/brand_title_text_with_verifiedIcon.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_price_text.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_title_text.dart';
import 'package:cwt_starter_template/features/authentication/models/product_model.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/enums.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/exports.dart';
import 'package:flutter/material.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final salePercentage = product.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final price = product.getProductPrice(product);
    final stockStatus = product.getProductStockStatus(product.stock);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sales Tag
            if (salePercentage != null) ...[
              TRoundedContainer(
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
              const SizedBox(width: TSizes.spaceBtwItems),
            ],

            // Original Price with Strikethrough if on sale
            if (salePercentage != null && product.price > 0)
              Text(
                '\$${product.price}',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            if (salePercentage != null && product.price > 0)
              const SizedBox(width: TSizes.spaceBtwItems),

            // Final Price
            TProductPriceText(price: price, isLarge: true),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
        ProductTitleText(title: product.title),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Stack Status
        Row(
          children: [
            const ProductTitleText(title: 'Status: ', smallSize: true),
            const SizedBox(width: TSizes.spaceBtwItems),
            // Stock Status with a visual badge
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor:
                  stockStatus == 'In Stock'
                      ? TColors.primary.withOpacity(0.8)
                      : TColors.error.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.sm,
                vertical: TSizes.xs,
              ),
              child: Text(
                stockStatus,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.apply(color: TColors.white),
              ),
            ),

            const Spacer(), // Use spacer to push brand to the right
            /// Brand
            Row(
              children: [
                CircularImage(
                  dark: dark,
                  isNetworkImage: true,
                  image: product.brand?.image ?? "",
                  width: 50,
                  height: 50,
                  overlayColor: dark ? TColors.white : TColors.black,
                ),
                BrandTitleTextWithVerifiedIcon(
                  title: product.brand?.name ?? '',
                  brandTextSize: TextSizes.medium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
