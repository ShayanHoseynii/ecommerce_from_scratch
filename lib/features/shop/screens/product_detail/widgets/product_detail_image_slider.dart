import 'package:cached_network_image/cached_network_image.dart';
import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/curved_edges/curved_edges_widget.dart';
import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:cwt_starter_template/features/models/product_model.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
    this.onImageSelected,
    this.selectedImage, required this.allImages,
  });
  final ProductModel product;
  final Function(String)? onImageSelected;
  final String? selectedImage;
  final List<String> allImages;
  

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
                padding: const EdgeInsets.all(
                  TSizes.productImageRadius * 4,
                ),
                child: Center(
                  child: GestureDetector(
                    // Wrap the image with GestureDetector
                    onTap:
                        () => THelperFunctions.showEnlargedImage(
                          selectedImage ?? '',
                        ), // Call the helper function
                    child: CachedNetworkImage(
                      imageUrl: selectedImage ?? '',
                      progressIndicatorBuilder:
                          (_, __, ___) => TShimmerEffect(
                            width: double.infinity,
                            height: 400,
                          ),
                      errorWidget: (_, __, ___) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
    
            /// Image Slider
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final imageUrl = allImages[index];
                      return GestureDetector(
                        onTap: () => onImageSelected!(imageUrl),
                        child: TRoundedImage(
                          imageUrl: imageUrl,
                          width: 80,
                          backgroundColor:
                              dark ? TColors.dark : TColors.white,
                          border:
                              selectedImage == imageUrl
                                  ? Border.all(
                                    color: TColors.primary,
                                    width: 2,
                                  )
                                  : null,
                          padding: const EdgeInsets.all(TSizes.sm),
                        ),
                      );
                    },
                    separatorBuilder:
                        (_, __) =>
                            const SizedBox(width: TSizes.spaceBtwItems / 2),
                    itemCount: allImages.length,
                  ),
                ),
              ),
            ),
    
            TAppBar(
              showBackArrow: true,
              actions: [
               TFavouriteIcon(productId: product.id,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
