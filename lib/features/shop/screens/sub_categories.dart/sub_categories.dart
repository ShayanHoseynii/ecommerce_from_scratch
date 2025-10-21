import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/images/rounded_image.dart';
import 'package:cwt_starter_template/common/widgets/products_card/products_card_horizontal.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: TAppBar(title: Text('Sports Shirt'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              TRoundedImage(
                width: double.infinity,
                imageUrl: TImages.promoBanner1,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Sub Categories
              Column(
                children: [
                  TSectionHeading(title: 'Sports Shirt', onPressed: () {}),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder:
                          (context, index) => const TProductCardHorizontal(),
                      separatorBuilder:
                          (context, index) =>
                              const SizedBox(width: TSizes.spaceBtwItems),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
