import 'package:cwt_starter_template/common/widgets/appbar/appbar.dart';
import 'package:cwt_starter_template/common/widgets/brands/brand_card.dart';
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/brands_shimmer.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/data/repositories/products/product_repo.dart';
import 'package:cwt_starter_template/features/shop/cubit/all_products/all_products_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/brands/brands_cubit.dart';
import 'package:cwt_starter_template/features/shop/cubit/brands/brands_state.dart';
import 'package:cwt_starter_template/features/shop/screens/brands/brand_products.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              BlocBuilder<BrandsCubit, BrandsState>(
                builder: (context, state) {
                  if (state is BrandsLoading) {
                    return TBrandsShimmer(itemCount: 10);
                  } else if (state is BrandsFailure) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is BrandsLoaded &&
                      state.featuredBrands.isEmpty) {
                    return const Center(child: Text('No brands available'));
                  } else if (state is BrandsLoaded) {
                    return GridLayout(
                      itemCount: state.allBrands.length,
                      mainAxisExtent: 80,
                      itemBuilder:
                          (context, index) => BrandCard(
                            brand: state.allBrands[index],
                            showBorder: true,
                            onTap: () {
                              Navigator.of(
                                context,
                              ).push(MaterialPageRoute(builder: (newContext) => 
                                BlocProvider(
                                  create: (_) => AllProductsCubit(context.read<ProductRepository>())..fetchProductsByBrand(state.allBrands[index].id),
                                  child:  BrandProducts(brand: state.allBrands[index]),
                                ),
                              ));
                            },
                          ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              
              ),
            ],
          ),
        ),
      ),
    );
  }
}
