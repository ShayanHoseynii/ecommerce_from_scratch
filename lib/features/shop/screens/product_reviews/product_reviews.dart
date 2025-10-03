import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/products/rating/rating_indicator.dart';
import 'package:cwt_starter_template/features/shop/screens/product_reviews/widgets/overall_product_rating.dart';
import 'package:cwt_starter_template/features/shop/screens/product_reviews/widgets/progress_indicator_rating.dart';
import 'package:cwt_starter_template/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:cwt_starter_template/utils/constants/colors.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:cwt_starter_template/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rations and reviews are verified and are from people who use the same type of that you use.',
              ),

              /// Overall Product Ratings
              const SizedBox(height: TSizes.spaceBtwItems),
              const TOverallProductRating(),
              TRatingBarIndicator(rating: 3.6),
              Text('13,611', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// User Rewview List
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
