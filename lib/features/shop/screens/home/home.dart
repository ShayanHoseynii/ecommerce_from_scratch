import 'package:cwt_starter_template/common/widgets/containers/primary_header_container.dart';
import 'package:cwt_starter_template/common/widgets/containers/search_container.dart';
import 'package:cwt_starter_template/common/widgets/layout/grid_layout.dart';
import 'package:cwt_starter_template/common/widgets/products_card/products_card_vertical.dart';
import 'package:cwt_starter_template/common/widgets/shimmer/shimmer.dart';
import 'package:cwt_starter_template/common/widgets/texts/section_heading.dart';
import 'package:cwt_starter_template/data/repositories/banners/banners_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/banners/banners_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/product/product_cubit.dart';
import 'package:cwt_starter_template/features/authentication/cubit/product/product_state.dart';
import 'package:cwt_starter_template/features/shop/screens/home/controller/carusoul_cubit.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/home_categories.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:cwt_starter_template/features/shop/screens/home/widgets/vertical_product_shimmer.dart';
import 'package:cwt_starter_template/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Header ---
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // Appbar
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Searchbar
                  const TSearchContainer(text: 'Search in Store'),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Categories
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // --- Body ---
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => CarusoulCubit()),

                  BlocProvider(
                    create:
                        (context) =>
                            BannerCubit(context.read<BannersRepository>())
                              ..fetchBanners(),
                  ),
                ],
                child: Column(
                  children: [
                    // Promo Slider
                    const TPromoSlider(),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    // Popular Products
                    TSectionHeading(
                      title: 'Popular Products',
                      onPressed:
                          () =>
                              Navigator.of(context).pushNamed('/all-products'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: BlocBuilder<ProductCubit, ProductState>(
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
            ),
          ],
        ),
      ),
    );
  }
}
