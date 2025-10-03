import 'package:cwt_starter_template/common/widgets/icons/circular_icon.dart';
import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/curved_edges/curved_edges_widget.dart';
import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({super.key});


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.lightContainer,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 4),
                child: Center(
                  child: Image(image: AssetImage(TImages.productImage12)),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              bottom: 30,
              right: 0,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder:
                      (_, index) => TRoundedImage(
                        imageUrl: TImages.productImage5,
                        width: 80,
                        backgroundColor: dark ? TColors.dark : TColors.white,
                        border: Border.all(color: TColors.primary),
                        padding: const EdgeInsets.all(TSizes.sm),
                      ),
                  separatorBuilder:
                      (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: 6,
                ),
              ),
            ),

            TAppBar(
              showBackArrow: true,
              actions: [
                CircularIcon(
                  dark: dark,
                  icon: Iconsax.heart5,
                  color: TColors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
