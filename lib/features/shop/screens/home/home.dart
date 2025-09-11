import 'package:cwt_starter_template/common/widgets/containers/primary_header_container.dart';
import 'package:cwt_starter_template/common/widgets/containers/search_container.dart';
import 'package:cwt_starter_template/common/widgets/image_text_widgets.dart/vertical_image_text.dart';
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
                  THomeAppBar(),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  TSearchContainer(text: 'Search in Store'),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  TSectionHeading(
                    title: 'Popular Categories',
                    showActionButton: false,
                    textColor: TColors.white,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

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

                  // Carousel Slider with dots
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TPromoSlider(banners: [TImages.promoBanner1, TImages.promoBanner2, TImages.promoBanner3]),
            ),
          ],
        ),
      ),
    );
  }
}


