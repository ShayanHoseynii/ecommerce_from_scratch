import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/common/widgets/texts/brand_title_text_with_verifiedIcon.dart';
import 'package:cwt_starter_template/common/widgets/texts/product_title_text.dart';
import 'package:cwt_starter_template/features/models/cart_item_model.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({super.key, required this.cartItem});
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        /// Image
        TRoundedImage(
          imageUrl: cartItem.image!,
          width: 60,
          height: 60,
          padding: EdgeInsets.all(TSizes.sm),
          backgroundColor: dark ? TColors.darkerGrey : TColors.lightContainer,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        /// Title, Price, Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               BrandTitleTextWithVerifiedIcon(title: cartItem.brandName!),
              Flexible(
                child:  ProductTitleText(
                  title: cartItem.title,
                  maxLines: 1,
                ),
              ),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: cartItem.selectedVariation?.entries
                          .expand((entry) =>[
                                TextSpan(
                                  text: '${entry.key}: ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: '${entry.value} ',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ]).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
