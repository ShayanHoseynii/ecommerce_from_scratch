import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/bottom_add_to_cart_widget.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/product_attributes.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/product_detail_image_slider.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/product_meta_data.dart';
import 'package:cwt_starter_template/features/shop/screens/product_detail/widgets/rating_share_widget.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Product Image Slider
            TProductImageSlider(),

            /// -- Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// - Rating & Share Button
                  TRatingAndWidget(),

                  /// - Price, Title, Stack, & Brand
                  TProductMetaData(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// - Attributes
                  TProductAttributes(),
                  SizedBox(height: TSizes.spaceBtwItems),

                  /// - Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Checkout'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// - Details
                  TSectionHeading(title: 'Details', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    'This is a Product Description for Blue Nike Sleeve less vest. There are more things that can be added but for now this will do. This is a Product Description for Blue Nike Sleeve less vest. There are more things that can be added but for now this will do.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  /// - Rewiews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                        title: 'Rewiews (199)',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed:
                            () => Navigator.of(context).pushNamed('/reviews'),
                        icon: Icon(Iconsax.arrow_right_3, size: 18),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
