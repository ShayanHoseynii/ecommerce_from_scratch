import 'package:cached_network_image/cached_network_image.dart';
import 'package:cwt_starter_template/common/widgets/brands/brand_card.dart';
import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:cwt_starter_template/features/models/brand_model.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({super.key, required this.images, required this.brand});

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          /// -- Brand with Products Count
          BrandCard(showBorder: false, brand: brand),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Brand Top 3 Product Image
          Row(
            children:
                images.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String img = entry.value;

                  return Expanded(
                    child: TRoundedContainer(
                      height: 100,
                      backgroundColor:
                          dark ? TColors.darkGrey : TColors.lightContainer,
                      margin: EdgeInsets.only(
                        right:
                            idx == images.length - 1
                                ? 0
                                : TSizes.sm, // no margin for last
                      ),
                      child: CachedNetworkImage(
                        imageUrl: img,
                        placeholder:
                            (context, url) =>
                                const TShimmerEffect(width: 100, height: 100),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
