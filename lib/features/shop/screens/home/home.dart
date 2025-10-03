import 'package:cwt_starter_template/common/widgets/containers/primary_header_container.dart';
import 'package:cwt_starter_template/common/widgets/containers/search_container.dart';
import 'package:cwt_starter_template/common/widgets/image_text_widgets.dart/vertical_image_text.dart';
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products_card/products_card_vertical.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // Appbar
                  THomeAppBar(),

                  const SizedBox(height: TSizes.spaceBtwSections),
                  // Searchbar
                  TSearchContainer(text: 'Search in Store'),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  // Categories
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace,
                    ),
                    child: TSectionHeading(
                      title: 'Popular Categories',
                      showActionButton: false,
                      textColor: TColors.white,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return TVerticalImageText(
                            image: TImages.shoeIcon,
                            title: 'Shoes',
                            onTap: () {},
                          );
                        },
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Carousel Slider with dots
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  TSectionHeading(title: 'Popular Products', onPressed: () {}),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  GridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => const ProductCardVertical(),
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
