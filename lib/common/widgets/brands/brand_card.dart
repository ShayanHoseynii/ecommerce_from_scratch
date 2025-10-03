import 'package:cwt_starter_template/common/widgets/containers/rounded_container.dart';
import 'package:cwt_starter_template/common/widgets/images/circular_image.dart';
import 'package:cwt_starter_template/common/widgets/texts/brand_title_text_with_verifiedIcon.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/enums.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({super.key, required this.showBorder, this.onTap});

  final bool showBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: CircularImage(
                dark: dark,
                overlayColor: dark ? TColors.white : TColors.black,
                image: TImages.nikeLogo,
                backgroundColor: Colors.transparent,
                isNetworkImage: false,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            /// ---Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandTitleTextWithVerifiedIcon(
                    title: 'Nike',
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '256 products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
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
