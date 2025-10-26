import 'package:cwt_starter_template/common/widgets/brands/brand_showcase.dart';
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products_card/products_card_vertical.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/features/models/category_model.dart';
import 'package:cwt_starter_template/features/shop/cubit/brandShowcase/brand_showcase_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/brandShowcase/brand_showcase_state.dart';
import 'package:cwt_starter_template/features/shop/cubit/product/product_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/product/product_state.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/vertical_product_shimmer.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});
  final CategoryModel category;

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
              BlocBuilder<BrandShowcaseCubit, BrandShowcaseState>(
                builder: (context, state) {
                  if (state is BrandShowcaseLoading) {
                    return Column(
                      
                      children: [
                        TListTileShimmer(),
                        const SizedBox(height: 16),
                        TBoxesShimmer(),
                      ],
                    );
                  } else if (state is BrandShowcaseError) {
                    return Center(child: Text(state.message));
                  } else if (state is BrandShowcaseLoaded) {
                    final brands = state.showcases;
                    return ListView.builder(
                      itemBuilder: (_, index) {
                        final brand = brands[index];
                        return TBrandShowcase(
                          images: brand.thumbnails,
                          brand: brand,
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: brands.length,
                    );
                  }
                  return const SizedBox.shrink();
                },
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
                  } else if (state is ProductLoaded &&
                      state.featuredProducts == null) {
                    return const Center(child: Text('No products available'));
                  } else if (state is ProductLoaded) {
                    return GridLayout(
                      itemCount: state.products.length,
                      itemBuilder:
                          (_, index) => ProductCardVertical(
                            product: state.featuredProducts![index],
                          ),
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
