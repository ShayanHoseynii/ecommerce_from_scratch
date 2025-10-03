import 'package:cwt_starter_template/common/widgets/brands/brand_showcase.dart';
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products_card/products_card_vertical.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              TBrandShowcase(
                images: [
                  TImages.productImage11,
                  TImages.productImage12,
                  TImages.productImage1,
                ],
              ),

              /// Products
              TSectionHeading(
                title: 'You might like',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              GridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => ProductCardVertical(),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
