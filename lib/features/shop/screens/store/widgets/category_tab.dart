import 'package:cwt_starter_template/common/widgets/brands/brand_showcase.dart';
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products_card/products_card_vertical.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/authentication/cubit/product/product_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/product/product_state.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/vertical_product_shimmer.dart';
import 'package:cwt_starter_template/utils/constants/image_strings.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const TVerticalProductShimmer();
                  } else if (state is ProductError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is ProductLoaded && state.featuredProducts == null) {
                    return const Center(child: Text('No products available'));
                  } else if (state is ProductLoaded) {
                    return GridLayout(
                      itemCount: state.featuredProducts!.length,
                      itemBuilder: (_, index) =>  ProductCardVertical(product: state.featuredProducts![index],),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
